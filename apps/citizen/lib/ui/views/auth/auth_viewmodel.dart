import 'package:citizen/app/app.locator.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

enum AuthMethod { email, google, apple }

abstract class AuthViewModel extends FormViewModel {
  final authenticationService = locator<AuthenticationService>();
  final userService = locator<UserService>();

  bool _showPassword = false;
  bool get showPassword => _showPassword;

  bool get isAppleSignInAvailable => true;

  bool get isAppleButtonBusy => busy(AuthMethod.apple);
  bool get isGoogleButtonBusy => busy(AuthMethod.google);
  bool get isEmailButtonBusy => busy(AuthMethod.email);

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    rebuildUi();
  }

  Future<void> handleApple() async {}

  Future<void> handleGoogle() async {
    // TODO(Civic24): Implement Analytics Event for Google Sign In Attempt
    setAuthBusy(AuthMethod.google);
    final success = await authenticationService.continueWithGoogle();
    if (success) {
      await userService.waitUntilUserIsReady();
    }
    setAuthNotBusy(AuthMethod.google);
  }

  void setAuthBusy(AuthMethod method) => setBusyForObject(method, true);

  void setAuthNotBusy(AuthMethod method) => setBusyForObject(method, false);
}
