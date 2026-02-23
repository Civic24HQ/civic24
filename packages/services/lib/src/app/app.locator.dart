// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_shared/stacked_shared.dart';

import '../services/core/alert_service.dart';
import '../services/core/analytics_service.dart';
import '../services/core/authentication_service.dart';
import '../services/core/cloudinary_storage_service.dart';
import '../services/core/crashlytics_service.dart';
import '../services/core/internet_connectivity_service.dart';
import '../services/core/local_notification_service.dart';
import '../services/core/media_service.dart';
import '../services/core/permission_service.dart';
import '../services/core/push_notification_service.dart';
import '../services/core/user_service.dart';
import '../services/feature/report_service.dart';
import '../services/feature/url_launcher_service.dart';
import '../services/local_storage/src/report_cache_service.dart';
import '../services/local_storage/src/settings_storage_service.dart';
import '../services/local_storage/src/user_storage_service.dart';

final serviceLocator = StackedLocator.instance;

Future<void> setupServiceLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // Register environments
  serviceLocator.registerEnvironment(
    environment: environment,
    environmentFilter: environmentFilter,
  );

  // Register dependencies
  serviceLocator.registerLazySingleton(() => UserService());
  serviceLocator.registerLazySingleton(() => AuthenticationService());
  serviceLocator.registerLazySingleton(() => AlertService());
  serviceLocator.registerLazySingleton(() => ReportService());
  serviceLocator.registerLazySingleton(() => MediaService());
  serviceLocator.registerLazySingleton(() => PermissionService());
  serviceLocator.registerLazySingleton(() => AnalyticsService());
  serviceLocator.registerLazySingleton(() => PushNotificationService());
  serviceLocator.registerLazySingleton(() => LocalNotificationService());
  serviceLocator.registerLazySingleton(() => CrashlyticsService());
  serviceLocator.registerLazySingleton(() => CloudinaryStorageService());
  serviceLocator.registerLazySingleton(() => SettingsStorageService());
  serviceLocator.registerLazySingleton(() => ReportCacheService());
  serviceLocator.registerLazySingleton(() => UrlLauncherService());
  serviceLocator.registerLazySingleton(() => InternetConnectivityService());
  serviceLocator.registerLazySingleton(() => UserStorageService());
}
