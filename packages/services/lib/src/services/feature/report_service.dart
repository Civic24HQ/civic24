import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:services/src/services/firebase/firebase_storage_service.dart';
import 'package:services/src/services/firebase/firestore_collection_service.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

/// Holds pagination and loading state for a single feed.
class FeedPageState {
  List<Report> items = [];
  QueryDocumentSnapshot<Report>? lastDocument;
  StreamSubscription<QuerySnapshot<Report>>? liveSubscription;
  bool hasMore = true;
  bool isLoadingFirstPage = false;
  bool isLoadingNextPage = false;
  Future<void> dispose() async {
    await liveSubscription?.cancel();
    liveSubscription = null;
  }
}

// This class is responsible for managing report data related operations
// such as fetching report data, updating report information, etc.
class ReportService extends FirestoreCollectionService<Report> with ListenableServiceMixin, FirebaseStorageService {
  ReportService() {
    _init();
  }

  @override
  @protected
  final log = getLogger('ReportService');

  final _alertService = serviceLocator<AlertService>();
  final _reportCache = serviceLocator<ReportCacheService>();

  @override
  String get collectionPath => FirestoreCollections.reports;

  @override
  Report convertFromJson(Map<String, dynamic> json) => Report.fromJson(json);

  /// Holds all active feed states (all, trending, category_x)
  final ReactiveValue<Map<String, FeedPageState>> _feedStates = ReactiveValue({});

  final Set<String> _activeRealtimeFeeds = {};

  Future<void> _init() async {
    listenToReactiveValues([_feedStates]);
    await loadFeedsFromCache();
  }

  /// Builds a unique key representing a feed.
  @protected
  String _feedKey(ReportFeedType type, {CategoryType? category}) {
    if (type == ReportFeedType.category) {
      return 'category_${category!.name}';
    }
    return type.name;
  }

  @protected
  FeedPageState _stateFor(String key) {
    return _feedStates.value.putIfAbsent(key, FeedPageState.new);
  }

