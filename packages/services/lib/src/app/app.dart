import 'package:services/services.dart';
import 'package:stacked/stacked_annotations.dart';
// @stacked-import

@StackedApp(
  routes: [
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: AlertService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: AuthenticationService),
    // @stacked-service
  ],
  locatorName: 'serviceLocator',
  locatorSetupName: 'setupServiceLocator',
)
class ServiceApp {}
