// ignore_for_file: depend_on_referenced_packages
import 'package:mockito/annotations.dart';
import 'package:services/services.dart';
import 'package:services/src/test/helpers/test_helpers.mocks.dart';
// @stacked-import

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<UserService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AuthenticationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AlertService>(onMissingStub: OnMissingStub.returnDefault),
    // @stacked-mock-spec
  ],
)
void registerServices() {
  getAndRegisterUserService();
  getAndRegisterAuthenticationService();
  getAndRegisterAlertService();
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

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (serviceLocator.isRegistered<T>()) {
    serviceLocator.unregister<T>();
  }
}
