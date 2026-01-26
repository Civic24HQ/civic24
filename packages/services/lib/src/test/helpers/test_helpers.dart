// ignore_for_file: depend_on_referenced_packages
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:services/src/test/helpers/test_helpers.mocks.dart';
// @stacked-import

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<UserService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AuthenticationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AlertService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<SettingsStorageService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<UrlLauncherService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ReportService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<MediaService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<PermissionService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AnalyticsService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<PushNotificationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<LocalNotificationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<CrashlyticsService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<CloudinaryStorageService>(onMissingStub: OnMissingStub.returnDefault),

    // @stacked-mock-spec
  ],
)
void registerServices() {
  getAndRegisterUserService();
  getAndRegisterAuthenticationService();
  getAndRegisterAlertService();
  getAndRegisterSettingsStorageService();
  getAndRegisterUrlLauncherService();
  getAndRegisterReportService();
  getAndRegisterMediaService();
  getAndRegisterPermissionService();
  getAndRegisterAnalyticsService();
  getAndRegisterPushNotificationService();
  getAndRegisterLocalNotificationService();
  getAndRegisterCrashlyticsService();
  getAndRegisterCloudinaryStorageService();
  // @stacked-mock-register
}

MockUserService getAndRegisterUserService() {
  _removeRegistrationIfExists<UserService>();
  final service = MockUserService();
  serviceLocator.registerSingleton<UserService>(service);
  return service;
}

MockAuthenticationService getAndRegisterAuthenticationService() {
  _removeRegistrationIfExists<AuthenticationService>();
  final service = MockAuthenticationService();
  serviceLocator.registerSingleton<AuthenticationService>(service);
  return service;
}

MockAlertService getAndRegisterAlertService() {
  _removeRegistrationIfExists<AlertService>();
  final service = MockAlertService();
  serviceLocator.registerSingleton<AlertService>(service);
  return service;
}

MockSettingsStorageService getAndRegisterSettingsStorageService() {
  _removeRegistrationIfExists<SettingsStorageService>();
  final service = MockSettingsStorageService();
  when(service.freshInstall).thenReturn(true);
  when(service.displayPreferences).thenReturn(const DisplayPreferences());
  serviceLocator.registerSingleton<SettingsStorageService>(service);
  return service;
}

MockUrlLauncherService getAndRegisterUrlLauncherService() {
  _removeRegistrationIfExists<UrlLauncherService>();
  final service = MockUrlLauncherService();
  serviceLocator.registerSingleton<UrlLauncherService>(service);
  return service;
}

MockReportService getAndRegisterReportService() {
  _removeRegistrationIfExists<ReportService>();
  final service = MockReportService();
  serviceLocator.registerSingleton<ReportService>(service);
  return service;
}

MockMediaService getAndRegisterMediaService() {
  _removeRegistrationIfExists<MediaService>();
  final service = MockMediaService();
  serviceLocator.registerSingleton<MediaService>(service);
  return service;
}

MockPermissionService getAndRegisterPermissionService() {
  _removeRegistrationIfExists<PermissionService>();
  final service = MockPermissionService();
  serviceLocator.registerSingleton<PermissionService>(service);
  return service;
}

MockAnalyticsService getAndRegisterAnalyticsService() {
  _removeRegistrationIfExists<AnalyticsService>();
  final service = MockAnalyticsService();
  serviceLocator.registerSingleton<AnalyticsService>(service);
  return service;
}

MockPushNotificationService getAndRegisterPushNotificationService() {
  _removeRegistrationIfExists<PushNotificationService>();
  final service = MockPushNotificationService();
  serviceLocator.registerSingleton<PushNotificationService>(service);
  return service;
}

MockLocalNotificationService getAndRegisterLocalNotificationService() {
  _removeRegistrationIfExists<LocalNotificationService>();
  final service = MockLocalNotificationService();
  serviceLocator.registerSingleton<LocalNotificationService>(service);
  return service;
}

MockCrashlyticsService getAndRegisterCrashlyticsService() {
  _removeRegistrationIfExists<CrashlyticsService>();
  final service = MockCrashlyticsService();
  serviceLocator.registerSingleton<CrashlyticsService>(service);
  return service;
}

MockCloudinaryStorageService getAndRegisterCloudinaryStorageService() {
  _removeRegistrationIfExists<CloudinaryStorageService>();
  final service = MockCloudinaryStorageService();
  serviceLocator.registerSingleton<CloudinaryStorageService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (serviceLocator.isRegistered<T>()) {
    serviceLocator.unregister<T>();
  }
}
