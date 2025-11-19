import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/auth/auth_viewmodel.dart';
import 'package:citizen/ui/views/auth/signup/signup_view.form.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends AuthViewModel {
  final _navigationService = locator<RouterService>();

  void updateEmail(String value) {
    emailValue = value;
    notifyListeners();
  }

  Future<void> signUpWithEmail() async {
    validateForm();
    if (!isFormValid) {
      await HapticFeedback.heavyImpact();
      return;
    }
    setAuthBusy(AuthMethod.email);
    final success = await authenticationService.signUpWithEmailAndPassword(
      email: emailValue!,
      password: passwordValue!,
    );
    if (success) {
      await userService.waitUntilUserIsReady();
    }
    setAuthNotBusy(AuthMethod.email);
    // await _navigationService.replaceWithSuccessView(
    //   onProceed: navigateToLogin,
    //   iconPath: kSuccessLottie,
    //   title: l10n.featureSignUpSuccess,
    //   body: l10n.featureSignUpSuccessHint,
    //   buttonLabel: l10n.generalProceed,
    // );
  }

  void navigateToLogin() => _navigationService.replaceWithLoginView();
}
