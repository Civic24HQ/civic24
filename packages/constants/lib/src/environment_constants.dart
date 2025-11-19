enum Environment { development, staging, production }

/// Loads all the required environment values
/// from the dart define json file.
///
/// The environment values are set in the `--dart-define` flag
/// when running the app.
class EnvironmentConstants {
  static const String kEnvDev = 'Development';
  static const String kEnvStaging = 'Staging';
  static const String kEnvProduction = 'Production';

  @EnvironmentAssertion(
    environment.length != 0,
    'Environment must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: kEnvDev);

  @EnvironmentAssertion(
    projectId.length != 0,
    'Project ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String projectId = String.fromEnvironment('PROJECT_ID');

  @EnvironmentAssertion(
    authDomain.length != 0,
    'Auth Domain must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String authDomain = String.fromEnvironment('AUTH_DOMAIN');

  @EnvironmentAssertion(
    baseUrl.length != 0,
    'Base URL must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String baseUrl = String.fromEnvironment('BASE_URL');

  @EnvironmentAssertion(
    messagingSenderId.length != 0,
    'Messaging Sender ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String messagingSenderId = String.fromEnvironment('MESSAGING_SENDER_ID');

  @EnvironmentAssertion(
    storageBucket.length != 0,
    'Storage Bucket must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String storageBucket = String.fromEnvironment('STORAGE_BUCKET');

  // Google Cloud Logging
  @EnvironmentAssertion(
    loggingIdentifier.length != 0,
    'Logging Identifier must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String loggingIdentifier = String.fromEnvironment('LOGGING_IDENTIFIER');

  static const String loggingPrivateKey = '';

  @EnvironmentAssertion(
    loggingEmail.length != 0,
    'Logging Email must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String loggingEmail = String.fromEnvironment('LOGGING_CLIENT_EMAIL');

  @EnvironmentAssertion(
    androidApiKey.length != 0,
    'Android API Key must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String androidApiKey = String.fromEnvironment('ANDROID_API_KEY');

  @EnvironmentAssertion(
    androidAppId.length != 0,
    'Android App ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String androidAppId = String.fromEnvironment('ANDROID_APP_ID');

  @EnvironmentAssertion(
    iosAppId.length != 0,
    'iOS App ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String iosAppId = String.fromEnvironment('IOS_APP_ID');

  @EnvironmentAssertion(
    iosApiKey.length != 0,
    'iOS API Key must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String iosApiKey = String.fromEnvironment('IOS_API_KEY');

  @EnvironmentAssertion(
    iosClientId.length != 0,
    'iOS Client ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String iosClientId = String.fromEnvironment('IOS_CLIENT_ID');

  @EnvironmentAssertion(
    iosBundleId.length != 0,
    'iOS Bundle ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String iosBundleId = String.fromEnvironment('IOS_BUNDLE_ID');

  @EnvironmentAssertion(
    macosApiKey.length != 0,
    'macOS API Key must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String macosApiKey = String.fromEnvironment('MACOS_API_KEY');

  @EnvironmentAssertion(
    macosAppId.length != 0,
    'macOS App ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String macosAppId = String.fromEnvironment('MACOS_APP_ID');

  @EnvironmentAssertion(
    macosBundleId.length != 0,
    'macOS Bundle ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String macosBundleId = String.fromEnvironment('MACOS_BUNDLE_ID');

  @EnvironmentAssertion(
    webClientId.length != 0,
    'Web Client ID must be set - Follow `/app/README.md#Setup-Environmental-Variables` to setup environment values',
  )
  static const String webClientId = String.fromEnvironment('WEB_CLIENT_ID');

  static bool get isDev => currentEnvironment == Environment.development;
  static bool get isStaging => currentEnvironment == Environment.staging;
  static bool get isProduction => currentEnvironment == Environment.production;

  static Environment get currentEnvironment {
    switch (environment) {
      case kEnvDev:
        return Environment.development;
      case kEnvProduction:
        return Environment.production;
      case kEnvStaging:
        return Environment.staging;
      default:
        return Environment.development;
    }
  }
}

/// {@template app_annotation.environment.assert}
/// A decorator that allows adding `assert(...)` on Environment variables.
/// It checks if the environment variables are set and if not it will throw
/// a compile-time error.
///
/// Usage example:
///
/// ```dart
/// @EnvironmentAssertion(apiKey.length != 0, 'ApiKey cannot be empty')
/// const apiKey = String.fromEnvironment('API_KEY');
/// ```
/// {@endtemplate}
class EnvironmentAssertion {
  const EnvironmentAssertion(bool condition, [String message = '--dart-define environment=<value> must be set'])
    : assert(condition, message);
}
