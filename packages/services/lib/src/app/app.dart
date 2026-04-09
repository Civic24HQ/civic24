import 'package:services/services.dart';
import 'package:stacked/stacked_annotations.dart';
// @stacked-import

@StackedApp(
  routes: [
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: UserService),
    LazySingleton(classType: SessionService),
    LazySingleton(classType: RemoteConfigService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: SettingsStorageService),
    LazySingleton(classType: UserStorageService),
    LazySingleton(classType: AlertService),
    LazySingleton(classType: ReportService),
    LazySingleton(classType: MediaService),
    LazySingleton(classType: PermissionService),
    LazySingleton(classType: AnalyticsService),
    LazySingleton(classType: PushNotificationService),
    LazySingleton(classType: LocalNotificationService),
    LazySingleton(classType: CrashlyticsService),
    LazySingleton(classType: CloudinaryStorageService),
    LazySingleton(classType: ReportCacheService),
    LazySingleton(classType: UrlLauncherService),
    LazySingleton(classType: InternetConnectivityService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: AppInfoService),

    // @stacked-service
  ],
  locatorName: 'serviceLocator',
  locatorSetupName: 'setupServiceLocator',
)
class ServiceApp {}
