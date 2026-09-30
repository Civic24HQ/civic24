import 'dart:async';

import 'package:constants/constants.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:utils/utils.dart';

/// A service responsible for handling real-time crash reports of user interactions with the app.
///
/// It will also capture and log both fatal and non-fatal errors.
class CrashlyticsService {
  /// [crashlytics] is for tests; the app uses [FirebaseCrashlytics.instance].
  CrashlyticsService({FirebaseCrashlytics? crashlytics})
    : _firebaseCrashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  final _log = getLogger('CrashlyticsService');

  final FirebaseCrashlytics _firebaseCrashlytics;

  bool get _isDevelopmentRun => kDebugMode || isTest;

  /// Sets the user ID shown on crash reports, so a user's crashes can be found by ID.
  ///
  /// Only the Firebase user ID is sent. Never send an email, name or other personal
  /// data to Crashlytics: reports are kept outside the app's own data controls.
  Future<void> setUserIdToCrashlytics(String userId) async {
    if (_isDevelopmentRun) return;
    await _firebaseCrashlytics.setUserIdentifier(userId);
  }

  /// Sets the user profile used on crash reports (the user ID only).
  void setupUserProfile({String? userId}) {
    if (userId != null) setUserIdToCrashlytics(userId);
  }

  /// Sets up error reporting, following the FlutterFire Crashlytics guide.
  ///
  /// - Collection is off in debug and test runs, so development crashes stay out of the dashboards.
  /// - Uncaught Flutter framework errors ([FlutterError.onError]) are recorded as fatal.
  /// - Uncaught asynchronous errors outside the framework ([PlatformDispatcher.onError]) are recorded as fatal.
  ///
  /// In debug and test runs errors are printed to the console instead.
  Future<void> setupFlutterErrorLogging() async {
    await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(!_isDevelopmentRun);

    FlutterError.onError = (FlutterErrorDetails details) {
      if (_isDevelopmentRun) {
        FlutterError.dumpErrorToConsole(details, forceReport: true);
        return;
      }
      _firebaseCrashlytics.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      if (_isDevelopmentRun) return false; // Let the default handler print it.
      _firebaseCrashlytics.recordError(error, stack, fatal: true);
      return true;
    };
    _log.i('Setup Flutter ErrorLogging');
  }

  /// Sends a log event to Crashlytics (release builds only, see `setupLogOutputs`).
  ///
  /// - `fatal`: recorded as a fatal error.
  /// - `error`: recorded as a non-fatal error.
  /// - `warning` and `info`: added as breadcrumbs, shown with the next report.
  /// - `debug` and `trace`: not sent. They are for development and may contain personal data.
  ///
  /// The error and stack trace passed to the logger (`_log.e('...', error: e, stackTrace: s)`)
  /// are recorded, so reports group and point at the failing code, not at the logger.
  Future<void> logToCrashlytics(OutputEvent event) async {
    final level = event.level;
    if (level.value < Level.info.value) return;

    final message = redactPersonalData(event.lines.join('\n'));
    if (level.value >= Level.error.value) {
      final origin = event.origin;
      final error = origin.error;
      // Exception text can carry personal data (an email in a validation error, a token in a URL).
      // Keep the original object (and its type) when there is nothing to remove.
      final redactedError = error == null ? null : redactPersonalData(error.toString());
      await _firebaseCrashlytics.recordError(
        error == null
            ? message
            : (redactedError == error.toString() ? error : RedactedError(error.runtimeType, redactedError!)),
        origin.stackTrace ?? StackTrace.current,
        reason: message,
        fatal: level.value >= Level.fatal.value,
      );
      return;
    }
    await _firebaseCrashlytics.log(message);
  }

  // !ONLY FOR TESTING!
  /// Force-crashes the app to check that Crashlytics receives native crashes with readable stack traces.
  ///
  /// Works in any build mode except in the production flavor, so the check can run on a
  /// development Release build (symbols are only uploaded for Release builds).
  void crashApp() {
    if (EnvironmentConstants.isProduction) return;
    _log.w('Force crashing the app to test Crashlytics setup');
    return _firebaseCrashlytics.crash();
  }
}

final _emailPattern = RegExp(r'[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}');
final _bearerPattern = RegExp(r'Bearer\s+[A-Za-z0-9._~+/=\-]+', caseSensitive: false);
final _jwtPattern = RegExp(r'eyJ[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]*');
final _urlQueryPattern = RegExp(r'(https?://[^\s?#]+)\?[^\s#]*');

/// Removes what must never reach Crashlytics from a message: email addresses, bearer tokens,
/// JWTs and URL query strings (which often carry tokens or keys).
///
/// This is a safety net for exception text, not a licence to log personal data: messages should
/// not contain it in the first place (see AGENTS.md, 4.5).
@visibleForTesting
String redactPersonalData(String text) => text
    .replaceAll(_emailPattern, '<email>')
    .replaceAll(_bearerPattern, 'Bearer <token>')
    .replaceAll(_jwtPattern, '<token>')
    .replaceAllMapped(_urlQueryPattern, (m) => '${m[1]}?<query>');

/// An error whose text was redacted. Keeps the original type name so reports stay recognisable.
@visibleForTesting
class RedactedError implements Exception {
  RedactedError(this.originalType, this.redactedText);

  final Type originalType;
  final String redactedText;

  @override
  String toString() => '$originalType: $redactedText';
}

class CrashlyticsOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (serviceLocator.isRegistered<CrashlyticsService>()) {
      serviceLocator<CrashlyticsService>().logToCrashlytics(event);
    }
  }
}
