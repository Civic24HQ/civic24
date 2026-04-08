/// Firebase Remote Config parameter keys and their default values.
class RemoteConfigKeys {
  RemoteConfigKeys._();

  // Feature Rollout
  static const String maxReportImages = 'max_report_images';
  static const String minAppVersion = 'min_app_version';
  static const String productTermsUrl = 'product_terms_url';
  static const String productPrivacyUrl = 'product_privacy_url';

  /// In-app defaults used before the first successful fetch.
  static const Map<String, dynamic> defaults = {
    maxReportImages: 2,
    productTermsUrl: 'https://www.notion.so/Terms-of-Use-for-Civic24-327aac2070fd800cbc41eaa17304f06a?source=copy_link',
    productPrivacyUrl:
        'https://www.notion.so/Privacy-Policy-for-Civic24-327aac2070fd8066bdc5d8b2aee67f27?source=copy_link',
    minAppVersion: '1.0.0',
  };
}
