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

/// Encapsulates the pagination state and loaded data for a single feed.
///
/// Each feed variant (e.g. "all", "trending", "category_road") maintains
/// its own independent [FeedPageState], enabling concurrent pagination
/// across multiple feeds without shared mutable state.
///
/// This class is intentionally mutable for performance — Firestore
/// pagination cursors and loaded items are updated in-place, with change
/// notifications managed by the owning [ReportService] via
/// [ReportService._commitFeedMutation].
class FeedPageState {
  /// The currently loaded reports for this feed, ordered according to
  /// the feed's sort criteria (e.g. `createdAt` for "all", `likeCount`
  /// for "trending").
  List<Report> items = [];

  /// The Firestore document snapshot used as a cursor for
  /// cursor-based pagination via `startAfterDocument`.
  ///
  /// This is `null` until the first page is loaded, and is updated
  /// after each subsequent page fetch.
  QueryDocumentSnapshot? lastDocument;

  /// The active real-time Firestore listener subscription for this feed.
  ///
  /// Must be cancelled when the feed is no longer displayed to prevent
  /// memory leaks and unnecessary network bandwidth consumption.
  StreamSubscription<dynamic>? liveSubscription;

  /// Whether additional pages of data are available to fetch.
  ///
  /// Determined by comparing the number of documents returned in the
  /// last fetch against the page limit — if fewer documents are returned
  /// than the limit, no more data is available.
  bool hasMore = true;

  /// Whether the first page of data is currently being fetched.
  ///
  /// Used by the UI layer to display an initial loading indicator
  /// (e.g. skeleton shimmer) on first visit to a feed tab.
  bool isLoadingFirstPage = false;

  /// Whether a subsequent page of data is currently being fetched.
  ///
  /// Used by the UI layer to display a pagination loading indicator
  /// (e.g. a bottom spinner) while scrolling to load more content.
  bool isLoadingNextPage = false;

  /// Cancels the active real-time listener and releases its resources.
  ///
  /// This should be called when the feed is disposed or when the
  /// listener needs to be replaced (e.g. during a feed refresh).
  Future<void> dispose() async {
    await liveSubscription?.cancel();
    liveSubscription = null;
  }
}

/// The central service responsible for all report-related data operations.
///
/// This service manages the full lifecycle of civic reports, including:
///
///  * **Feed management** — Loading, paginating, and refreshing multiple
///    concurrent feed types (all, trending, category-specific, user reports,
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
/// ## Architecture
///
/// Extends [FirestoreCollectionService] which provides typed CRUD operations
/// with automatic serialization via Firestore's `withConverter`. Mixes in
/// [ListenableServiceMixin] from Stacked for reactive UI binding, and
/// [FirebaseStorageService] for file upload capabilities.
///
/// ## Feed State Management
///
/// Each feed is identified by a unique key (see [_feedKey]) and maintains
/// its own [FeedPageState] in the [_feedStates] reactive map. This enables
/// independent pagination, loading states, and real-time listeners per feed.
///
/// ## Usage
///
/// ```dart
/// final reportService = serviceLocator<ReportService>();
/// await reportService.syncReportList();
/// await reportService.loadInitialFeed(ReportFeedType.all);
/// await reportService.startRealtimeFeed(ReportFeedType.all);
/// ```
class ReportService extends FirestoreCollectionService<Report> with ListenableServiceMixin, FirebaseStorageService {
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

  /// {@macro firestore_collection_service.collectionPath}
  @override
  String get collectionPath => FirestoreCollections.reports;

  /// {@macro firestore_service.convertFromJson}
  @override
  Report convertFromJson(Map<String, dynamic> json) => Report.fromJson(json);

  /// Reactive map holding the [FeedPageState] for every active feed.
  ///
  /// Keys are generated by [_feedKey] (e.g. `"all"`, `"trending"`,
  /// `"category_road"`). The map itself is wrapped in a [ReactiveValue]
  /// so that Stacked ViewModels automatically rebuild when feed data changes.
  final ReactiveValue<Map<String, FeedPageState>> _feedStates = ReactiveValue({});

  /// Tracks which feeds currently have active Firestore snapshot listeners.
  ///
  /// Prevents duplicate listener registration and enables selective teardown
  /// via [stopRealtimeFeed].
  final Set<String> _activeRealtimeFeeds = {};

