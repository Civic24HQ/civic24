import 'package:package_info_plus/package_info_plus.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:services/src/services/core/remote_config_service.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:utils/utils.dart';

class AppUpdateService {
  final _log = getLogger('AppUpdateService');
  final _remoteConfigService = serviceLocator<RemoteConfigService>();
  final _updater = ShorebirdUpdater();

  /// Checks if a Shorebird patch is available and downloads it silently.
  Future<void> checkForPatch() async {
    try {
      final status = await _updater.checkForUpdate();
      _log.d('Shorebird update status: $status');

      if (status == UpdateStatus.outdated) {
        _log.i('Patch available — downloading in background');
        await _updater.update();
        _log.i('Patch downloaded — will apply on next cold start');
      }
    } catch (e) {
      _log.w('Shorebird patch check failed: $e');
    }
  }

  /// Returns true if a downloaded patch is waiting to be applied.
  Future<bool> hasPendingPatch() async {
    try {
      final status = await _updater.checkForUpdate();
      return status == UpdateStatus.outdated;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if the installed app version is below the Remote Config minimum.
  Future<bool> isForceUpdateRequired() async {
    try {
      final info = await PackageInfo.fromPlatform();
      final currentVersion = info.version;
      final minVersion = _remoteConfigService.minAppVersion;

      final result = _isVersionBelow(currentVersion, minVersion);
      _log.d('Version check — current: $currentVersion, min: $minVersion, forceUpdate: $result');
      return result;
    } catch (e) {
      _log.w('Version check failed: $e');
      return false;
    }
  }

  bool _isVersionBelow(String current, String minimum) {
    final c = current.split('.').map(int.parse).toList();
    final m = minimum.split('.').map(int.parse).toList();

    for (var i = 0; i < 3; i++) {
      final cv = i < c.length ? c[i] : 0;
      final mv = i < m.length ? m[i] : 0;
      if (cv < mv) return true;
      if (cv > mv) return false;
    }
    return false;
  }
}
