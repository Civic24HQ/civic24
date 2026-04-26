import 'package:services/src/app/app.locator.dart';
import 'package:services/src/services/core/remote_config_service.dart';
import 'package:services/src/services/local_storage/src/settings_storage_service.dart';
import 'package:utils/utils.dart';

class SessionService {
  final _log = getLogger('SessionService');
  final _remoteConfigService = serviceLocator<RemoteConfigService>();
  final _settingsStorageService = serviceLocator<SettingsStorageService>();

  /// Returns true if the stored session is older than the configured duration.
  /// Returns false if there is no stored session.
  bool isSessionExpired() {
    final lastSession = _settingsStorageService.lastSessionAt;
    if (lastSession == null) {
      _log.d('No session record found — treating as fresh session');
      return false;
    }
    final maxDays = _remoteConfigService.sessionDurationDays;
    final daysSince = DateTime.now().difference(lastSession).inDays;
    final expired = daysSince >= maxDays;
    _log.d('Session age: $daysSince days, limit: $maxDays days, expired: $expired');
    return expired;
  }

  /// Called after every successful sign-in to record the session start.
  void recordSession() {
    _log.d('Recording session timestamp');
    _settingsStorageService.setLastSessionAt();
  }

  /// Called on sign-out to remove the stored session.
  void clearSession() {
    _log.d('Clearing session timestamp');
    _settingsStorageService.clearLastSessionAt();
  }
}
