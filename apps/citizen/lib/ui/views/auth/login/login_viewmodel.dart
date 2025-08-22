import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/auth/auth_viewmodel.dart';
import 'package:citizen/ui/views/auth/login/login_view.form.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends AuthViewModel {
  final _navigationService = locator<RouterService>();

  void updateEmail(String value) {
    emailValue = value;
    notifyListeners();
  }

  Future<void> loginWithEmail() async {
    validateForm();
    if (!isFormValid) {
      await HapticFeedback.heavyImpact();
      return;
    }
  }

  void navigateToForgetPassword() =>
      _navigationService.navigateToForgotPasswordView(email: emailValue ?? '');

  void navigateToSignUp() => _navigationService.replaceWithSignupView();
}
