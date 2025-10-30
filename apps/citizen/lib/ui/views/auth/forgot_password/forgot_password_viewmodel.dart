import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/auth/auth_viewmodel.dart';
import 'package:citizen/ui/views/auth/forgot_password/forgot_password_view.form.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class ForgotPasswordViewModel extends AuthViewModel {
  final _log = getLogger('ForgotPasswordViewModel');
  final _navigationService = locator<RouterService>();

  Future<void> resetPassword() async {
    if (!isFormValid) {
      return;
    }
    try {
      await runBusyFuture(authenticationService.sendPasswordResetEmail(emailValue!), throwException: true);
      // TODO(Civic24): Replace Alert Dialog with Custom Dialog to inform user to check their email
      navigateToLoginUp();
      // TODO(Civic24): Implement Url Launcher Service to open email app
    } catch (e) {
      _log.e('Error sending password reset email, error: $e');
    }
  }

  void navigateToLoginUp() => _navigationService.replaceWithLoginView();
}
