import 'package:models/models.dart';
import 'package:services/src/services/local_storage/local_storage_service.dart';

const String _kFreshInstallKey = 'freshInstallKey';
const String _kDisplayPreferencesKey = 'displayPreferencesKey';
const String _kLastSessionAtKey = 'lastSessionAt';
const String _kPermanentlyDeniedPrefix = 'permissionPermanentlyDenied.';

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

  /// Whether the user permanently denied the permission named [name] ("don't ask again").
  ///
  /// On Android a status check can never report a permanent denial, only the result of a request can,
  /// so the denial is remembered here until the permission is granted.
  bool isPermissionPermanentlyDenied(String name) => getData<bool?>('$_kPermanentlyDeniedPrefix$name') ?? false;

  void setPermissionPermanentlyDenied(String name, {required bool denied}) =>
      denied ? saveData('$_kPermanentlyDeniedPrefix$name', true) : deleteData('$_kPermanentlyDeniedPrefix$name');

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
