import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

// Maximum number of denials allowed before skipping further requests
const int maxNotificationDenials = 2;

class PermissionService with ListenableServiceMixin {
  PermissionService() {
    listenToReactiveValues([_hasLocationPermission, _hasNotificationPermission, _notificationDenialCounter]);
    _init();
  }
  final _log = getLogger('PermissionService');
  final _alertService = serviceLocator<AlertService>();
  final _dialogService = serviceLocator<DialogService>();

  final _locationPermission = Permission.location;
  final _notificationPermission = Permission.notification;
  final _photosPermission = Permission.photos;

  final ReactiveValue<PermissionStatus> _hasLocationPermission = ReactiveValue<PermissionStatus>(
    PermissionStatus.denied,
  );
  bool get hasLocationPermission => _hasLocationPermission.value.isGranted;
  bool get isLocationPermissionDenied => _hasLocationPermission.value.isPermanentlyDenied;

  final ReactiveValue<PermissionStatus> _hasNotificationPermission = ReactiveValue<PermissionStatus>(
    PermissionStatus.denied,
  );
  bool get hasNotificationPermission => _hasNotificationPermission.value.isGranted;
  bool get isNotificationPermissionDenied => _hasNotificationPermission.value.isPermanentlyDenied;

  final ReactiveValue<int> _notificationDenialCounter = ReactiveValue<int>(0);
  bool get hasExceededNotificationDenials => _notificationDenialCounter.value >= maxNotificationDenials;

  bool _isRefreshingPermissions = false;

  Future<void> _init() async {
    _hasLocationPermission.value = await _locationPermission.status;
    _hasNotificationPermission.value = await _notificationPermission.status;
  }

  Future<void> requestLocationPermission() async {
    try {
      final status = await _locationPermission.request();
      _hasLocationPermission.value = status;
    } catch (e) {
      _log.e('Error requesting location permission', error: e);
    }
  }

  Future<void> requestNotificationPermission() async {
    try {
      final status = await _notificationPermission.request();
      _hasNotificationPermission.value = status;

      // If the permission was denied, increment the counter
      // which will be used to skip further requests.
      if (status.isDenied || status.isPermanentlyDenied) {
        _notificationDenialCounter.value++;
      }
    } catch (e) {
      _log.e('Error requesting notification permission', error: e);
    }
  }

  Future<void> openNotificationSettings() => AppSettings.openAppSettings(type: AppSettingsType.notification);

  Future<void> openLocationSettings() => AppSettings.openAppSettings(type: AppSettingsType.location);

  Future<void> refreshPermissions() async {
    if (_isRefreshingPermissions) return; // Prevent multiple calls.

    _isRefreshingPermissions = true;

    const maxAttempts = 10;
    var attempts = 0;

    while (attempts < maxAttempts) {
      // Delay between each check
      await Future.delayed(const Duration(seconds: 1));

      // Update permission statuses
      _hasLocationPermission.value = await _locationPermission.status;
      _hasNotificationPermission.value = await _notificationPermission.status;

      // Break loop if permissions are granted.
      if (hasNotificationPermission && hasLocationPermission) {
        break;
      }
      attempts++;
    }

    _isRefreshingPermissions = false; // Reset the flag once done.
  }

  Future<void> requestPhotosPermission() async {
    try {
      final status = await _photosPermission.request();
      if (status.isGranted) {
        _log.i('Photos permission granted');
      } else if (status.isDenied || status.isPermanentlyDenied) {
        _log.w('Photos permission denied');
        final result = await _dialogService.showConfirmationDialog(
          title: 'Permission Required',
          description: 'Permission to access to photos has been denied. Please enable it in your device settings.',
          confirmationTitle: 'Open Settings',
        );
        if (result != null && result.confirmed) {
          await AppSettings.openAppSettings();
        }
      }
    } catch (e) {
      _log.e('Error requesting photos permission', error: e);
      _alertService.showErrorAlert(
        title: 'Permission Error',
        message: 'Failed to request photos permission. Please try again later.',
      );
    }
  }
}
