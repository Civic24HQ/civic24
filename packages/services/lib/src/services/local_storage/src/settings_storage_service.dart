import 'package:models/models.dart';
import 'package:services/src/services/local_storage/local_storage_service.dart';

const String _kFreshInstallKey = 'freshInstallKey';
const String _kDisplayPreferencesKey = 'displayPreferencesKey';

class SettingsStorageService extends LocalStorageService {
  SettingsStorageService() : super(settingsBox, 'SettingsStorageService');

  bool get freshInstall => getData(_kFreshInstallKey) ?? true;
  void setFreshInstall() => saveData(_kFreshInstallKey, false);

  DisplayPreferences get displayPreferences {
    final data = getData(_kDisplayPreferencesKey);
    if (data is Map<String, dynamic>) {
      return DisplayPreferences.fromJson(data);
    } else {
      return const DisplayPreferences();
    }
  }

  void setDisplayPreferences(DisplayPreferences displayPreferences) =>
      saveData(_kDisplayPreferencesKey, displayPreferences.toJson());
}
