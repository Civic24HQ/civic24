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
  final _settingsStorageService = serviceLocator<SettingsStorageService>();

  final _locationPermission = Permission.location;
  final _notificationPermission = Permission.notification;
  final _photosPermission = Permission.photos;

  final ReactiveValue<PermissionStatus> _hasLocationPermission = ReactiveValue<PermissionStatus>(
    PermissionStatus.denied,
  );
  bool get hasLocationPermission => _hasLocationPermission.value.isGranted;

  /// Whether location was permanently denied ("don't ask again"), including a denial remembered across restarts.
  ///
  /// This can stay true after the user resets the permission in Settings to "Ask every time" (Android 11+)
  /// without granting it, until the next request corrects it. Call [requestLocationPermission] first and
  /// trust its result; use this only to word a "go to Settings" message.
  bool get isLocationPermissionDenied => _hasLocationPermission.value.isPermanentlyDenied;

  final ReactiveValue<PermissionStatus> _hasNotificationPermission = ReactiveValue<PermissionStatus>(
    PermissionStatus.denied,
  );
  bool get hasNotificationPermission => _hasNotificationPermission.value.isGranted;

  /// Whether notifications were permanently denied, including a denial remembered across restarts.
  ///
  /// Same caveat as [isLocationPermissionDenied]: request first and trust the result.
  bool get isNotificationPermissionDenied => _hasNotificationPermission.value.isPermanentlyDenied;

  final ReactiveValue<int> _notificationDenialCounter = ReactiveValue<int>(0);
  bool get hasExceededNotificationDenials => _notificationDenialCounter.value >= maxNotificationDenials;

  bool _isRefreshingPermissions = false;

  Future<void> _init() async {
    _hasLocationPermission.value = await _currentStatus(_locationPermission);
    _hasNotificationPermission.value = await _currentStatus(_notificationPermission);
  }

  /// The permission's status, with a remembered permanent denial restored.
  ///
  /// On Android `status` reports `denied` even after "don't ask again"; only `request()` reports
  /// `permanentlyDenied`. The denial is remembered when it is seen and cleared once granted.
  Future<PermissionStatus> _currentStatus(Permission permission) async {
    final status = await permission.status;
    return _remember(permission, status);
  }

  /// Stores what [status] says about a permanent denial and returns the status to expose.
  ///
  /// With [fromRequest] the result came from `request()`, which is authoritative: a plain `denied` there means
  /// the system could still show its dialog (for example after the user reset the permission in Settings), so a
  /// remembered denial is cleared instead of restored.
  PermissionStatus _remember(Permission permission, PermissionStatus status, {bool fromRequest = false}) {
    // The name (for example `Permission.location`) rather than the plugin's numeric index, so the stored
    // flag cannot point at another permission if the plugin ever reorders its list.
    final name = permission.toString();
    final remembered = _settingsStorageService.isPermissionPermanentlyDenied(name);
    if (status.isGranted || status.isLimited || status.isProvisional) {
      if (remembered) _settingsStorageService.setPermissionPermanentlyDenied(name, denied: false);
      return status;
    }
    if (status.isPermanentlyDenied) {
      if (!remembered) _settingsStorageService.setPermissionPermanentlyDenied(name, denied: true);
      return status;
    }
    if (status.isDenied && remembered) {
      if (!fromRequest) return PermissionStatus.permanentlyDenied;
      _settingsStorageService.setPermissionPermanentlyDenied(name, denied: false);
    }
    return status;
  }

  Future<void> requestLocationPermission() async {
    try {
      final status = _remember(_locationPermission, await _locationPermission.request(), fromRequest: true);
      _hasLocationPermission.value = status;
    } catch (e) {
      _log.e('Error requesting location permission', error: e);
    }
  }

  Future<void> requestNotificationPermission() async {
    try {
      final status = _remember(_notificationPermission, await _notificationPermission.request(), fromRequest: true);
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
      _hasLocationPermission.value = await _currentStatus(_locationPermission);
      _hasNotificationPermission.value = await _currentStatus(_notificationPermission);

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
