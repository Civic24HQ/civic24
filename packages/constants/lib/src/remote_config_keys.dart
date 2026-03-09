/// Firebase Remote Config parameter keys and their default values.
class RemoteConfigKeys {
  RemoteConfigKeys._();

  // Feature Rollout
  static const String maxReportImages = 'max_report_images';
  static const String minAppVersion = 'min_app_version';

  /// In-app defaults used before the first successful fetch.
  static const Map<String, dynamic> defaults = {
    maxReportImages: 4,
    minAppVersion: '1.0.0',
  };
}
