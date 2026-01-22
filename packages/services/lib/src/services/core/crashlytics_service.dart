import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:utils/utils.dart';

/// A service responsible for handling real-time crash reports of user interactions with the app.
///
/// It will also capture and log both fatal and non-fatal errors.
class CrashlyticsService {
  final _log = getLogger('CrashlyticsService');

  final _firebaseCrashlytics = FirebaseCrashlytics.instance;

  /// This method is used to sets the userID to anonymously identify the user
  /// that experienced the crash in the crashlytics dashboard reports.
  Future<void> setUserIdToCrashlytics(String userId) async {
    if (kDebugMode || isTest) {
      _log.d('Crashlytics userId: $userId');
      return;
    }
    await _firebaseCrashlytics.setUserIdentifier(userId);
  }

  /// This method is used to sets the user email to anonymously identify the user
  /// that experienced the crash in the crashlytics dashboard reports.
  Future<void> setUserEmailToCrashlytics(String email) async {
    if (kDebugMode || isTest) {
      _log.d('Crashlytics userEmail: $email');
      return;
    }
    await _firebaseCrashlytics.setCustomKey('email', email);
  }

  /// This method is used to set the user profile information
  /// to anonymously identify the user that experienced the crash
  /// in the crashlytics dashboard reports.
  void setupUserProfile({String? userId, String? email}) {
    if (userId != null) {
      setUserIdToCrashlytics(userId);
    }
    if (email != null) {
      setUserEmailToCrashlytics(email);
    }
  }

  /// Initializes the Crashlytics service to configure the Crash Handlers
  ///
  /// This method handles all errors that are thrown within the Flutter framework by
  /// overriding [FlutterError.onError] with _firebaseCrashlytics.recordFlutterFatalError.
  Future<void> setupFlutterErrorLogging() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode || isTest) {
        FlutterError.dumpErrorToConsole(details, forceReport: true);
      } else {
        _firebaseCrashlytics.recordFlutterError(details);
      }
    };
    _log.i('Setup Flutter ErrorLogging');
  }

  Future<void> logToCrashlytics(Level level, List<String> lines, StackTrace stacktrace) async {
    if (level == Level.fatal) {
      await _firebaseCrashlytics.recordError(lines.join('\n'), stacktrace, printDetails: true, fatal: true);
    }

    if (level == Level.error) {
      await _firebaseCrashlytics.recordError(lines.join('\n'), stacktrace, printDetails: true);
    }

    if (level == Level.info || level == Level.trace || level == Level.debug || level == Level.warning) {
      await _firebaseCrashlytics.log(lines.join('\n'));
    }
  }

  // !ONLY FOR TESTING!
  /// This method is used to confirm that the Crashlytics setup is working correctly
  /// on both Android and iOS including the native side
  ///
  /// It uses the method provided by the Firebase Crashlytics instance called crash() to forcefully crash the app
  void crashApp() {
    if (kReleaseMode) return;
    _log.w('Force crashing the app to test Crashlytics setup');
    return _firebaseCrashlytics.crash();
  }
}

class CrashlyticsOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (serviceLocator.isRegistered<CrashlyticsService>()) {
      serviceLocator<CrashlyticsService>().logToCrashlytics(event.level, event.lines, StackTrace.current);
    }
  }
}
