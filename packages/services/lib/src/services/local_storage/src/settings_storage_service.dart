import 'package:models/models.dart';
import 'package:services/src/services/local_storage/local_storage_service.dart';

const String _kFreshInstallKey = 'freshInstallKey';
const String _kDisplayPreferencesKey = 'displayPreferencesKey';
const String _kLastSessionAtKey = 'lastSessionAt';

class SettingsStorageService extends LocalStorageService {
  SettingsStorageService() : super(settingsBox, 'SettingsStorageService');

  bool get freshInstall => getData(_kFreshInstallKey) ?? true;
  void setFreshInstall() => saveData(_kFreshInstallKey, false);

  DateTime? get lastSessionAt {
    final raw = getData<String?>(_kLastSessionAtKey);
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  void setLastSessionAt() => saveData(_kLastSessionAtKey, DateTime.now().toIso8601String());
  void clearLastSessionAt() => deleteData(_kLastSessionAtKey);

  DisplayPreferences get displayPreferences {
    final data = getData(_kDisplayPreferencesKey);
    if (data is Map) {
      return DisplayPreferences.fromJson(Map<String, dynamic>.from(data));
    } else {
      return const DisplayPreferences();
    }
  }

  void setDisplayPreferences(DisplayPreferences displayPreferences) =>
      saveData(_kDisplayPreferencesKey, displayPreferences.toJson());
}
