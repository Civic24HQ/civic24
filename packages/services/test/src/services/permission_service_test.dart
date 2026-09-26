import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:services/services.dart';
import 'package:services/src/test/helpers/test_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

/// An in-memory stand-in for the settings box, so remembered denials can be checked.
class _FakeSettingsStorageService extends Fake implements SettingsStorageService {
  final Map<String, bool> denied = {};
  int writes = 0;

  @override
  bool isPermissionPermanentlyDenied(String name) => denied[name] ?? false;

  @override
  void setPermissionPermanentlyDenied(String name, {required bool denied}) {
    writes++;
    if (denied) {
      this.denied[name] = true;
    } else {
      this.denied.remove(name);
    }
  }
}

const _channel = MethodChannel('flutter.baseflow.com/permissions/methods');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PermissionServiceTest -', () {
    late _FakeSettingsStorageService storage;
    // What the platform reports for `status`, and for `request()`, per permission value.
    late Map<int, PermissionStatus> statusOf;
    late Map<int, PermissionStatus> requestResultOf;

    setUp(() {
      registerServices();
      serviceLocator
        ..registerSingleton<DialogService>(DialogService())
        ..unregister<SettingsStorageService>()
        ..registerSingleton<SettingsStorageService>(storage = _FakeSettingsStorageService());
      statusOf = {};
      requestResultOf = {};
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, (
        call,
      ) async {
        switch (call.method) {
          case 'checkPermissionStatus':
            return (statusOf[call.arguments as int] ?? PermissionStatus.denied).index;
          case 'requestPermissions':
            final permissions = (call.arguments as List<dynamic>).cast<int>();
            return {for (final p in permissions) p: (requestResultOf[p] ?? PermissionStatus.denied).index};
        }
        return null;
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, null);
      serviceLocator.reset();
    });

    PermissionService build() => PermissionService();

    Future<void> settle() => Future<void>.delayed(Duration.zero);

    test('a granted permission is reported as granted and not as denied', () async {
      statusOf[Permission.location.value] = PermissionStatus.granted;
      final service = build();
      await settle();

      expect(service.hasLocationPermission, isTrue);
      expect(service.isLocationPermissionDenied, isFalse);
    });

    test('a plain denial stays a plain denial', () async {
      final service = build();
      await settle();

      expect(service.hasLocationPermission, isFalse);
      expect(service.isLocationPermissionDenied, isFalse);
    });

    test('a permanent denial seen in a request is remembered after a restart (Android reports denied)', () async {
      requestResultOf[Permission.location.value] = PermissionStatus.permanentlyDenied;
      final first = build();
      await settle();
      await first.requestLocationPermission();
      expect(first.isLocationPermissionDenied, isTrue);

      // "Restart": a new service; the platform now only reports `denied`.
      statusOf[Permission.location.value] = PermissionStatus.denied;
      final second = build();
      await settle();

      expect(second.isLocationPermissionDenied, isTrue);
    });

    test('the same holds for notifications, and a denial is counted', () async {
      requestResultOf[Permission.notification.value] = PermissionStatus.permanentlyDenied;
      final service = build();
      await settle();
      await service.requestNotificationPermission();

      expect(service.isNotificationPermissionDenied, isTrue);
      expect(service.hasExceededNotificationDenials, isFalse);

      statusOf[Permission.notification.value] = PermissionStatus.denied;
      final restarted = build();
      await settle();
      expect(restarted.isNotificationPermissionDenied, isTrue);
    });

    test('granting the permission in settings clears the remembered denial', () async {
      requestResultOf[Permission.location.value] = PermissionStatus.permanentlyDenied;
      final service = build();
      await settle();
      await service.requestLocationPermission();
      expect(service.isLocationPermissionDenied, isTrue);

      statusOf[Permission.location.value] = PermissionStatus.granted;
      final restarted = build();
      await settle();

      expect(restarted.hasLocationPermission, isTrue);
      expect(restarted.isLocationPermissionDenied, isFalse);
      expect(storage.denied, isEmpty);

      // Later, after a plain denial again, the old flag must not come back.
      statusOf[Permission.location.value] = PermissionStatus.denied;
      final again = build();
      await settle();
      expect(again.isLocationPermissionDenied, isFalse);
    });

    test('a permanent denial reported directly by the platform (iOS) is remembered too', () async {
      statusOf[Permission.location.value] = PermissionStatus.permanentlyDenied;
      final service = build();
      await settle();

      expect(service.isLocationPermissionDenied, isTrue);
      expect(storage.isPermissionPermanentlyDenied(Permission.location.toString()), isTrue);
    });
    test('storage is only written when the remembered value changes', () async {
      statusOf[Permission.location.value] = PermissionStatus.granted;
      statusOf[Permission.notification.value] = PermissionStatus.granted;
      final service = build();
      await settle();
      await service.refreshPermissions();

      expect(storage.writes, 0);
    });
    test('a plain denial from a new request clears the remembered denial (Settings reset, Android)', () async {
      requestResultOf[Permission.location.value] = PermissionStatus.permanentlyDenied;
      final service = build();
      await settle();
      await service.requestLocationPermission();
      expect(service.isLocationPermissionDenied, isTrue);

      // The user resets the permission to "Ask every time"; the next request shows the dialog and they deny once.
      requestResultOf[Permission.location.value] = PermissionStatus.denied;
      await service.requestLocationPermission();

      expect(service.isLocationPermissionDenied, isFalse);
      expect(storage.denied, isEmpty);
    });
  });
}
