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

  @override
  @protected
  final log = getLogger('ReportService');

  final _alertService = serviceLocator<AlertService>();
  final _reportCache = serviceLocator<ReportCacheService>();
  final _userStorageService = serviceLocator<UserStorageService>();

  @override
  String get collectionPath => FirestoreCollections.reports;

  @override
  Report convertFromJson(Map<String, dynamic> json) => Report.fromJson(json);

  /// Holds all active feed states (all, trending, category_x)
  final ReactiveValue<Map<String, FeedPageState>> _feedStates = ReactiveValue({});

  final Set<String> _activeRealtimeFeeds = {};

  final Set<String> _pendingInteractionReportIds = {};

  Future<void> syncReportList() async {
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

Future<List<Report>> hydrateUserInteractionsBatch(List<Report> reports, String userId) async {
    if (reports.isEmpty) return reports;

    final firestore = FirebaseFirestore.instance;

    final futures = reports.map((report) async {
      final doc = await firestore
          .collection(collectionPath)
          .doc(report.reportData.reportId)
          .collection('interactions')
          .doc(userId)
          .get();

      if (!doc.exists) return report;

      final interaction = Interaction.fromJson(doc.data()!);

      return report.copyWith(
        hasLiked: interaction.hasLiked,
        hasDisliked: interaction.hasDisliked,
        hasBookmarked: interaction.hasBookmarked,
      );
    });

    return Future.wait(futures);
  }

  /// Loads the first page of a feed.
  Future<void> loadInitialFeed(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) async {
    final userId = _userStorageService.userId!;
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
      final hydratedCached = await hydrateUserInteractionsBatch(cached, userId);

      state
        ..items = hydratedCached
        ..lastDocument = null
        ..hasMore = true
        ..isLoadingFirstPage = false;
      notifyListeners();
    }

    final snapshot = await fetchQuerySnapshot(
      query: _buildFeedQuery(type, category: category, limit: limit),
    );

    final reports = snapshot.docs.map((d) => d.data()).toList();

    final hydratedReports = await hydrateUserInteractionsBatch(reports, userId);

    state
      ..items = hydratedReports
      ..lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null
      ..hasMore = snapshot.docs.length == limit
      ..isLoadingFirstPage = false;

    notifyListeners();

    // Cache the loaded feed
    await _reportCache.saveFeed(key, hydratedReports);
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
      final userId = _userStorageService.userId!;

      switch (change.type) {
        case DocumentChangeType.added:
          final hydrated = await hydrateUserInteractionsBatch([report], userId);
          _injectIntoFeed(type: type, category: category, report: hydrated.first);

        case DocumentChangeType.modified:

          final existing = _findReportById(report.reportData.reportId);

          if (existing == null) {
            _updateReportEverywhere(report);
            break;
          }

          final merged = report.copyWith(
            hasLiked: existing.hasLiked,
            hasDisliked: existing.hasDisliked,
            hasBookmarked: existing.hasBookmarked,

            reportData: report.reportData,
          );

          _updateReportEverywhere(merged);

          await _saveReportToAllFeedCaches(merged.reportData.reportId);

          _reconcileTrending(merged);

          _reconcileCategories(merged);

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
    final userId = _userStorageService.userId!;

    if (state.isLoadingNextPage || !state.hasMore || state.lastDocument == null) return;

    state.isLoadingNextPage = true;
    notifyListeners();

    final snapshot = await fetchQuerySnapshot(
      query: _buildFeedQuery(type, category: category, limit: limit).startAfterDocument(state.lastDocument!),
    );

    final newReports = snapshot.docs.map((d) => d.data()).toList();
    final existingIds = state.items.map((e) => e.reportData.reportId).toSet();

    final hydrated = await hydrateUserInteractionsBatch(newReports, userId);

    state.items.addAll(hydrated.where((r) => !existingIds.contains(r.reportData.reportId)));

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

    state.items.removeWhere((r) => r.reportData.reportId == report.reportData.reportId);

    state.items.add(report);

    state.items.sort((a, b) => b.reportData.createdAt.compareTo(a.reportData.createdAt));

    if (state.items.length > 100) {
      state.items = state.items.take(100).toList();
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

Future<void> toggleLike({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);

    final interactionRef = reportRef.collection('interactions').doc(userId);

    final interactionSnap = await interactionRef.get();

    final interaction = interactionSnap.exists
        ? Interaction.fromJson(interactionSnap.data()!)
        : Interaction(userId: userId);

    final likeDelta = interaction.hasLiked ? -1 : 1;
    final dislikeDelta = interaction.hasDisliked ? -1 : 0;

    final batch = firestore.batch()
      ..update(reportRef, {
        'reportData.likeCount': FieldValue.increment(likeDelta),
        if (dislikeDelta != 0) 'reportData.dislikeCount': FieldValue.increment(dislikeDelta),
      })
      ..set(
        interactionRef,
        interaction.copyWith(hasLiked: !interaction.hasLiked, hasDisliked: false, updatedAt: DateTime.now()).toJson(),
        SetOptions(merge: true),
      );

    await batch.commit();
  }

  Future<void> toggleDislike({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);

    final interactionRef = reportRef.collection('interactions').doc(userId);

    final interactionSnap = await interactionRef.get();

    final interaction = interactionSnap.exists
        ? Interaction.fromJson(interactionSnap.data()!)
        : Interaction(userId: userId);

    final dislikeDelta = interaction.hasDisliked ? -1 : 1;
    final likeDelta = interaction.hasLiked ? -1 : 0;

    final batch = firestore.batch()
      ..update(reportRef, {
        'reportData.dislikeCount': FieldValue.increment(dislikeDelta),
        if (likeDelta != 0) 'reportData.likeCount': FieldValue.increment(likeDelta),
      })
      ..set(
        interactionRef,
        interaction
            .copyWith(hasDisliked: !interaction.hasDisliked, hasLiked: false, updatedAt: DateTime.now())
            .toJson(),
        SetOptions(merge: true),
      );

    await batch.commit();
  }

  Future<void> toggleBookmark({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);

    final interactionRef = reportRef.collection('interactions').doc(userId);

    final interactionSnap = await interactionRef.get();

    final interaction = interactionSnap.exists
        ? Interaction.fromJson(interactionSnap.data()!)
        : Interaction(userId: userId);

    final delta = interaction.hasBookmarked ? -1 : 1;

    final batch = firestore.batch()
      ..update(reportRef, {'reportData.bookmarkCount': FieldValue.increment(delta)})
      ..set(
        interactionRef,
        interaction.copyWith(hasBookmarked: !interaction.hasBookmarked, updatedAt: DateTime.now()).toJson(),
        SetOptions(merge: true),
      );

    await batch.commit();
  }

  Report? _findReportById(String id) {
    for (final state in _feedStates.value.values) {
      final index = state.items.indexWhere((r) => r.reportData.reportId == id);

      if (index != -1) {
        return state.items[index];
      }
    }
    return null;
  }

  Future<void> _saveReportToAllFeedCaches(String reportId) async {
    for (final entry in _feedStates.value.entries) {
      final key = entry.key;
      final state = entry.value;

      final exists = state.items.any((r) => r.reportData.reportId == reportId);

      if (exists) {
        await _reportCache.saveFeed(key, state.items);
      }
    }
  }

  Future<void> optimisticToggleLike(Report report) async {
    final current = _findReportById(report.reportData.reportId);

    if (current == null) return;

    final updated = current.copyWith(
      hasLiked: !current.hasLiked,
      hasDisliked: false,
      reportData: current.reportData.copyWith(
        likeCount: current.hasLiked
            ? (current.reportData.likeCount - 1).clamp(0, 2147483647)
            : (current.reportData.likeCount + 1).clamp(0, 2147483647),
        dislikeCount: current.hasDisliked
            ? (current.reportData.dislikeCount - 1).clamp(0, 2147483647)
            : current.reportData.dislikeCount,
      ),
    );

    _updateReportEverywhere(updated);

    notifyListeners();

    await _saveReportToAllFeedCaches(updated.reportData.reportId);
  }

  Future<void> optimisticToggleDislike(Report report) async {
    final current = _findReportById(report.reportData.reportId);

    if (current == null) return;

    final updatedReport = current.copyWith(
      hasDisliked: !current.hasDisliked,
      hasLiked: false,
      reportData: current.reportData.copyWith(
        dislikeCount: current.hasDisliked
            ? (current.reportData.dislikeCount - 1).clamp(0, 2147483647)
            : (current.reportData.dislikeCount + 1).clamp(0, 2147483647),
        likeCount: current.hasLiked
            ? (current.reportData.likeCount - 1).clamp(0, 2147483647)
            : current.reportData.likeCount,
      ),
    );

    _updateReportEverywhere(updatedReport);

    notifyListeners();

    await _saveReportToAllFeedCaches(updatedReport.reportData.reportId);
  }

  Future<void> optimisticToggleBookmark(Report report) async {
    final current = _findReportById(report.reportData.reportId);

    if (current == null) return;

    final updatedReport = current.copyWith(
      hasBookmarked: !current.hasBookmarked,
      reportData: current.reportData.copyWith(
        bookmarkCount: current.hasBookmarked
            ? (current.reportData.bookmarkCount - 1).clamp(0, 2147483647)
            : (current.reportData.bookmarkCount + 1).clamp(0, 2147483647),
      ),
    );

    _updateReportEverywhere(updatedReport);

    notifyListeners();
    await _saveReportToAllFeedCaches(updatedReport.reportData.reportId);
  }

  Future<void> likeReportOptimistic(Report report, String userId) async {
    final reportId = report.reportData.reportId;

    if (_pendingInteractionReportIds.contains(reportId)) return;

    _pendingInteractionReportIds.add(reportId);

    await optimisticToggleLike(report);

    try {
      await toggleLike(reportId: reportId, userId: userId);
    } catch (e, stack) {
      log.e('Like failed, reverting', error: e, stackTrace: stack);
    } finally {
      _pendingInteractionReportIds.remove(reportId);
    }
  }

  Future<void> dislikeReportOptimistic(Report report, String userId) async {
    final reportId = report.reportData.reportId;

    if (_pendingInteractionReportIds.contains(reportId)) return;

    _pendingInteractionReportIds.add(reportId);

    await optimisticToggleDislike(report);

    try {
      await toggleDislike(reportId: reportId, userId: userId);
    } catch (e, stack) {
      log.e('Dislike failed, reverting', error: e, stackTrace: stack);
    } finally {
      _pendingInteractionReportIds.remove(reportId);
    }
  }

  Future<void> bookmarkReportOptimistic(Report report, String userId) async {
    final reportId = report.reportData.reportId;

    if (_pendingInteractionReportIds.contains(reportId)) return;

    _pendingInteractionReportIds.add(reportId);

    await optimisticToggleBookmark(report);

    try {
      await toggleBookmark(reportId: reportId, userId: userId);
    } catch (e, stack) {
      log.e('Bookmark failed, reverting', error: e, stackTrace: stack);
    } finally {
      _pendingInteractionReportIds.remove(reportId);
    }
  }

  Future<void> loadFeedsFromCache() async {
    // Load ALL feed
    final userId = _userStorageService.userId!;

    final allKey = _feedKey(ReportFeedType.all);
    final allCached = _reportCache.loadFeed(allKey);

    if (allCached != null) {
      final hydratedReports = await hydrateUserInteractionsBatch(allCached, userId);
      _stateFor(allKey).items = hydratedReports;
      notifyListeners();
    }

    // Load TRENDING feed
    final trendingKey = _feedKey(ReportFeedType.trending);
    final trendingCached = _reportCache.loadFeed(trendingKey);

    if (trendingCached != null) {
      final hydratedReports = await hydrateUserInteractionsBatch(trendingCached, userId);
      _stateFor(trendingKey).items = hydratedReports;
      notifyListeners();
    }

    // Load CATEGORY feeds
    for (final category in CategoryType.values) {
      final key = _feedKey(ReportFeedType.category, category: category);

      final cached = _reportCache.loadFeed(key);

      if (cached != null) {
        final hydratedReports = await hydrateUserInteractionsBatch(cached, userId);
        _stateFor(key).items = hydratedReports;
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
