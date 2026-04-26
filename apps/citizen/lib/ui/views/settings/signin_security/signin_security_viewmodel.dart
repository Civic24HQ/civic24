import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInSecurityViewModel extends ReactiveViewModel {
  // final _log = getLogger('SignInSecurityViewModel');
  final _userService = locator<UserService>();
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<RouterService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  UserModel? get currentUser => _userService.user;

  bool isGoogleAuthLinked() => _authService.hasGoogleProvider;

  bool isAppleAuthLinked() => _authService.hasAppleProvider;

  bool isPasswordSet() => _authService.hasPasswordProvider;

  Future<void> navigateToGoogleAuth() async {
    _analyticsService.logButtonClick(kAnalyticButtonAuthGoogle);
    final success = await _authService.continueWithGoogle();
    if (success) {
      await _userService.waitUntilUserIsReady();
    }
  }

  Future<void> navigateToAppleAuth() async {}

  Future<void> navigateToUpdatePassword() async {
    await _navigationService.navigateToUpdatePasswordView(isPasswordSet: isPasswordSet());
  }
}
