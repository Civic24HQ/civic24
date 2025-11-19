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

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (serviceLocator.isRegistered<T>()) {
    serviceLocator.unregister<T>();
  }
}
