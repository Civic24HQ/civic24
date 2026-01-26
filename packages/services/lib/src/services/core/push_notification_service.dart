import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:services/services.dart';
import 'package:utils/utils.dart';

/// A service responsible for handling push notifications using Firebase Messaging.
class PushNotificationService {
  final _log = getLogger('PushNotificationService');
  final _localNotificationService = serviceLocator<LocalNotificationService>();

  final _firebaseMessaging = FirebaseMessaging.instance;

  bool _disposed = false;
  bool _initialized = false;

  RemoteMessage? _initialMessage;

  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedSubscription;

  /// Initializes the push notification service.
  ///
  /// This method sets up Firebase Messaging, requests notification permissions,
  /// and listens for incoming messages.
  Future<void> initialize() async {
    if (_initialized) {
      _log.w('Service has already been initialized');
      return;
    }
    _log.i('INITIALIZING PUSH NOTIFICATIONS');
    final isSupported = await _firebaseMessaging.isSupported();
    if (!isSupported) {
      _log.w('Firebase messaging is not supported on this device');
      return;
    }

    // Get and store any initial message (cold start)
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _log.d('Stored initial message: ${initialMessage.messageId}');
      _initialMessage = initialMessage;
    }

    if (isMobile || isMacOS) {
      await _localNotificationService.initLocalNotifications();
    }

    await initializeNotificationListeners();

    _initialized = true;
    _log.i('PUSH NOTIFICATIONS INITIALIZED');
  }

  @visibleForTesting
  Future<void> initializeNotificationListeners() async {
    _log.i('INITIALIZING PUSH NOTIFICATION LISTENERS');
    final isSupported = await _firebaseMessaging.isSupported();
    if (!isSupported) {
      _log.w('Firebase messaging is not supported on this device');
      return;
    }

    _log.d('Handling initial message from cold start');
    await getInitialMessageAndHandle();
    _listenToFirebaseMessage();

    _log.i('PUSH NOTIFICATION LISTENERS INITIALIZED');
  }

  /// Retrieves the Firebase Cloud Messaging (FCM) token.
  ///
  /// Returns `null` if messaging is not supported on the device.
  Future<String?> get getFcmToken async {
    final isSupported = await _firebaseMessaging.isSupported();
    if (isSupported) {
      if (kIsWeb) {
        _log.w('Web tokens is not supported for this version');
        return null;
      }

      if (_disposed) {
        _log.w('Service has been disposed, not getting token');
        return null;
      }

      if (isIOS || isMacOS) {
        final apnToken = await _firebaseMessaging.getAPNSToken();
        _log.d('APNS token: $apnToken');

        if (apnToken == null) {
          _log.w('APNS token is null');
          return null;
        }

        final token = await _firebaseMessaging.getToken();
        return token;
      } else {
        final token = await _firebaseMessaging.getToken();
        _log.d('FCM token: $token');
        return token;
      }
    } else {
      _log.w('Firebase messaging is not supported on this device');
      return null;
    }
  }

  /// Handles the initial notification message if the app was launched via a notification.
  Future<void> getInitialMessageAndHandle() async {
    _log.i('GETTING INITIAL MESSAGE');
    final initialMessage = _initialMessage ?? await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _log.d('Initial message: ${initialMessage.notification?.title} / ${initialMessage.notification?.body}');
      handleMessageOpened(initialMessage);
      _initialMessage = null; // Clear the initial message after handling
    }
  }

  /// Listens for Firebase push notifications while the app is in the foreground or background.
  void _listenToFirebaseMessage() {
    _log.i('LISTENING TO FIREBASE MESSAGES');
    _onMessageSubscription = FirebaseMessaging.onMessage.listen(handleMessage);
    _onMessageOpenedSubscription = FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpened);
  }

  /// Handles a received push notification while the app is in the foreground.
  ///
  /// Displays a local notification using the `LocalNotificationService`.
  void handleMessage(RemoteMessage message) {
    _log.d('Message: ${message.notification?.title}');
    _localNotificationService.showNotification(message);
  }

  /// Handles a push notification that was tapped/opened by the user.
  ///
  /// Logs the event and tracks analytics if in release mode.
  void handleMessageOpened(RemoteMessage message) {
    _log.d('Message opened: ${message.notification?.title} / ${message.notification?.body}');
    if (_disposed) {
      _log.w('Service has been disposed, not handling message');
      return;
    }
    _localNotificationService.handleOnTapNotification(message);
  }

  /// Handles background payloads message
  static Future<void> initBackgroundMessage() async {
    /// Registers a background message handler for Firebase push notifications.
    FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  }

  /// Cleans up resources and unsubscribes from notification streams.
  Future<void> dispose() async {
    _log.i('Disposing PushNotificationService');
    _disposed = true;
    _initialized = false;
    await _onMessageSubscription?.cancel();
    await _onMessageOpenedSubscription?.cancel();
    if (isIOS || isMacOS) {
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        await _firebaseMessaging.deleteToken();
      } else {
        _log.w('APNs token not available, skipping deleteToken');
      }
    } else {
      await _firebaseMessaging.deleteToken();
    }
  }
}
