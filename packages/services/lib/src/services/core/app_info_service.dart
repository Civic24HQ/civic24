import 'package:package_info_plus/package_info_plus.dart';
import 'package:utils/utils.dart';

class AppInfoService {
  AppInfoService();

  final _log = getLogger('AppInfoService');

  PackageInfo? _packageInfo;

  /// Reads package metadata from the app once and caches it.
  Future<void> initialize() async {
    _log.d('Initializing AppInfoService');
    _packageInfo = await PackageInfo.fromPlatform();
    _log.i('App version: ${_packageInfo?.version} build: ${_packageInfo?.buildNumber}');
  }

  /// Semantic version string e.g. "1.2.3"
  String get version => _packageInfo?.version ?? '—';

  /// Platform build number e.g. "42"
  String get buildNumber => _packageInfo?.buildNumber ?? '—';

  /// Formatted for display in the UI e.g. "1.2.3+7"
  String get displayVersion => '$version+$buildNumber';

  /// App name as declared in pubspec.yaml
  String get appName => _packageInfo?.appName ?? '—';

  /// Package/bundle identifier e.g. "co.civic24.citizen"
  String get packageName => _packageInfo?.packageName ?? '—';
}
