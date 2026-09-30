import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:services/services.dart';
import 'package:services/src/test/helpers/test_helpers.dart';

/// Records what the service sends to Crashlytics.
class _FakeCrashlytics extends Fake implements FirebaseCrashlytics {
  final List<String> breadcrumbs = [];
  final List<({Object error, StackTrace? stack, Object? reason, bool fatal})> errors = [];

  @override
  Future<void> log(String message) async => breadcrumbs.add(message);

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {
    errors.add((error: exception as Object, stack: stack, reason: reason, fatal: fatal));
  }
}

OutputEvent _event(Level level, String line, {Object? error, StackTrace? stackTrace}) =>
    OutputEvent(LogEvent(level, line, error: error, stackTrace: stackTrace), [line]);

void main() {
  group('CrashlyticsServiceTest -', () {
    late _FakeCrashlytics crashlytics;
    late CrashlyticsService service;

    setUp(() {
      registerServices();
      crashlytics = _FakeCrashlytics();
      service = CrashlyticsService(crashlytics: crashlytics);
    });
    tearDown(serviceLocator.reset);

    test('trace and debug logs are not sent (they may contain personal data)', () async {
      await service.logToCrashlytics(_event(Level.trace, 'trace line'));
      await service.logToCrashlytics(_event(Level.debug, 'googleUser {email: a@b.c}'));

      expect(crashlytics.breadcrumbs, isEmpty);
      expect(crashlytics.errors, isEmpty);
    });

    test('info and warning logs become breadcrumbs, not error reports', () async {
      await service.logToCrashlytics(_event(Level.info, 'Authenticating with Google'));
      await service.logToCrashlytics(_event(Level.warning, 'Google sign-in cancelled'));

      expect(crashlytics.breadcrumbs, ['Authenticating with Google', 'Google sign-in cancelled']);
      expect(crashlytics.errors, isEmpty);
    });

    test('error logs are recorded as non-fatal with the original error and stack trace', () async {
      final error = StateError('upload failed');
      final stack = StackTrace.fromString('#0 CloudinaryStorageService.uploadFile');
      await service.logToCrashlytics(_event(Level.error, 'Upload failed', error: error, stackTrace: stack));

      expect(crashlytics.errors, hasLength(1));
      final recorded = crashlytics.errors.single;
      expect(recorded.error, same(error));
      expect(recorded.stack, same(stack));
      expect(recorded.reason, 'Upload failed');
      expect(recorded.fatal, isFalse);
    });

    test('fatal logs are recorded as fatal', () async {
      await service.logToCrashlytics(_event(Level.fatal, 'Unrecoverable state'));

      expect(crashlytics.errors.single.fatal, isTrue);
      expect(crashlytics.errors.single.error, 'Unrecoverable state');
    });
  });
}
