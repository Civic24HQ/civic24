import 'dart:math';

import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class StartupViewModel extends BaseViewModel {
  final _log = getLogger('StartupViewModel');
  final _navigationService = locator<RouterService>();
  final _authenticationService = locator<AuthenticationService>();
  final _userService = locator<UserService>();
  final _analyticsService = locator<AnalyticsService>();

  bool isAnimate = false;
  double turns = 0;
  double angle = 0;

  void changeAnimationState() {
    isAnimate = !isAnimate;
    rebuildUi();
  }

  void animateLight() {
    angle = angle == 0 ? pi : 0; // toggle between 0° and 180°
    rebuildUi();
  }

  void rotate() {
    turns += 1;
    rebuildUi();
  }

  void prepareUserSession() {
    _log.d('Initializing UserAuth');
    // _authenticationService.setAuthStateToIdle();

    // Listen to the authentication state stream
    _authenticationService.authenticatedStream.listen((authState) {
      _log.d('Auth state changed: $authState');

      switch (authState) {
        case AuthState.authenticated:
          _log.d('User is authenticated, continuing with onboarding.');
        case AuthState.unauthenticated:
          _log.d('User is not authenticated. Redirecting to onboarding.');
          _navigationService.clearStackAndShow(OnboardingViewRoute());
          return;
        case AuthState.idle:
          _log.d('Auth state is initializing');
          return;
      }

      _userService.userInitializedStream.distinct().listen((userInitialized) {
        if (userInitialized) {
          _log.d('User initialized: Navigating to either MainView or CompleteProfileView');
          handleUserReady();
        }
      });
    });
  }

  void handleUserReady() {
    if (_userService.hasUser) {
      _log.d('Existing user has a document in Firestore: Navigating to MainView');
      _navigationService.clearStackAndShow(MainViewRoute());
    } else {
      _log.d('New user does not have a document yet in Firestore: Navigating to CompleteProfileView');
      _navigationService.clearStackAndShow(CompleteProfileViewRoute());
    }
  }

  Future<void> onViewLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    changeAnimationState();
    rotate();
    animateLight();
    await Future.delayed(const Duration(milliseconds: 6500));
  }

  Future<void> runStartupLogic() async {
    _log.i('Running startup logic');
    await _authenticationService.clearFirebaseUserOnFreshInstall();
    _analyticsService.logAppOpen();
    await onViewLoading();
    prepareUserSession();
  }
}
