import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:services/src/services/firebase/firestore_subcollection_service.dart';
import 'package:services/src/services/local_storage/src/user_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

class NotificationService extends FirestoreSubCollectionService<NotificationData> with ListenableServiceMixin {
  final _userStorageService = serviceLocator<UserStorageService>();

  @override
  @protected
  final log = getLogger('NotificationService');

  @override
  String get subcollectionPath => '${FirestoreCollections.users}/{userId}/${FirestoreCollections.notifications}';

  @override
  NotificationData convertFromJson(Map<String, dynamic> json) => NotificationData.fromJson(json);

  static const int _pageSize = 50;

  StreamSubscription<List<NotificationData>>? _subscription;
  List<NotificationData> _notifications = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  /// Local shadow of the user's `lastReadAt` Firestore field.
  DateTime? _lastReadAt;

  List<NotificationData> get notifications => _effectiveNotifications;

  /// Returns the list with `hasBeenSeen` corrected against [_lastReadAt].
  List<NotificationData> get _effectiveNotifications => _lastReadAt == null
      ? _notifications
      : _notifications
            .map((n) => n.createdAt.isBefore(_lastReadAt!) || n.hasBeenSeen ? n.copyWith(hasBeenSeen: true) : n)
            .toList();

  int get unreadCount => _effectiveNotifications.where((n) => !n.hasBeenSeen).length;
  bool get hasUnread => unreadCount > 0;

  Future<void> startListening() async {
    final userId = _userStorageService.userId;
    if (userId == null) {
      log.w('Cannot start notification stream — no userId');
      return;
    }

    log.d('Starting notification stream for $userId');

    // Seed _lastReadAt from the user document so previously marked
    // notifications show as read immediately on app launch.
    try {
      final userSnap = await collectionReference(
        rootDocumentId: userId,
      ).firestore.collection(FirestoreCollections.users).doc(userId).get();
      final raw = userSnap.data()?['lastReadAt'];
      if (raw is Timestamp) {
        _lastReadAt = raw.toDate();
      }
    } catch (e) {
      log.w('Could not seed lastReadAt: $e');
    }

    final query = collectionReference(rootDocumentId: userId).orderBy('createdAt', descending: true).limit(_pageSize);

    _subscription = subscribeToListWithQuery(query: query).listen((incoming) {
      _notifications = incoming;
      // Reset pagination state when the live page refreshes
      _hasMore = incoming.length >= _pageSize;
      log.d('Notifications updated: ${_notifications.length}, unread: $unreadCount');
      notifyListeners();
    }, onError: (e) => log.e('Notification stream error: $e'));
  }

  Future<void> stopListening() async {
    await _subscription?.cancel();
    _subscription = null;
    _notifications = [];
    _lastDocument = null;
    _hasMore = true;
    notifyListeners();
  }

  /// Fetches the next page of older notifications and appends them.
  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore) return;
    final userId = _userStorageService.userId;
    if (userId == null) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      var query = collectionReference(rootDocumentId: userId).orderBy('createdAt', descending: true).limit(_pageSize);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      } else if (_notifications.isNotEmpty) {
        final snap = await collectionReference(rootDocumentId: userId).doc(_notifications.last.notificationId).get();
        if (snap.exists) {
          query = query.startAfterDocument(snap);
        }
      }

      final snapshot = await query.get();
      if (snapshot.docs.length < _pageSize) _hasMore = false;
      if (snapshot.docs.isNotEmpty) _lastDocument = snapshot.docs.last;

      final more = snapshot.docs.map((d) => convertFromJson(d.data() as Map<String, dynamic>)).toList();

      _notifications = [..._notifications, ...more];
      log.d('Loaded ${more.length} more notifications, hasMore: $_hasMore');
    } catch (e) {
      log.e('loadMore failed: $e');
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> onReportCreated({required Report report}) async {
    final authorId = report.reportData.userId;
    if (authorId == null) return;
    await _send(
      targetUserId: authorId,
      notification: _build(
        targetUserId: authorId,
        type: NotificationType.reportCreated,
        title: '🎉 Report Submitted',
        description: 'Your report has been submitted successfully',
        reportId: report.reportData.reportId,
      ),
    );
  }

  Future<void> onReportLiked({required Report report, required String actorUserId, required String actorName}) async {
    final authorId = report.reportData.userId;
    if (authorId == null || authorId == actorUserId) return;
    await _send(
      targetUserId: authorId,
      notification: _build(
        targetUserId: authorId,
        type: NotificationType.reportLiked,
        title: 'New Like',
        description: '$actorName liked your report.',
        reportId: report.reportData.reportId,
        actorUserId: actorUserId,
        actorName: actorName,
      ),
    );
  }

  Future<void> onReportDisliked({
    required Report report,
    required String actorUserId,
    required String actorName,
  }) async {
    final authorId = report.reportData.userId;
    if (authorId == null || authorId == actorUserId) return;
    await _send(
      targetUserId: authorId,
      notification: _build(
        targetUserId: authorId,
        type: NotificationType.reportDisliked,
        title: 'New Dislike',
        description: '$actorName disliked your report.',
        reportId: report.reportData.reportId,
        actorUserId: actorUserId,
        actorName: actorName,
      ),
    );
  }

  Future<void> markAsRead(NotificationData notification) async {
    final userId = _userStorageService.userId;
    if (userId == null || notification.hasBeenSeen) return;
    try {
      await update(
        documentId: notification.notificationId,
        rootDocumentId: userId,
        payload: notification.copyWith(hasBeenSeen: true, updatedAt: DateTime.now().toUtc()),
      );
    } catch (e) {
      log.e('markAsRead failed: $e');
    }
  }

  Future<void> markAllAsRead() async {
    final userId = _userStorageService.userId;
    if (userId == null) return;
    if (!hasUnread) return;

    _lastReadAt = DateTime.now().toUtc();
    notifyListeners();

    try {
      final userRef = collectionReference(
        rootDocumentId: userId,
      ).firestore.collection(FirestoreCollections.users).doc(userId);
      await userRef.update({'lastReadAt': FieldValue.serverTimestamp()});
      log.d('markAllAsRead: lastReadAt updated for $userId');
    } catch (e) {
      // Rollback optimistic update on failure
      _lastReadAt = null;
      notifyListeners();
      log.e('markAllAsRead failed: $e');
    }
  }

  @protected
  NotificationData _build({
    required String targetUserId,
    required NotificationType type,
    required String title,
    required String description,
    String? reportId,
    String? actorUserId,
    String? actorName,
  }) {
    final id = reportId != null ? '${type.name}_$reportId' : getNewDocId(rootDocumentId: targetUserId);
    final now = DateTime.now().toUtc();
    return NotificationData(
      notificationId: id,
      userId: targetUserId,
      type: type,
      title: title,
      description: description,
      reportId: reportId,
      actorUserId: actorUserId,
      actorName: actorName,
      createdAt: now,
      updatedAt: now,
    );
  }

  @protected
  Future<void> _send({required String targetUserId, required NotificationData notification}) async {
    try {
      final docRef = collectionReference(rootDocumentId: targetUserId).doc(notification.notificationId);
      await docRef.set(notification, SetOptions(merge: true));
      log.d('Notification upserted → $targetUserId [${notification.type}]');
    } catch (e) {
      log.w('Notification write failed (best-effort): $e');
    }
  }
}
