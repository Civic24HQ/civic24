import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:utils/utils.dart';

/// A service class for managing Firebase Analytics events in the app.
///
/// This class provides methods to track user interactions and behaviors,
/// enabling better insights into user engagement and app usage patterns.
class AnalyticsService {
  final _log = getLogger('AnalyticsService');
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Returns an observer to track navigation events.
  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  /// Logs the app open event.
  ///
  /// This event helps track how often users open the app.
  void logAppOpen() {
    _log.d('Logging app open event');
    if (kDebugMode) {
      return;
    }
    _analytics.logAppOpen();
  }

  /// Sets the user ID for tracking.
  ///
  /// [id] - Unique identifier for the user. Pass `null` to clear the ID.
  Future<void> setUserId(String? id) async {
    _log.d('Setting user id to $id');
    if (kDebugMode) {
      return;
    }
    await _analytics.setUserId(id: id);
  }

  /// Sets a user property.
  ///
  /// Use this to attach user-specific metadata (e.g., subscription status).
  /// [name] is the property name, and [value] is its value.
  Future<void> setUserProperty({required String name, String? value}) async {
    _log.d('Setting user property $name to $value');
    if (kDebugMode) {
      return;
    }
    await _analytics.setUserProperty(name: name, value: value);
  }

  /// Logs a user login event with the specified [method].
  ///
  /// This helps track authentication patterns and preferred login methods.
  void logLogin(String method) {
    _log.d('Logging login method: $method');
    if (kDebugMode) {
      return;
    }
    _analytics.logLogin(loginMethod: method);
  }

  /// Logs a user sign-up event with the specified [method].
  ///
  /// Useful for tracking the effectiveness of different sign-up methods.
  void logSignUp(String method) {
    _log.d('Logging sign up method: $method');
    if (kDebugMode) {
      return;
    }
    _analytics.logSignUp(signUpMethod: method);
  }

  /// Logs the completion of the onboarding process.
  ///
  /// This event can be used in sales funnels to track onboarding effectiveness.
  void logOnboardingComplete() {
    _log.d('Logging onboarding complete');
    if (kDebugMode) {
      return;
    }
    _analytics.logTutorialComplete();
  }

  /// Logs when a user clicks a button.
  ///
  /// [buttonName] - Name of the button clicked.
  /// Example: 'auth_login', 'auth_signup', 'logout'.
  void logButtonClick(String buttonName) {
    _log.d('Logging button click: $buttonName');
    if (kDebugMode) {
      return;
    }
    _analytics.logEvent(name: 'button_tapped', parameters: {'name': buttonName});
  }

  /// Logs a custom screen view event.
  ///
  /// [screenClass] - Name of the screen's class (optional).
  /// [screenName] - Display name of the screen (optional).
  void logScreenView({String? screenClass, String? screenName}) {
    _log.d('Logging screen view: $screenClass - $screenName');
    if (kDebugMode) {
      return;
    }
    _analytics.logScreenView(screenClass: screenClass, screenName: screenName);
  }

  /// Logs a custom event with optional parameters.
  ///
  /// [eventName] - Name of the event to track.
  /// [parameters] - Additional event data (optional).
  void trackEvent(String eventName, {Map<String, Object>? parameters}) {
    _log.d('Tracking event: $eventName');
    if (kDebugMode) {
      return;
    }
    _analytics.logEvent(name: eventName, parameters: parameters);
  }
}
