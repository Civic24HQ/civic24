import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:services/src/services/core/alert_service.dart';
import 'package:services/src/services/core/internet_connectivity_service.dart';
import 'package:services/src/services/core/remote_config_service.dart';
import 'package:services/src/services/feature/report/feed_query_builder.dart';
import 'package:services/src/services/feature/report/interaction_hydrator.dart';
import 'package:services/src/services/feature/report/interfaces/i_report_feed.dart';
import 'package:services/src/services/feature/report/interfaces/i_report_interaction.dart';
import 'package:services/src/services/feature/report/interfaces/i_report_writer.dart';
import 'package:services/src/services/firebase/firebase_storage_service.dart';
import 'package:services/src/services/firebase/firestore_collection_service.dart';
import 'package:services/src/services/local_storage/src/report_cache_service.dart';
import 'package:services/src/services/local_storage/src/user_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

/// The central service responsible for all report-related data operations.
///
/// This service manages the full lifecycle of civic reports, including:
///
///  * **Feed management** — Loading, paginating and refreshing multiple
///    concurrent feed types (all, trending, category-specific, user reports
///    and user bookmarks).
///  * **Real-time synchronization** — Maintaining Firestore snapshot listeners
///    that push live updates to active feeds.
///  * **Optimistic UI updates** — Providing instant visual feedback for user
///    interactions (like, dislike, bookmark) with automatic rollback on failure.
///  * **Offline caching** — Persisting feed data to local storage (Hive) for
///    instant display on app launch and offline resilience.
///  * **Interaction hydration** — Merging per-user interaction state
///    (likes, dislikes, bookmarks) from the user's Firestore subcollection
///    into the shared report documents.
///
class ReportService extends FirestoreCollectionService<Report>
    with ListenableServiceMixin, FirebaseStorageService
    implements IReportFeedService, IReportWriterService, IReportInteractionService {
  @override
  @protected
  final log = getLogger('ReportService');

  /// Service for displaying user-facing error alerts and notifications.
  final _alertService = serviceLocator<AlertService>();

  /// Hive-backed cache service for persisting feed data to local storage.
  final _reportCache = serviceLocator<ReportCacheService>();

  /// Provides access to the current authenticated user's ID and profile.
  final _userStorageService = serviceLocator<UserStorageService>();

  /// Monitors network connectivity to enable offline-first feed loading.
  final _internetConnectivityService = serviceLocator<InternetConnectivityService>();

  final _remoteConfigService = serviceLocator<RemoteConfigService>();

  @override
  String get collectionPath => FirestoreCollections.reports;

  @override
  Report convertFromJson(Map<String, dynamic> json) => Report.fromJson(json);

  /// Reactive map holding the [FeedPageState] for every active feed.
  final ReactiveValue<Map<String, FeedPageState>> _feedStates = ReactiveValue({});

  /// Tracks which feeds currently have active Firestore snapshot listeners.
  final Set<String> _activeRealtimeFeeds = {};

  /// Guards against concurrent interactions on the same report.
  final Set<String> _pendingInteractionReportIds = {};

  @protected
  late final FeedQueryBuilder _feedQueryBuilder = FeedQueryBuilder(
    collectionReference: collectionReference,
    userId: _userStorageService.userId,
  );

  @protected
  final _interactionHydrator = InteractionHydrator(FirebaseFirestore.instance);

  /// Initializes the report service by registering reactive values and
  /// loading cached feed data.
  Future<void> syncReportList() async {
    listenToReactiveValues([_feedStates]);
    await loadFeedsFromCache();
  }

  /// Builds a unique string key that identifies a specific feed.
  ///
  /// For category feeds, the key includes the category name to ensure
  /// each category maintains independent state (e.g. `"category_road"`,
  /// `"category_waste"`). All other feeds use the enum name directly
  /// (e.g. `"all"`, `"trending"`, `"userReports"`).
  @protected
  String _feedKey(ReportFeedType type, {CategoryType? category}) {
    if (type == ReportFeedType.category) {
      return 'category_${category!.name}';
    }
    return type.name;
  }

  /// Returns the [FeedPageState] for the given [key], creating one
  /// lazily if it does not yet exist.
  ///
  /// When a new state is created, a fresh map reference is assigned
  /// to [_feedStates] to ensure the [ReactiveValue] detects the change
  /// and triggers downstream rebuilds.
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

  /// Returns the loaded report items for the specified feed.
  ///
  /// Returns an empty list if the feed has not been initialized yet.
  /// This is the primary accessor used by ViewModels to bind feed data
  /// to the UI.
  @override
  List<Report> getFeedItems(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.items ?? [];

  /// Checks whether the first page of the specified feed is currently loading.
  ///
  /// Used by the UI to show a full-screen loading indicator or skeleton
  /// shimmer on initial feed display.
  @override
  bool isInitialReportLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingFirstPage ?? false;

  /// Checks whether a subsequent page is currently being fetched for the
  /// specified feed.
  ///
  /// Used by the UI to show a bottom-of-list loading indicator during
  /// infinite scroll pagination.
  @override
  bool isPaginationLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingNextPage ?? false;

  /// Whether more pages are available for the specified feed.
  ///
  /// Returns `true` by default for feeds that have not been loaded yet.
  /// Once a fetch returns fewer documents than the page limit, this is
  /// set to `false`, disabling further pagination requests.
  @override
  bool hasMore(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.hasMore ?? true;

  /// Commits an in-place mutation of feed state to the reactive system.
  ///
  /// Because [ReactiveValue] uses reference equality to detect changes,
  /// mutating the existing map in-place would not trigger a rebuild.
  /// This method creates a shallow copy of the map via the spread
  /// operator (`{...map}`) to produce a new reference, then calls
  /// [notifyListeners] to push the update to all dependent ViewModels.
  void _commitFeedMutation() {
    _feedStates.value = {..._feedStates.value};
    notifyListeners();
  }

  /// Fetches a paginated snapshot of the current user's bookmarked
  /// interaction documents.
  ///
  /// Queries the `users/{userId}/interactions` subcollection for
  /// documents where `hasBookmarked == true`, ordered by `updatedAt`
  /// descending. Supports cursor-based pagination via [lastDoc].
  ///
  /// The returned document IDs correspond to report IDs, which are
  /// then used to fetch the actual report documents in a second query.
  @protected
  Future<QuerySnapshot<Map<String, dynamic>>> _getBookmarkedInteractionSnapshot({
    QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc,
    int limit = kPageLimit,
  }) async {
    var query = FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .doc(_userStorageService.userId)
        .collection(FirestoreCollections.interactions)
        .where('hasBookmarked', isEqualTo: true)
        .orderBy('updatedAt', descending: true)
        .limit(limit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    return query.get();
  }

  /// Loads the first page of a feed using a cache-first strategy.
  ///
  /// This method implements the following loading flow:
  ///  1. If items are already loaded, returns immediately (idempotent).
  ///  2. Attempts to load from the local Hive cache for instant display.
  ///  3. If no cache exists, sets [FeedPageState.isLoadingFirstPage] to
  ///     trigger a loading indicator in the UI.
  ///  4. If the device is offline, stops and uses cached data only.
  ///  5. Fetches fresh data from Firestore, hydrates with user
  ///     interactions, updates state, and persists to cache.
  ///
  /// For [ReportFeedType.userBookmarks], delegates to
  /// [loadInitialUserBookmarks] since bookmarks require a different
  /// two-step fetching strategy.
  ///
  /// The [limit] parameter controls the page size (defaults to
  /// [kPageLimit]).
  @override
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
      final snapshot = await fetchQuerySnapshot(query: _feedQueryBuilder.buildFeedQuery(type, category: category));

      final reports = snapshot.docs.map((d) => d.data()).toList();
      final hydrated = await _interactionHydrator.hydrate(reports, userId);

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

  /// Loads the first page of the user's bookmarked reports.
  ///
  /// Unlike other feeds, bookmarks require a **two-step fetch**:
  ///  1. Query `users/{userId}/interactions` for documents where
  ///     `hasBookmarked == true`, ordered by `updatedAt` descending.
  ///  2. Batch-fetch the corresponding report documents from the
  ///     `reports` collection using `whereIn` on the document IDs.
  ///
  /// The results are ordered to match the interaction query order
  /// (most recently bookmarked first), then hydrated with user
  /// interaction state and persisted to the local cache.
  ///
  /// Returns early if items are already loaded (idempotent).
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

      final hydrated = await _interactionHydrator.hydrate(orderedReports, _userStorageService.userId!);

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

  /// Removes a report from the specified feed's in-memory item list.
  ///
  /// Used by real-time listeners when a document is removed from a
  /// query result (e.g. a report no longer matches the category filter
  /// or was deleted).
  void _removeFromFeed({required ReportFeedType type, required String reportId, CategoryType? category}) {
    final state = _stateFor(_feedKey(type, category: category));
    state.items.removeWhere((r) => r.reportData.reportId == reportId);
  }

  /// Processes incoming real-time document changes for a feed.
  ///
  /// This is the core handler for Firestore snapshot listener events.
  /// For each document change in the [snapshot], it:
  ///  * **Added** — Injects the new report into the feed via
  ///    [_injectIntoFeed], maintaining sort order.
  ///  * **Modified** — Updates the report across all feeds via
  ///    [_updateReportEverywhere], then reconciles trending and
  ///    category placement.
  ///  * **Removed** — Removes the report from the specific feed.
  ///
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

    final hydrated = await _interactionHydrator.hydrate(changedReports, userId);

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

  /// Starts a real-time Firestore snapshot listener for the specified feed.
  ///
  /// The listener monitors the feed's Firestore query for document
  /// additions, modifications, and removals, and automatically updates
  /// the in-memory feed state via [_handleRealtimeChanges].
  ///
  /// This method is **idempotent** — calling it multiple times for the
  /// same feed will not create duplicate listeners. Active listeners
  /// are tracked in [_activeRealtimeFeeds].
  ///
  @override
  Future<void> startRealtimeFeed(ReportFeedType type, {CategoryType? category}) async {
    if (type == ReportFeedType.userBookmarks) {
      await startRealtimeUserBookmarks();
      return;
    }
    final key = _feedKey(type, category: category);

    if (_activeRealtimeFeeds.contains(key)) return;

    final state = _stateFor(key);

    final query = _feedQueryBuilder.buildFeedQuery(type, category: category);

    state.liveSubscription = subscribeSnapshotWithQuery(query: query).listen(
      (snapshot) => _handleRealtimeChanges(snapshot, type, category),
      onError: (e) => log.e('Realtime listener error for $key', error: e),
    );

    _activeRealtimeFeeds.add(key);
  }

  /// Starts a real-time listener for the user's bookmarked reports.
  ///
  /// Listens to the `users/{userId}/interactions` subcollection filtered
  /// by `hasBookmarked == true`. When a new bookmark is added, it fetches
  /// the corresponding report document and injects it into the bookmarks
  /// feed. When a bookmark is removed, the report is removed from the
  /// feed.
  ///
  /// This is separate from [startRealtimeFeed] because bookmarks are
  /// tracked in the user's subcollection rather than the reports
  /// collection itself.
  Future<void> startRealtimeUserBookmarks() async {
    final key = _feedKey(ReportFeedType.userBookmarks);

    if (_activeRealtimeFeeds.contains(key)) return;

    final state = _stateFor(key);

    // ignore: cascade_invocations
    state.liveSubscription = FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .doc(_userStorageService.userId)
        .collection(FirestoreCollections.interactions)
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

                final hydrated = await _interactionHydrator.hydrate([report], _userStorageService.userId!);

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

  /// Stops the real-time Firestore listener for the specified feed.
  ///
  /// Cancels the [StreamSubscription] and removes the feed from the
  /// [_activeRealtimeFeeds] tracking set. This is critical for preventing
  /// memory leaks and reducing unnecessary Firestore reads when a feed
  /// tab is no longer visible.
  ///
  /// No-ops if no active listener exists for the given feed.
  @override
  Future<void> stopRealtimeFeed(ReportFeedType type, {CategoryType? category}) async {
    final key = _feedKey(type, category: category);

    if (!_activeRealtimeFeeds.contains(key)) return;

    final state = _feedStates.value[key];

    log.i('Stopping realtime listener: $key');

    await state?.liveSubscription?.cancel();

    state?.liveSubscription = null;

    _activeRealtimeFeeds.remove(key);
  }

  /// Loads the next page of data for the specified feed using
  /// cursor-based pagination.
  ///
  /// Uses the [FeedPageState.lastDocument] as a Firestore cursor via
  /// `startAfterDocument` to fetch the next batch of documents. New
  /// reports are deduplicated against existing items before being
  /// appended to the feed.
  @override
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
        query: _feedQueryBuilder
            .buildFeedQuery(type, category: category, limit: limit)
            .startAfterDocument(state.lastDocument!),
      );

      final newReports = snapshot.docs.map((d) => d.data()).toList();

      final existingIds = state.items.map((e) => e.reportData.reportId).toSet();

      final hydrated = await _interactionHydrator.hydrate(newReports, userId);

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

  /// Loads the next page of bookmarked reports using cursor-based
  /// pagination on the user's interaction subcollection.
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

    final hydrated = await _interactionHydrator.hydrate(orderedReports, _userStorageService.userId!);

    final existingIds = state.items.map((r) => r.reportData.reportId).toSet();

    state.items.addAll(hydrated.where((r) => !existingIds.contains(r.reportData.reportId)));

    state
      ..isLoadingNextPage = false
      ..hasMore = interactionSnapshot.docs.length == limit
      ..lastDocument = interactionSnapshot.docs.isNotEmpty ? interactionSnapshot.docs.last : state.lastDocument;

    _commitFeedMutation();

    await _reportCache.saveFeed(key, state.items);
  }

  /// Refreshes the specified feed by resetting pagination state and
  /// reloading from Firestore.
  @override
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

  /// Inserts or updates a report in the specified feed, maintaining
  /// the feed's sort order and preventing unbounded growth.
  ///
  /// This method:
  ///  1. **Deduplicates** — Removes any existing copy of the report
  ///     to prevent duplicates.
  ///  2. **Inserts at position 0** — Places the report at the top
  ///     initially.
  ///  3. **Re-sorts** — Applies the feed-specific sort comparator to
  ///     move the report to its correct position:
  ///     - All/Category/UserReports: by `createdAt` descending.
  ///     - Trending: by `likeCount` descending, then `updatedAt`.
  ///     - Bookmarks: by `updatedAt` descending.
  ///  4. **Caps at 100 items** — Prevents unbounded memory growth
  ///     from real-time listener additions.
  ///
  /// This approach avoids O(n) insertion at a calculated index by
  /// leveraging Dart's efficient `sort` on nearly-sorted lists.
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

  /// Replaces an existing report with [updated] across **all** active
  /// feeds.
  ///
  /// Iterates through every [FeedPageState] in [_feedStates] and
  /// performs an in-place replacement wherever a report with the same
  /// ID is found. This ensures data consistency when a report is
  /// modified (e.g. via a real-time update or optimistic toggle).
  ///
  /// Does not call [_commitFeedMutation] — the caller is responsible
  /// for committing the mutation after all updates are applied.
  @protected
  void _updateReportEverywhere(Report updated) {
    final id = updated.reportData.reportId;

    for (final state in _feedStates.value.values) {
      final index = state.items.indexWhere((r) => r.reportData.reportId == id);
      if (index != -1) state.items[index] = updated;
    }
  }

  /// Checks if a report qualifies for the trending feed and injects
  /// it if it does.
  ///
  /// A report qualifies for trending when its [ReportData.likeCount]
  /// meets the threshold defined by [_qualifiesForTrending] (currently
  /// >= 5 likes). If the report qualifies but is not yet in the
  /// trending feed, it is injected via [_injectIntoFeed].
  @protected
  void _reconcileTrending(Report report) {
    final state = _stateFor(_feedKey(ReportFeedType.trending));

    final exists = state.items.any((r) => r.reportData.reportId == report.reportData.reportId);

    final qualifies = _qualifiesForTrending(report);

    if (qualifies && !exists) {
      _injectIntoFeed(type: ReportFeedType.trending, report: report);
    }
  }

  /// Reconciles a report's presence across all active category feeds.
  ///
  /// Iterates through all feed states whose keys start with
  /// `"category_"` and:
  ///  * **Injects** the report if it belongs to the category but is
  ///    not yet in the feed.
  ///  * **Removes** the report if it no longer belongs to the category
  ///    but is still in the feed.
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

  /// Returns whether a report meets the minimum like threshold to
  /// appear in the trending feed.
  bool _qualifiesForTrending(Report report) =>
      report.reportData.likeCount >= _remoteConfigService.trendingLikeThreshold;

  /// Creates a new report and **optimistically** injects it into all
  /// relevant feeds before persisting to Firestore.
  @override
  Future<void> addReport(Report report) async {
    final id = generateNewDocId();
    final now = DateTime.now().toUtc();

    final newReport = report.copyWith(
      reportData: report.reportData.copyWith(reportId: id, createdAt: now, updatedAt: now),
    );

    _injectIntoFeed(type: ReportFeedType.all, report: newReport);
    if (newReport.reportData.userId == _userStorageService.userId) {
      _injectIntoFeed(type: ReportFeedType.userReports, report: newReport);
    }
    if (_qualifiesForTrending(newReport)) {
      _injectIntoFeed(type: ReportFeedType.trending, report: newReport);
    }
    for (final category in newReport.reportData.categoryTypes) {
      _injectIntoFeed(type: ReportFeedType.category, category: category, report: newReport);
    }
    notifyListeners();

    try {
      await create(documentId: id, payload: newReport);

      // Persist cache only after confirmed write
      await _reportCache.saveFeed(_feedKey(ReportFeedType.all), _stateFor(_feedKey(ReportFeedType.all)).items);
      if (newReport.reportData.userId == _userStorageService.userId) {
        await _reportCache.saveFeed(
          _feedKey(ReportFeedType.userReports),
          _stateFor(_feedKey(ReportFeedType.userReports)).items,
        );
      }
      for (final category in newReport.reportData.categoryTypes) {
        final key = _feedKey(ReportFeedType.category, category: category);
        await _reportCache.saveFeed(key, _stateFor(key).items);
      }
    } catch (e) {
      log.e('Failed to create report, reverting', error: e);

      for (final state in _feedStates.value.values) {
        state.items.removeWhere((r) => r.reportData.reportId == id);
      }
      _commitFeedMutation();

      _alertService.showErrorAlert(
        title: 'Report Creation Failed',
        message: 'Please check your connection and try again.',
      );
    }
  }

  /// Updates an existing report in Firestore and reconciles its
  /// position across all active feeds.
  @override
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

  /// Atomically toggles the like state for a report using a Firestore
  /// transaction.
  Future<void> toggleLike({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);
    final interactionRef = firestore
        .collection(FirestoreCollections.users)
        .doc(userId)
        .collection(FirestoreCollections.interactions)
        .doc(reportId);

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

  /// Atomically toggles the dislike state for a report using a
  /// Firestore transaction.
  Future<void> toggleDislike({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);
    final interactionRef = firestore
        .collection(FirestoreCollections.users)
        .doc(userId)
        .collection(FirestoreCollections.interactions)
        .doc(reportId);

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

  /// Atomically toggles the bookmark state for a report using a
  /// Firestore transaction.
  Future<void> toggleBookmark({required String reportId, required String userId}) async {
    final firestore = FirebaseFirestore.instance;

    final reportRef = firestore.collection(collectionPath).doc(reportId);
    final interactionRef = firestore
        .collection(FirestoreCollections.users)
        .doc(userId)
        .collection(FirestoreCollections.interactions)
        .doc(reportId);

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

  /// Searches all active feeds for a report with the given [id].
  ///
  /// Returns the first matching [Report] found, or `null` if the
  /// report is not currently loaded in any feed.
  Report? _findReportById(String id) {
    for (final state in _feedStates.value.values) {
      final index = state.items.indexWhere((r) => r.reportData.reportId == id);

      if (index != -1) {
        return state.items[index];
      }
    }
    return null;
  }

  /// Persists the feed cache for every feed that contains the
  /// specified report ID.
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

  /// Applies an optimistic like toggle to the local feed state.
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

  /// Applies an optimistic dislike toggle to the local feed state.
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

  /// Applies an optimistic bookmark toggle to the local feed state.
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

  /// Performs a full optimistic like cycle with server persistence
  /// and automatic rollback on failure
  @override
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

  /// Performs a full optimistic dislike cycle with server persistence
  /// and automatic rollback on failure.
  @override
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

  /// Performs a full optimistic bookmark cycle with server persistence
  /// and automatic rollback on failure
  @override
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

  /// Loads all feed data from the local Hive cache and hydrates
  /// each feed with the current user's interaction state.
  Future<void> loadFeedsFromCache() async {
    // Load ALL feed
    final userId = _userStorageService.userId!;

    final allKey = _feedKey(ReportFeedType.all);
    final allCached = _reportCache.loadFeed(allKey);

    if (allCached != null) {
      final hydratedReports = await _interactionHydrator.hydrate(allCached, userId);
      _stateFor(allKey).items = hydratedReports;
      notifyListeners();
    }

    // Load TRENDING feed
    final trendingKey = _feedKey(ReportFeedType.trending);
    final trendingCached = _reportCache.loadFeed(trendingKey);

    if (trendingCached != null) {
      final hydratedReports = await _interactionHydrator.hydrate(trendingCached, userId);
      _stateFor(trendingKey).items = hydratedReports;
      notifyListeners();
    }

    // Load CATEGORY feeds
    for (final category in CategoryType.values) {
      final key = _feedKey(ReportFeedType.category, category: category);

      final cached = _reportCache.loadFeed(key);

      if (cached != null) {
        final hydratedReports = await _interactionHydrator.hydrate(cached, userId);
        _stateFor(key).items = hydratedReports;
      }
    }

    // Load USER REPORTS
    final userReportsKey = _feedKey(ReportFeedType.userReports);
    final userReportsCached = _reportCache.loadFeed(userReportsKey);

    if (userReportsCached != null) {
      final hydrated = await _interactionHydrator.hydrate(userReportsCached, userId);
      _stateFor(userReportsKey).items = hydrated;
    }

    // Load USER BOOKMARKS
    final userBookmarksKey = _feedKey(ReportFeedType.userBookmarks);
    final userBookmarksCached = _reportCache.loadFeed(userBookmarksKey);

    if (userBookmarksCached != null) {
      final hydrated = await _interactionHydrator.hydrate(userBookmarksCached, userId);
      _stateFor(userBookmarksKey).items = hydrated;
    }

    notifyListeners();
  }

  /// Cancels all active real-time Firestore listeners across all
  /// feeds.
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
