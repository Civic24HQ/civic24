import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/auth/auth_viewmodel.dart';
import 'package:citizen/ui/views/auth/forgot_password/forgot_password_view.form.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends AuthViewModel {
  final _navigationService = locator<RouterService>();

  Future<void> resetPassword() async {
    if (!isFormValid) {
      return;
    }
  }

  void navigateToLoginUp() => _navigationService.replaceWithLoginView();
}