  /// Guards against concurrent interactions on the same report.
  ///
  /// When a user taps like/dislike/bookmark, the report's ID is added to
  /// this set. Subsequent taps on the same report are ignored until the
  /// previous interaction completes or times out. This prevents race
  /// conditions from rapid double-taps.
  final Set<String> _pendingInteractionReportIds = {};

  /// Initializes the report service by registering reactive values and
  /// loading cached feed data.
  ///
  /// This method should be called once during app startup (typically
  /// after user authentication) to:
  ///  1. Register [_feedStates] with Stacked's reactive system so that
  ///     dependent ViewModels automatically rebuild on state changes.
  ///  2. Populate all feed states from the local Hive cache for instant
  ///     display before network data arrives.
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
  ///
  /// This key is used as the lookup in [_feedStates] and as the
  /// cache key in [ReportCacheService].
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
  List<Report> getFeedItems(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.items ?? [];

  /// Whether the first page of the specified feed is currently loading.
  ///
  /// Used by the UI to show a full-screen loading indicator or skeleton
  /// shimmer on initial feed display.
  bool isInitialReportLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingFirstPage ?? false;

  /// Whether a subsequent page is currently being fetched for the
  /// specified feed.
  ///
  /// Used by the UI to show a bottom-of-list loading indicator during
  /// infinite scroll pagination.
  bool isPaginationLoading(ReportFeedType type, {CategoryType? category}) =>
      _feedStates.value[_feedKey(type, category: category)]?.isLoadingNextPage ?? false;

  /// Whether more pages are available for the specified feed.
  ///
  /// Returns `true` by default for feeds that have not been loaded yet.
  /// Once a fetch returns fewer documents than the page limit, this is
  /// set to `false`, disabling further pagination requests.
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

  /// Builds a type-safe Firestore [Query] for the specified feed type.
  ///
  /// Each feed type applies different filters and sort orders:
  ///  * [ReportFeedType.all] — All reports, newest first.
  ///  * [ReportFeedType.trending] — Sorted by `likeCount` descending,
  ///    with `updatedAt` and `reportId` as tiebreakers for deterministic
  ///    pagination (required by Firestore's cursor semantics).
  ///  * [ReportFeedType.category] — Filtered by `arrayContains` on
  ///    `categoryTypes`, then newest first. Requires [category] to be
  ///    non-null.
  ///  * [ReportFeedType.userReports] — Filtered to the current user's
  ///    reports, newest first.
  ///  * [ReportFeedType.userBookmarks] — Throws [UnsupportedError]
  ///    because bookmarks use a two-step fetch (see
  ///    [loadInitialUserBookmarks]).
  ///
  /// The query is limited to [limit] documents (defaults to [kPageLimit]).
  ///
  /// **Note:** The trending and category queries require composite
  /// Firestore indexes. These must be created in the Firebase console
  /// or via `firestore.indexes.json`.
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

  /// Builds a Firestore query for real-time snapshot listeners.
  ///
  /// Currently delegates to [_buildFeedQuery]. Extracted as a separate
  /// method to allow subclasses or future implementations to customize
  /// real-time queries independently (e.g. different limits or filters
  /// for live updates vs. initial loads).
  @protected
  Query<Report> _buildRealtimeQuery(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) {
    return _buildFeedQuery(type, category: category, limit: limit);
  }

  /// Enriches a list of [reports] with the specified user's interaction
  /// state (liked, disliked, bookmarked).
  ///
  /// The interaction data is stored in a per-user Firestore subcollection
  /// at `users/{userId}/interactions/{reportId}`. This method batch-fetches
  /// the interaction documents and merges them into the corresponding
  /// [Report] objects via `copyWith`.
  ///
  /// ## Firestore `whereIn` Chunking
  ///
  /// Firestore's `whereIn` operator is limited to 30 values per query.
  /// If [reports] contains more than 30 items, the report IDs are split
  /// into chunks of 30, and all chunk queries execute in parallel via
  /// [Future.wait] for optimal performance.
  ///
  /// Returns the reports with updated interaction flags. Reports without
  /// a matching interaction document are returned unchanged (defaulting
  /// to `false` for all interaction flags).
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
  /// Skips processing if the snapshot is from the local Firestore
  /// cache (to avoid duplicate processing of already-displayed data).
  ///
  /// All changed reports are hydrated with user interaction state
  /// before being applied to the feed.
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
  /// For [ReportFeedType.userBookmarks], delegates to
  /// [startRealtimeUserBookmarks] since bookmarks listen on the user's
  /// interaction subcollection instead of the reports collection.
  ///
  /// **Important:** Always call [stopRealtimeFeed] when the feed is no
  /// longer displayed to prevent memory leaks and unnecessary network
  /// usage.
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

  /// Stops the real-time Firestore listener for the specified feed.
  ///
  /// Cancels the [StreamSubscription] and removes the feed from the
  /// [_activeRealtimeFeeds] tracking set. This is critical for preventing
  /// memory leaks and reducing unnecessary Firestore reads when a feed
  /// tab is no longer visible.
  ///
  /// No-ops if no active listener exists for the given feed.
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
  ///
  /// This method is **guarded** — it returns immediately if:
  ///  * A pagination request is already in progress.
  ///  * There are no more pages available ([FeedPageState.hasMore] is
  ///    `false`).
  ///  * No cursor exists (first page hasn't been loaded yet).
  ///
  /// For [ReportFeedType.userBookmarks], delegates to
  /// [loadMoreUserBookmarks].
  ///
  /// On failure, logs the error and resets the loading state without
  /// affecting the existing items.
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

  /// Loads the next page of bookmarked reports using cursor-based
  /// pagination on the user's interaction subcollection.
  ///
  /// Follows the same two-step pattern as [loadInitialUserBookmarks]:
  /// first fetches interaction document IDs, then batch-fetches the
  /// corresponding report documents. New reports are deduplicated
  /// before being appended.
  ///
  /// Guarded against concurrent calls and returns immediately if no
  /// more pages are available.
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

  /// Refreshes the specified feed by resetting pagination state and
  /// reloading from Firestore.
  ///
  /// This method:
  ///  1. Stops any active real-time listener for the feed.
  ///  2. Resets the pagination cursor and loading flags.
  ///  3. Reloads the first page of data.
  ///  4. Re-establishes the real-time listener if one was previously
  ///     active.
  ///
  /// Typically triggered by a pull-to-refresh gesture in the UI.
  ///
  /// Uses a `finally` block to ensure the loading state is always
  /// reset, even if the reload fails.
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
  ///
  /// Called during real-time change handling and report updates to
  /// ensure reports automatically appear in trending when they cross
  /// the like threshold.
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
  ///
  /// This ensures that when a report's categories are updated, it is
  /// automatically moved between the correct category feeds without
  /// requiring a full feed refresh.
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
  ///
  /// Currently hardcoded to >= 5 likes. Consider extracting this to
  /// a remote config value for dynamic adjustment without app updates.
  bool _qualifiesForTrending(Report report) => report.reportData.likeCount >= 5;

  /// Creates a new report and **optimistically** injects it into all
  /// relevant feeds before persisting to Firestore.
  ///
  /// The method:
  ///  1. Generates a unique Firestore document ID.
  ///  2. Stamps the report with UTC `createdAt` and `updatedAt` times.
  ///  3. Injects the report into the "all" feed, user's reports feed,
  ///     trending feed (if it qualifies), and each matching category
  ///     feed — **all before the network call**.
  ///  4. Persists each affected feed to the local cache.
  ///  5. Creates the Firestore document.
  ///
  /// If the Firestore write fails, an error alert is displayed to the
  /// user via [AlertService]. Note: the optimistic injection is *not*
  /// automatically reverted on failure — the real-time listener will
  /// eventually reconcile the state.
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

  /// Updates an existing report in Firestore and reconciles its
  /// position across all active feeds.
  ///
  /// This method:
  ///  1. Stamps the report with a new UTC `updatedAt` timestamp.
  ///  2. Persists the update to Firestore.
  ///  3. Replaces the old version in all feeds via
  ///     [_updateReportEverywhere].
  ///  4. Reconciles trending and category placement in case the
  ///     update changed like counts or category assignments.
  ///  5. Persists all affected feed caches.
  ///
  /// If the Firestore update fails, an error alert is shown.
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
  ///
  /// This transaction reads the user's current interaction state and
  /// atomically updates both:
  ///  * The report document's `likeCount` (and `dislikeCount` if
  ///    mutual exclusion applies).
  ///  * The user's interaction document with the new `hasLiked` /
  ///    `hasDisliked` flags.
  ///
  /// ## Mutual Exclusion
  ///
  /// Liking a report that was previously disliked will automatically
  /// remove the dislike (decrementing `dislikeCount` and setting
  /// `hasDisliked = false`). This ensures a user cannot simultaneously
  /// like and dislike the same report.
  ///
  /// ## Atomicity
  ///
  /// Uses [FieldValue.increment] for server-side atomic counter
  /// updates, and `SetOptions(merge: true)` to avoid overwriting
  /// the `hasBookmarked` field in the interaction document.
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

  /// Atomically toggles the dislike state for a report using a
  /// Firestore transaction.
  ///
  /// Mirrors the logic of [toggleLike] with inverted semantics:
  /// disliking a liked report will remove the like. Uses the same
  /// atomic transaction pattern with [FieldValue.increment] and
  /// `SetOptions(merge: true)`.
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

  /// Atomically toggles the bookmark state for a report using a
  /// Firestore transaction.
  ///
  /// Unlike like/dislike, bookmarking has no mutual exclusion — a user
  /// can bookmark a report regardless of their like/dislike state.
  /// The transaction atomically updates the report's `bookmarkCount`
  /// and the user's `hasBookmarked` flag.
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

  /// Searches all active feeds for a report with the given [id].
  ///
  /// Returns the first matching [Report] found, or `null` if the
  /// report is not currently loaded in any feed. Used by the
  /// optimistic toggle methods to read the current state before
  /// applying local mutations.
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
  /// specified report.
  ///
  /// Called after optimistic UI updates to ensure the local cache
  /// reflects the latest interaction state, so that the next app
  /// launch shows the correct like/bookmark indicators.
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
  ///
  /// Immediately updates the report's `hasLiked` flag and `likeCount`
  /// across all feeds, providing instant visual feedback. If the user
  /// had previously disliked the report, the dislike is also removed
  /// (mutual exclusion).
  ///
  /// This method is its own **inverse** — calling it twice returns
  /// the report to its original state. This property is used by
  /// [likeReportOptimistic] to revert on server failure.
  ///
  /// Counter values are clamped to `[0, 2147483647]` to prevent
  /// negative counts from edge cases.
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
  ///
  /// Mirrors [optimisticToggleLike] with inverted semantics. Also
  /// acts as its own inverse for revert-on-failure support.
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
  ///
  /// In addition to updating the report across all feeds, this method
  /// also manages the bookmarks feed itself:
  ///  * If bookmarking, injects the report into the bookmarks feed.
  ///  * If unbookmarking, removes the report from the bookmarks feed.
  ///
  /// Acts as its own inverse for revert-on-failure support.
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
  /// and automatic rollback on failure.
  ///
  /// Flow:
  ///  1. **Guard** — Returns if an interaction is already pending for
  ///     this report (prevents rapid double-tap race conditions).
  ///  2. **Optimistic update** — Immediately toggles the like state
  ///     in all feeds via [optimisticToggleLike].
  ///  3. **Server sync** — Executes the Firestore transaction via
  ///     [toggleLike] with a 10-second timeout.
  ///  4. **Rollback on failure** — If the transaction fails, calls
  ///     [optimisticToggleLike] again to revert to the original state.
  ///  5. **Cleanup** — Removes the report from
  ///     [_pendingInteractionReportIds] in the `finally` block.
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
  ///
  /// Follows the same guard → optimistic → sync → rollback pattern
  /// as [likeReportOptimistic].
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
  /// and automatic rollback on failure.
  ///
  /// Follows the same guard → optimistic → sync → rollback pattern
  /// as [likeReportOptimistic].
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
  ///
  /// This is called during [syncReportList] at app startup to provide
  /// instant feed display before network data is available. Each feed
  /// type (all, trending, categories, user reports, user bookmarks)
  /// is loaded independently.
  ///
  /// Even cached data is re-hydrated because the user's interaction
  /// state (likes/bookmarks) may have changed since the cache was
  /// written (e.g. via another device).
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

  /// Cancels all active real-time Firestore listeners across all
  /// feeds.
  ///
  /// Iterates through [_activeRealtimeFeeds] (converted to a list
  /// to avoid concurrent modification), cancels each subscription,
  /// and clears the tracking set.
  ///
  /// Called by [dispose] during service teardown and can also be
  /// used independently (e.g. when the user signs out but the
  /// service instance is recycled).
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