  List<Report> getFeedItems(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.items ?? [];

  bool isInitialReportLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingFirstPage ?? false;

  bool isPaginationLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingNextPage ?? false;

  bool hasMore(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.hasMore ?? true;

  /// Builds a Firestore query for a specific feed.
  @protected
  Query<Report> _buildFeedQuery(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) {
    Query<Report> query = collectionReference;

    switch (type) {
      case ReportFeedType.all:
        query = query.orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.trending:
        query = query
            .orderBy('reportData.likeCount', descending: true)
            .orderBy('reportData.updatedAt', descending: true);

      case ReportFeedType.category:
        query = query
            .where('reportData.categoryTypes', arrayContains: category!.name)
            .orderBy('reportData.createdAt', descending: true);
    }

    return query.limit(limit);
  }

  /// Builds a Firestore query for real-time updates of a specific feed.
  @protected
  Query<Report> _buildRealtimeQuery(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) {
    Query<Report> query = collectionReference;

    switch (type) {
      case ReportFeedType.all:
        query = query.orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.trending:
        query = query
            .orderBy('reportData.likeCount', descending: true)
            .orderBy('reportData.updatedAt', descending: true);

      case ReportFeedType.category:
        query = query
            .where('reportData.categoryTypes', arrayContains: category!.name)
            .orderBy('reportData.createdAt', descending: true);
    }

    return query.limit(limit);
  }

  /// Loads the first page of a feed.
  Future<void> loadInitialFeed(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) async {
    final key = _feedKey(type, category: category);
    final state = _stateFor(key);

    if (state.isLoadingFirstPage) return;

    state
      ..isLoadingFirstPage = true
      ..hasMore = true
      ..lastDocument = null;

    notifyListeners();

    // Load from cache first for instant UI response
    final cached = _reportCache.loadFeed(key);
    if (cached != null && cached.isNotEmpty) {
      state
        ..items = cached
        ..lastDocument = null
        ..hasMore = true
        ..isLoadingFirstPage = false;
      notifyListeners();
    }

    final snapshot = await fetchQuerySnapshot(
      query: _buildFeedQuery(type, category: category, limit: limit),
    );

    final reports = snapshot.docs.map((d) => d.data()).toList();

    state
      ..items = reports
      ..lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null
      ..hasMore = snapshot.docs.length == limit
      ..isLoadingFirstPage = false;

    notifyListeners();

    // Cache the loaded feed
    await _reportCache.saveFeed(key, reports);
  }

  void _removeFromFeed({required ReportFeedType type, required String reportId, CategoryType? category}) {
    final state = _stateFor(_feedKey(type, category: category));
    state.items.removeWhere((r) => r.reportData.reportId == reportId);
  }

  Future<void> _handleRealtimeChanges(
    QuerySnapshot<Report> snapshot,
    ReportFeedType type,
    CategoryType? category,
  ) async {
    for (final change in snapshot.docChanges) {
      final report = change.doc.data();
      final id = report!.reportData.reportId;

      switch (change.type) {
        case DocumentChangeType.added:
          _injectIntoFeed(type: type, category: category, report: report);

        case DocumentChangeType.modified:
          _updateReportEverywhere(report);
          _reconcileTrending(report);
          _reconcileCategories(report);

        case DocumentChangeType.removed:
          _removeFromFeed(type: type, category: category, reportId: id);
      }
    }

    notifyListeners();
    await _reportCache.saveFeed(
      _feedKey(type, category: category),
      _stateFor(_feedKey(type, category: category)).items,
    );
  }

  // Starts a real-time listener for a feed to receive live updates.
  Future<void> startRealtimeFeed(ReportFeedType type, {CategoryType? category}) async {
    final key = _feedKey(type, category: category);

    // Prevent duplicate listeners
    if (_activeRealtimeFeeds.contains(key)) {
      log.d('Realtime feed already active: $key');
      return;
    }

    final state = _stateFor(key);

    log.i('Starting realtime listener for feed: $key');

    final query = _buildRealtimeQuery(type, category: category);

    state.liveSubscription = subscribeSnapshotWithQuery(query: query).listen(
      (QuerySnapshot<Report> snapshot) => _handleRealtimeChanges(snapshot, type, category),
      onError: (e) => log.e('Realtime listener error for $key', error: e),
    );

    _activeRealtimeFeeds.add(key);
  }

  // Prevents Memory leaks by cancelling the real-time listener when it's no longer needed.
  Future<void> stopRealtimeFeed(ReportFeedType type, {CategoryType? category}) async {
    final key = _feedKey(type, category: category);

    if (!_activeRealtimeFeeds.contains(key)) return;

    final state = _feedStates.value[key];

    log.i('Stopping realtime listener: $key');

    await state?.liveSubscription?.cancel();

    state?.liveSubscription = null;

    _activeRealtimeFeeds.remove(key);
  }

  /// Loads the next page for a feed.
  Future<void> loadMoreFeed(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) async {
    final key = _feedKey(type, category: category);
    final state = _stateFor(key);

    if (state.isLoadingNextPage || !state.hasMore || state.lastDocument == null) return;

    state.isLoadingNextPage = true;
    notifyListeners();

    final snapshot = await fetchQuerySnapshot(
      query: _buildFeedQuery(type, category: category, limit: limit).startAfterDocument(state.lastDocument!),
    );

    final newReports = snapshot.docs.map((d) => d.data()).toList();
    final existingIds = state.items.map((e) => e.reportData.reportId).toSet();

    state.items.addAll(newReports.where((r) => !existingIds.contains(r.reportData.reportId)));

    state
      ..lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : state.lastDocument
      ..hasMore = snapshot.docs.length == limit
      ..isLoadingNextPage = false;

    notifyListeners();

    // Save Cache Feed After Pagination
    await _reportCache.saveFeed(key, state.items);
  }

  // Refreshes the specified feed by resetting its state and loading the initial feed.
  Future<void> refreshFeed(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) async {
    final key = _feedKey(type, category: category);

    final wasActive = _activeRealtimeFeeds.contains(key);

    await stopRealtimeFeed(type, category: category);

    _feedStates.value.remove(key);

    await loadInitialFeed(type, category: category, limit: limit);

    if (wasActive) {
      await startRealtimeFeed(type, category: category);
    }
  }

  /// Inserts a report at the top of a feed without breaking pagination.
  @protected
  void _injectIntoFeed({required ReportFeedType type, required Report report, CategoryType? category}) {
    final state = _stateFor(_feedKey(type, category: category));
    final id = report.reportData.reportId;

    if (state.items.any((r) => r.reportData.reportId == id)) return;

    state.items.insert(0, report);

    const maxCache = 100;
    if (state.items.length > maxCache) {
      state.items = state.items.take(maxCache).toList();
    }
  }

  @protected
  void _updateReportEverywhere(Report updated) {
    final id = updated.reportData.reportId;

    for (final state in _feedStates.value.values) {
      final index = state.items.indexWhere((r) => r.reportData.reportId == id);
      if (index != -1) state.items[index] = updated;
    }
  }

  @protected
  void _reconcileTrending(Report report) {
    final state = _stateFor(_feedKey(ReportFeedType.trending));
    final exists = state.items.any((r) => r.reportData.reportId == report.reportData.reportId);
    final qualifies = _qualifiesForTrending(report);

    if (qualifies && !exists) {
      _injectIntoFeed(type: ReportFeedType.trending, report: report);
    } else if (!qualifies && exists) {
      state.items.removeWhere((r) => r.reportData.reportId == report.reportData.reportId);
    }
  }

  @protected
  void _reconcileCategories(Report report) {
    final id = report.reportData.reportId;

    for (final entry in _feedStates.value.entries) {
      if (!entry.key.startsWith('category_')) continue;

      final state = entry.value;
      final category = CategoryType.values.byName(entry.key.replaceFirst('category_', ''));

      final belongs = report.reportData.categoryTypes.contains(category);
      final exists = state.items.any((r) => r.reportData.reportId == id);

      if (belongs && !exists) {
        _injectIntoFeed(type: ReportFeedType.category, category: category, report: report);
      } else if (!belongs && exists) {
        state.items.removeWhere((r) => r.reportData.reportId == id);
      }
    }
  }

  bool _qualifiesForTrending(Report report) => report.reportData.likeCount >= 5;

  /// Creates a new report and injects it into relevant feeds.
  Future<void> addReport(Report report) async {
    try {
      final id = generateNewDocId();
      final now = DateTime.now().toUtc();

      final newReport = report.copyWith(
        reportData: report.reportData.copyWith(reportId: id, createdAt: now, updatedAt: now),
      );

      // Inject into feeds BEFORE network call for instant UI response
      _injectIntoFeed(type: ReportFeedType.all, report: newReport);

      await _reportCache.saveFeed(_feedKey(ReportFeedType.all), _stateFor(_feedKey(ReportFeedType.all)).items);

      if (_qualifiesForTrending(newReport)) {
        _injectIntoFeed(type: ReportFeedType.trending, report: newReport);
        await _reportCache.saveFeed(
          _feedKey(ReportFeedType.trending),
          _stateFor(_feedKey(ReportFeedType.trending)).items,
        );
      }

      for (final category in newReport.reportData.categoryTypes) {
        final key = _feedKey(ReportFeedType.category, category: category);
        _injectIntoFeed(type: ReportFeedType.category, category: category, report: newReport);
        await _reportCache.saveFeed(key, _stateFor(key).items);
      }

      notifyListeners();

      await create(documentId: id, payload: newReport);
    } catch (e) {
      log.e('Failed to create report', error: e);
      _alertService.showErrorAlert(title: 'Report Creation Failed', message: 'Please try again.');
    }
  }

  Future<void> updateReport(Report report) async {
    try {
      final updated = report.copyWith(reportData: report.reportData.copyWith(updatedAt: DateTime.now().toUtc()));

      await update(documentId: updated.reportData.reportId, payload: updated);

      _updateReportEverywhere(updated);
      _reconcileTrending(updated);
      _reconcileCategories(updated);

      notifyListeners();
      for (final entry in _feedStates.value.entries) {
        await _reportCache.saveFeed(entry.key, entry.value.items);
      }
    } catch (e) {
      log.e('Failed to update report', error: e);
      _alertService.showErrorAlert(title: 'Update Failed', message: 'Could not update report.');
    }
  }

  Future<void> loadFeedsFromCache() async {
    // Load ALL feed
    final allKey = _feedKey(ReportFeedType.all);
    final allCached = _reportCache.loadFeed(allKey);
    if (allCached != null) {
      _stateFor(allKey).items = allCached;
    }

    // Load TRENDING feed
    final trendingKey = _feedKey(ReportFeedType.trending);
    final trendingCached = _reportCache.loadFeed(trendingKey);
    if (trendingCached != null) {
      _stateFor(trendingKey).items = trendingCached;
    }

    // Load CATEGORY feeds
    for (final category in CategoryType.values) {
      final key = _feedKey(ReportFeedType.category, category: category);
      final cached = _reportCache.loadFeed(key);
      if (cached != null) {
        _stateFor(key).items = cached;
      }
    }

    notifyListeners();
  }

  Future<void> stopAllRealtimeFeeds() async {
    for (final key in _activeRealtimeFeeds.toList()) {
      final state = _feedStates.value[key];

      await state?.liveSubscription?.cancel();

      state?.liveSubscription = null;
    }

    _activeRealtimeFeeds.clear();
  }

  Future<void> dispose() async {
    log.i('Disposing ReportService and cancelling all feed subscriptions');
    await stopAllRealtimeFeeds();
    for (final state in _feedStates.value.values) {
      await state.dispose();
    }
    _feedStates.value.clear();
    _activeRealtimeFeeds.clear();
  }
}
