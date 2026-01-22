import 'dart:convert';

import 'package:constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:utils/utils.dart';

/// A service for handling local notifications for different platforms.
class LocalNotificationService {
  final _log = getLogger('LocalNotificationsService');

  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  /// Initializes local notifications for supported platforms.
  ///
  /// This method sets up notification settings for Android, iOS, and macOS.
  Future<void> initLocalNotifications() async {
    if (kIsWeb) return;
    const initializationSettingsAndroid = AndroidInitializationSettings('background');
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationReceived,
    );
  }

  /// Retrieves notification details for different platforms.
  ///
  /// The [type] parameter determines the notification channel for Android.
  /// Default values are used if custom details are not provided.
  NotificationDetails getPlatformChannelDetails(String? type) {
    final channelId = 'Civic24_${EnvironmentConstants.currentEnvironment}_Notifications';
    final channelName = 'Civic24 ${EnvironmentConstants.currentEnvironment} Notifications';
    final androidPlatformDetails =
        _androidChannels[type] ??
        AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: 'Real-time notifications from Civic24',
          icon: '@drawable/ic_stat_notification',
          importance: Importance.max,
          priority: Priority.high,
        );

    final darwinPlatformDetails = DarwinNotificationDetails(
      badgeNumber: 1,
      presentBadge: true,
      presentAlert: true,
      presentSound: true,
      threadIdentifier: channelId,
    );

    return NotificationDetails(
      android: androidPlatformDetails,
      iOS: darwinPlatformDetails,
      macOS: darwinPlatformDetails,
    );
  }

  /// Handles notification taps when the app is in the background or terminated.
  ///
  /// This method logs and processes the tapped notification data.
  void handleOnTapNotification(RemoteMessage message) {
    _log.d('handleOnTapNotification: ${message.data}');

    // final dialogService = serviceLocator<DialogService>();
    // final title = message.notification?.title ?? '';
    // final body = message.notification?.body ?? '';

    // dialogService.showCustomDialog(
    //   variant: SharedDialogType.action,
    //   title: title,
    //   description: body,
    //   barrierDismissible: true,
    // );
    // _log.d('Notification tapped: ${message.notification?.title} / ${message.notification?.body}');
  }

  /// Handles local notification interactions.
  ///
  /// Called when a user interacts with a displayed notification.
  void _onLocalNotificationReceived(NotificationResponse response) {
    final payload = response.payload;
    _log.d('notification payload: $payload');

    if (payload != null) {
      try {
        final remoteMessage = jsonDecode(payload) as Map<String, dynamic>;
        final message = RemoteMessage.fromMap(remoteMessage);
        handleOnTapNotification(message);
        _log.d('Notification tapped: ${message.notification?.title} / ${message.notification?.body}');
      } catch (exception, stackTrace) {
        _log.e('', error: exception, stackTrace: stackTrace);
      }
    }
  }

  /// Displays a notification based on the received [RemoteMessage].
  ///
  /// The notification includes a title, body, and additional data if provided.
  void showNotification(RemoteMessage message) {
    final notification = message.notification;
    final title = notification?.title ?? '';
    final body = notification?.body ?? '';
    final type = message.data['type'] as String?;

    _log.i('showNotification: $title / $body / $type / ${message.data}');
    final platformChannelDetails = getPlatformChannelDetails(type);
    _localNotifications.show(title.hashCode, title, body, platformChannelDetails, payload: jsonEncode(message.toMap()));
  }
}

/// Handles background messages received when the app is terminated or in the background.
///
/// This function must be a top-level function to work with Firebase Cloud Messaging.
@pragma('vm:entry-point')
Future<void> backgroundNotificationHandler(RemoteMessage remoteMessage) async {
  getLogger('LocalNotificationService').i('Handling a background message: ${remoteMessage.messageId}');

  return Future.value();
}

/// Predefined Android notification channels for different types of notifications.
Map<String, AndroidNotificationDetails> _androidChannels = {};
