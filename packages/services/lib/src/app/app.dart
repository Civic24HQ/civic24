import 'package:services/services.dart';
import 'package:stacked/stacked_annotations.dart';
// @stacked-import

@StackedApp(
  routes: [
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: UserService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: AlertService),
    LazySingleton(classType: ReportService),
    LazySingleton(classType: MediaService),
    LazySingleton(classType: PermissionService),
    LazySingleton(classType: AnalyticsService),
    LazySingleton(classType: PushNotificationService),
    LazySingleton(classType: LocalNotificationService),
    LazySingleton(classType: CrashlyticsService),
    LazySingleton(classType: CloudinaryStorageService),
    LazySingleton(classType: SettingsStorageService),
    LazySingleton(classType: ReportCacheService),
    LazySingleton(classType: UrlLauncherService),
    // @stacked-service
  ],
  locatorName: 'serviceLocator',
  locatorSetupName: 'setupServiceLocator',
)
class ServiceApp {}
