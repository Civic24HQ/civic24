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
  QueryDocumentSnapshot? lastDocument;
  StreamSubscription<dynamic>? liveSubscription;
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
  final _internetConnectivityService = serviceLocator<InternetConnectivityService>();

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
    final map = _feedStates.value;

    if (!map.containsKey(key)) {
      final newMap = {...map};
      newMap[key] = FeedPageState();
      _feedStates.value = newMap;
    }

    return _feedStates.value[key]!;
  }

  List<Report> getFeedItems(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.items ?? [];

  bool isInitialReportLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingFirstPage ?? false;

  bool isPaginationLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingNextPage ?? false;

  bool hasMore(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.hasMore ?? true;

  void _commitFeedMutation() {
    _feedStates.value = {..._feedStates.value};
    notifyListeners();
  }

  @protected
  Future<QuerySnapshot<Map<String, dynamic>>> _getBookmarkedInteractionSnapshot({
    QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc,
    int limit = kPageLimit,
  }) async {
    var query = FirebaseFirestore.instance
        .collection('users')
        .doc(_userStorageService.userId)
        .collection('interactions')
        .where('hasBookmarked', isEqualTo: true)
        .orderBy('updatedAt', descending: true)
        .limit(limit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    return query.get();
  }

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
            .orderBy('reportData.updatedAt', descending: true)
            .orderBy('reportData.reportId', descending: true);

      case ReportFeedType.category:
        query = query
            .where('reportData.categoryTypes', arrayContains: category!.name)
            .orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.userReports:
        query = query
            .where('reportData.userId', isEqualTo: _userStorageService.userId)
            .orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.userBookmarks:
        throw UnsupportedError('userBookmarkedReports does not use _buildFeedQuery.');
    }

    return query.limit(limit);
  }

  /// Builds a Firestore query for real-time updates of a specific feed.
  @protected
  Query<Report> _buildRealtimeQuery(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) {
    return _buildFeedQuery(type, category: category, limit: limit);
  }

  Future<List<Report>> hydrateUserInteractionsBatch(List<Report> reports, String userId) async {
    if (reports.isEmpty) return reports;

    final firestore = FirebaseFirestore.instance;
    final reportIds = reports.map((r) => r.reportData.reportId).toList();
    final interactionMap = <String, Interaction>{};

    final chunks = <List<String>>[];

    for (var i = 0; i < reportIds.length; i += 30) {
      chunks.add(reportIds.sublist(i, i + 30 > reportIds.length ? reportIds.length : i + 30));
    }

    final futures = chunks.map((chunk) {
      return firestore
          .collection('users')
          .doc(userId)
          .collection('interactions')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
    });

    final snapshots = await Future.wait(futures);

    for (final snapshot in snapshots) {
      for (final doc in snapshot.docs) {
        interactionMap[doc.id] = Interaction.fromJson(doc.data());
      }
    }

    return reports.map((report) {
      final interaction = interactionMap[report.reportData.reportId];

      if (interaction == null) return report;

      return report.copyWith(
        hasLiked: interaction.hasLiked,
        hasDisliked: interaction.hasDisliked,
        hasBookmarked: interaction.hasBookmarked,
      );
    }).toList();
  }

  /// Loads the first page of a feed.
  Future<void> loadInitialFeed(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) async {
    if (type == ReportFeedType.userBookmarks) {
      await loadInitialUserBookmarks(limit: limit);
      return;
    }
    final userId = _userStorageService.userId!;
    final key = _feedKey(type, category: category);
    final state = _stateFor(key);

    if (state.items.isNotEmpty) return;

    final cached = _reportCache.loadFeed(key);

    if (cached != null && cached.isNotEmpty) {
      state.items = cached;
      _commitFeedMutation();
    } else {
      state.isLoadingFirstPage = true;
      _commitFeedMutation();
    }

    if (!_internetConnectivityService.isConnected) {
      state.isLoadingFirstPage = false;
      _commitFeedMutation();
      return;
    }

    try {
      final snapshot = await fetchQuerySnapshot(query: _buildFeedQuery(type, category: category));

      final reports = snapshot.docs.map((d) => d.data()).toList();
      final hydrated = await hydrateUserInteractionsBatch(reports, userId);

      state
        ..items = hydrated
        ..lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null
        ..hasMore = snapshot.docs.length == limit
        ..isLoadingFirstPage = false;

      _commitFeedMutation();

      await _reportCache.saveFeed(key, hydrated);
    } catch (e) {
      state.isLoadingFirstPage = false;
      _commitFeedMutation();
    }
  }

  Future<void> loadInitialUserBookmarks({int limit = kPageLimit}) async {
    final key = _feedKey(ReportFeedType.userBookmarks);
    final state = _stateFor(key);

    if (state.items.isNotEmpty) return;

    state.isLoadingFirstPage = true;
    _commitFeedMutation();

    try {
      final interactionSnapshot = await _getBookmarkedInteractionSnapshot(limit: limit);

      final reportIds = interactionSnapshot.docs.map((d) => d.id).toList();

      if (reportIds.isEmpty) {
        state
          ..items = []
          ..isLoadingFirstPage = false
          ..hasMore = false;

        _commitFeedMutation();
        return;
      }

      final reportSnapshot = await FirebaseFirestore.instance
          .collection(collectionPath)
          .where(FieldPath.documentId, whereIn: reportIds)
          .get();

      final reportMap = {for (final doc in reportSnapshot.docs) doc.id: convertFromJson(doc.data())};

      final orderedReports = reportIds.where(reportMap.containsKey).map((id) => reportMap[id]!).toList();

      final hydrated = await hydrateUserInteractionsBatch(orderedReports, _userStorageService.userId!);

      state
        ..items = hydrated
        ..isLoadingFirstPage = false
        ..hasMore = interactionSnapshot.docs.length == limit
        ..lastDocument = interactionSnapshot.docs.isNotEmpty ? interactionSnapshot.docs.last : null;

      _commitFeedMutation();

      await _reportCache.saveFeed(key, hydrated);
    } catch (e) {
      state.isLoadingFirstPage = false;
      _commitFeedMutation();
    }
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
    if (_stateFor(_feedKey(type, category: category)).items.isNotEmpty && snapshot.metadata.isFromCache) {
      return;
    }
    final userId = _userStorageService.userId!;

    final changedReports = snapshot.docChanges.where((c) => c.doc.data() != null).map((c) => c.doc.data()!).toList();

    if (changedReports.isEmpty) return;

    final hydrated = await hydrateUserInteractionsBatch(changedReports, userId);

    for (var i = 0; i < snapshot.docChanges.length; i++) {
      final change = snapshot.docChanges[i];
      final report = hydrated[i];
      final id = report.reportData.reportId;

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

    _commitFeedMutation();

    await _reportCache.saveFeed(
      _feedKey(type, category: category),
      _stateFor(_feedKey(type, category: category)).items,
    );
  }

  // Starts a real-time listener for a feed to receive live updates.
  Future<void> startRealtimeFeed(ReportFeedType type, {CategoryType? category}) async {
    if (type == ReportFeedType.userBookmarks) {
      await startRealtimeUserBookmarks();
      return;
    }
    final key = _feedKey(type, category: category);

    if (_activeRealtimeFeeds.contains(key)) return;

    final state = _stateFor(key);

    final query = _buildRealtimeQuery(type, category: category);

    state.liveSubscription = subscribeSnapshotWithQuery(query: query).listen(
      (snapshot) => _handleRealtimeChanges(snapshot, type, category),
      onError: (e) => log.e('Realtime listener error for $key', error: e),
    );

    _activeRealtimeFeeds.add(key);
  }

  Future<void> startRealtimeUserBookmarks() async {
    final key = _feedKey(ReportFeedType.userBookmarks);

    if (_activeRealtimeFeeds.contains(key)) return;

    final state = _stateFor(key);

    // ignore: cascade_invocations
    state.liveSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(_userStorageService.userId)
        .collection('interactions')
        .where('hasBookmarked', isEqualTo: true)
        .snapshots()
        .listen((snapshot) async {
          for (final change in snapshot.docChanges) {
            if (snapshot.metadata.isFromCache) return;
            final reportId = change.doc.id;

            switch (change.type) {
              case DocumentChangeType.added:
                final exists = state.items.any((r) => r.reportData.reportId == reportId);

                if (exists) break;

                final reportDoc = await FirebaseFirestore.instance.collection(collectionPath).doc(reportId).get();

                if (!reportDoc.exists) break;

                final report = convertFromJson(reportDoc.data()!);

                final hydrated = await hydrateUserInteractionsBatch([report], _userStorageService.userId!);

                _injectIntoFeed(type: ReportFeedType.userBookmarks, report: hydrated.first);

              case DocumentChangeType.removed:
                _removeFromFeed(type: ReportFeedType.userBookmarks, reportId: reportId);

              case DocumentChangeType.modified:
            }
          }

          _commitFeedMutation();
        });

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
    if (type == ReportFeedType.userBookmarks) {
      await loadMoreUserBookmarks(limit: limit);
      return;
    }
    final key = _feedKey(type, category: category);
    final state = _stateFor(key);
    final userId = _userStorageService.userId!;

    if (state.isLoadingNextPage || !state.hasMore || state.lastDocument == null) return;

    state.isLoadingNextPage = true;
    _commitFeedMutation();

    try {
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

      _commitFeedMutation();

      await _reportCache.saveFeed(key, state.items);
    } catch (e, stack) {
      log.e('Pagination failed', error: e, stackTrace: stack);
      state.isLoadingNextPage = false;
      _commitFeedMutation();
    }
  }

  Future<void> loadMoreUserBookmarks({int limit = kPageLimit}) async {
    final key = _feedKey(ReportFeedType.userBookmarks);
    final state = _stateFor(key);

    if (state.isLoadingNextPage || !state.hasMore) return;

    state.isLoadingNextPage = true;
    _commitFeedMutation();

    final interactionSnapshot = await _getBookmarkedInteractionSnapshot(
      lastDoc: state.lastDocument as QueryDocumentSnapshot<Map<String, dynamic>>?,
      limit: limit,
    );

    final reportIds = interactionSnapshot.docs.map((d) => d.id).toList();

    final reportSnapshot = await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(FieldPath.documentId, whereIn: reportIds)
        .get();

    final reportMap = {for (final doc in reportSnapshot.docs) doc.id: convertFromJson(doc.data())};

    final orderedReports = reportIds.where(reportMap.containsKey).map((id) => reportMap[id]!).toList();

    final hydrated = await hydrateUserInteractionsBatch(orderedReports, _userStorageService.userId!);

    final existingIds = state.items.map((r) => r.reportData.reportId).toSet();

    state.items.addAll(hydrated.where((r) => !existingIds.contains(r.reportData.reportId)));

    state
      ..isLoadingNextPage = false
      ..hasMore = interactionSnapshot.docs.length == limit
      ..lastDocument = interactionSnapshot.docs.isNotEmpty ? interactionSnapshot.docs.last : state.lastDocument;

    _commitFeedMutation();

    await _reportCache.saveFeed(key, state.items);
  }

  // Refreshes the specified feed by resetting its state and loading the initial feed.
  Future<void> refreshFeed(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) async {
    final key = _feedKey(type, category: category);
    final wasActive = _activeRealtimeFeeds.contains(key);

    await stopRealtimeFeed(type, category: category);

    final state = _stateFor(key);

    // ignore: cascade_invocations
    state
      ..lastDocument = null
      ..hasMore = true
      ..isLoadingNextPage = false;

    if (state.items.isEmpty) {
      state.isLoadingFirstPage = true;
    }

    _commitFeedMutation();

    try {
      if (type == ReportFeedType.userBookmarks) {
        await loadInitialUserBookmarks(limit: limit);
      } else {
        await loadInitialFeed(type, category: category, limit: limit);
      }
    } finally {
      state.isLoadingFirstPage = false;
      _commitFeedMutation();
    }

    if (wasActive) {
      if (type == ReportFeedType.userBookmarks) {
        await startRealtimeUserBookmarks();
      } else {
      await startRealtimeFeed(type, category: category);
    }
  }
}

  /// Inserts a report at the top of a feed without breaking pagination.
  @protected
  void _injectIntoFeed({required ReportFeedType type, required Report report, CategoryType? category}) {
    final state = _stateFor(_feedKey(type, category: category));

    state.items.removeWhere((r) => r.reportData.reportId == report.reportData.reportId);

    state.items.insert(0, report);

    switch (type) {
      case ReportFeedType.all:
      case ReportFeedType.category:
      case ReportFeedType.userReports:
        state.items.sort((a, b) => b.reportData.createdAt.compareTo(a.reportData.createdAt));

      case ReportFeedType.trending:
        state.items.sort((a, b) {
          final likeCompare = b.reportData.likeCount.compareTo(a.reportData.likeCount);

          if (likeCompare != 0) return likeCompare;

          return b.reportData.updatedAt.compareTo(a.reportData.updatedAt);
        });

      case ReportFeedType.userBookmarks:
        state.items.sort((a, b) => b.reportData.updatedAt.compareTo(a.reportData.updatedAt));
    }

    if (state.items.length > 100) {
      state.items = state.items.take(100).toList();
    }

    _commitFeedMutation();
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

      _injectIntoFeed(type: ReportFeedType.all, report: newReport);

      await _reportCache.saveFeed(_feedKey(ReportFeedType.all), _stateFor(_feedKey(ReportFeedType.all)).items);

      if (newReport.reportData.userId == _userStorageService.userId) {
        _injectIntoFeed(type: ReportFeedType.userReports, report: newReport);

        await _reportCache.saveFeed(
          _feedKey(ReportFeedType.userReports),
          _stateFor(_feedKey(ReportFeedType.userReports)).items,
        );
      }

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

  // Updates an existing report and reconciles its position in relevant feeds.
  Future<void> updateReport(Report report) async {
    try {
      final updated = report.copyWith(reportData: report.reportData.copyWith(updatedAt: DateTime.now().toUtc()));

      await update(documentId: updated.reportData.reportId, payload: updated);

      _updateReportEverywhere(updated);
      _reconcileTrending(updated);
      _reconcileCategories(updated);

      if (updated.reportData.userId == _userStorageService.userId) {
        final state = _stateFor(_feedKey(ReportFeedType.userReports));

        final exists = state.items.any((r) => r.reportData.reportId == updated.reportData.reportId);

        if (!exists) {
          _injectIntoFeed(type: ReportFeedType.userReports, report: updated);
        }
      }

      notifyListeners();
      for (final entry in _feedStates.value.entries) {
        await _reportCache.saveFeed(entry.key, entry.value.items);
      }
    } catch (e) {
      log.e('Failed to update report', error: e);
      _alertService.showErrorAlert(title: 'Update Failed', message: 'Could not update report.');
    }
  }

  // Toggles like status of a report and updates the feed accordingly.
  Future<void> toggleLike({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);
    final interactionRef = firestore.collection('users').doc(userId).collection('interactions').doc(reportId);

    await firestore.runTransaction((tx) async {
      final interactionSnap = await tx.get(interactionRef);

      var hasLiked = false;
      var hasDisliked = false;

      if (interactionSnap.exists) {
        final data = interactionSnap.data()!;
        hasLiked = (data['hasLiked'] ?? false) as bool;
        hasDisliked = (data['hasDisliked'] ?? false) as bool;
      }

      var likeDelta = 0;
      var dislikeDelta = 0;

      if (hasLiked) {
        likeDelta = -1;
        hasLiked = false;
      } else {
        likeDelta = 1;
        hasLiked = true;

        if (hasDisliked) {
          dislikeDelta = -1;
          hasDisliked = false;
        }
      }

      tx
        ..update(reportRef, {
          'reportData.likeCount': FieldValue.increment(likeDelta),
          if (dislikeDelta != 0) 'reportData.dislikeCount': FieldValue.increment(dislikeDelta),
        })
        ..set(interactionRef, {
          'hasLiked': hasLiked,
          'hasDisliked': hasDisliked,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
    });
  }

  // Toggles dislike status of a report and updates the feed accordingly.
  Future<void> toggleDislike({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);
    final interactionRef = firestore.collection('users').doc(userId).collection('interactions').doc(reportId);

    await firestore.runTransaction((tx) async {
      final interactionSnap = await tx.get(interactionRef);

      var hasLiked = false;
      var hasDisliked = false;

      if (interactionSnap.exists) {
        final data = interactionSnap.data()!;
        hasLiked = (data['hasLiked'] ?? false) as bool;
        hasDisliked = (data['hasDisliked'] ?? false) as bool;
      }

      var dislikeDelta = 0;
      var likeDelta = 0;

      if (hasDisliked) {
        dislikeDelta = -1;
        hasDisliked = false;
      } else {
        dislikeDelta = 1;
        hasDisliked = true;

        if (hasLiked) {
          likeDelta = -1;
          hasLiked = false;
        }
      }

      tx
        ..update(reportRef, {
          'reportData.dislikeCount': FieldValue.increment(dislikeDelta),
          if (likeDelta != 0) 'reportData.likeCount': FieldValue.increment(likeDelta),
        })
        ..set(interactionRef, {
          'hasLiked': hasLiked,
          'hasDisliked': hasDisliked,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
    });
  }

  // Toggles bookmark status of a report and updates the feed accordingly.
  Future<void> toggleBookmark({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);
    final interactionRef = firestore.collection('users').doc(userId).collection('interactions').doc(reportId);

    await firestore.runTransaction((tx) async {
      final interactionSnap = await tx.get(interactionRef);

      var hasBookmarked = false;

      if (interactionSnap.exists) {
        final data = interactionSnap.data()!;
        hasBookmarked = (data['hasBookmarked'] ?? false) as bool;
      }

      final delta = hasBookmarked ? -1 : 1;

      tx
        ..update(reportRef, {'reportData.bookmarkCount': FieldValue.increment(delta)})
        ..set(interactionRef, {
          'hasBookmarked': !hasBookmarked,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
    });
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

  // Optimistically toggles like status of a report in the feed and reverts if the server update fails.
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
    _commitFeedMutation();
    await _saveReportToAllFeedCaches(updated.reportData.reportId);
  }

  // Optimistically toggles dislike status of a report in the feed and reverts if the server update fails.
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
    _commitFeedMutation();
    await _saveReportToAllFeedCaches(updatedReport.reportData.reportId);
  }

  // Optimistically toggles bookmark status of a report in the feed and reverts if the server update fails.
  Future<void> optimisticToggleBookmark(Report report) async {
    final current = _findReportById(report.reportData.reportId);
    if (current == null) return;

    final id = current.reportData.reportId;
    final isBookmarking = !current.hasBookmarked;

    final updated = current.copyWith(
      hasBookmarked: isBookmarking,
      reportData: current.reportData.copyWith(
        bookmarkCount: isBookmarking
            ? current.reportData.bookmarkCount + 1
            : (current.reportData.bookmarkCount - 1).clamp(0, 2147483647),
        updatedAt: DateTime.now().toUtc(),
      ),
    );

    _updateReportEverywhere(updated);

    final bookmarkKey = _feedKey(ReportFeedType.userBookmarks);
    final bookmarkState = _feedStates.value[bookmarkKey];

    if (isBookmarking) {
      final exists = bookmarkState?.items.any((r) => r.reportData.reportId == id);

      if (exists != true) {
        _injectIntoFeed(type: ReportFeedType.userBookmarks, report: updated);
      }
    } else {
      bookmarkState?.items.removeWhere((r) => r.reportData.reportId == id);
    }

    _commitFeedMutation();
    await _saveReportToAllFeedCaches(updated.reportData.reportId);
  }

  // Performs an optimistic like toggle and reverts if the server update fails, while preventing multiple simultaneous interactions on the same report.
  Future<void> likeReportOptimistic(Report report, String userId) async {
    final reportId = report.reportData.reportId;

    if (_pendingInteractionReportIds.contains(reportId)) return;

    _pendingInteractionReportIds.add(reportId);

    await optimisticToggleLike(report);

    try {
      await toggleLike(reportId: reportId, userId: userId).timeout(const Duration(seconds: 10));
    } catch (e, stack) {
      log.e('Like failed, reverting', error: e, stackTrace: stack);
      await optimisticToggleLike(report);
    } finally {
      _pendingInteractionReportIds.remove(reportId);
    }
  }

  // Performs an optimistic dislike toggle and reverts if the server update fails, while preventing multiple simultaneous interactions on the same report.
  Future<void> dislikeReportOptimistic(Report report, String userId) async {
    final reportId = report.reportData.reportId;

    if (_pendingInteractionReportIds.contains(reportId)) return;

    _pendingInteractionReportIds.add(reportId);

    await optimisticToggleDislike(report);

    try {
      await toggleDislike(reportId: reportId, userId: userId).timeout(const Duration(seconds: 10));
    } catch (e, stack) {
      log.e('Dislike failed, reverting', error: e, stackTrace: stack);
      await optimisticToggleDislike(report);
    } finally {
      _pendingInteractionReportIds.remove(reportId);
    }
  }

  // Performs an optimistic bookmark toggle and reverts if the server update fails, while preventing multiple simultaneous interactions on the same report.
  Future<void> bookmarkReportOptimistic(Report report, String userId) async {
    final reportId = report.reportData.reportId;

    if (_pendingInteractionReportIds.contains(reportId)) return;

    _pendingInteractionReportIds.add(reportId);

    await optimisticToggleBookmark(report);

    try {
      await toggleBookmark(reportId: reportId, userId: userId).timeout(const Duration(seconds: 10));
    } catch (e, stack) {
      log.e('Bookmark failed, reverting', error: e, stackTrace: stack);
      await optimisticToggleBookmark(report);
    } finally {
      _pendingInteractionReportIds.remove(reportId);
    }
  }

  // Loads cached feeds for all feed types and hydrates them with user interactions.
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

    // Load USER REPORTS
    final userReportsKey = _feedKey(ReportFeedType.userReports);
    final userReportsCached = _reportCache.loadFeed(userReportsKey);

    if (userReportsCached != null) {
      final hydrated = await hydrateUserInteractionsBatch(userReportsCached, userId);
      _stateFor(userReportsKey).items = hydrated;
    }

    // Load USER BOOKMARKS
    final userBookmarksKey = _feedKey(ReportFeedType.userBookmarks);
    final userBookmarksCached = _reportCache.loadFeed(userBookmarksKey);

    if (userBookmarksCached != null) {
      final hydrated = await hydrateUserInteractionsBatch(userBookmarksCached, userId);
      _stateFor(userBookmarksKey).items = hydrated;
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
    _pendingInteractionReportIds.clear();
  }
}
