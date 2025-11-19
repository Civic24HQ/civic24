import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/auth/auth_viewmodel.dart';
import 'package:citizen/ui/views/auth/forgot_password/forgot_password_view.form.dart';
import 'package:services/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class ForgotPasswordViewModel extends AuthViewModel {
  final _log = getLogger('ForgotPasswordViewModel');
  final _navigationService = locator<RouterService>();
  // final _alertService = locator<AlertService>();
  final _urlLauncherService = locator<UrlLauncherService>();
  final _dialogService = locator<DialogService>();

  Future<void> resetPassword() async {
    if (!isFormValid) {
      return;
    }
    try {
      _log.i('$emailValue');
      await runBusyFuture(authenticationService.sendPasswordResetEmail(emailValue!), throwException: true);

      final response = await _dialogService.showCustomDialog(
        variant: DialogType.sendPasswordResetEmail,
        data: emailValue,
      );

      if (response != null && response.confirmed) {
        _log.i('Password Reset Email Sent');
        navigateToLoginUp();
        await _urlLauncherService.openEmailAppChooser();
      }

      // _alertService.showErrorAlert(
      //   title: 'Password Reset Email Sent',
      //   message:
      //       'A password reset email has been sent to $emailValue. Please check your inbox and follow the instructions to reset your password.',
      // );
    } catch (e) {
      _log.e('Error sending password reset email, error: $e');
    }
  }

  void navigateToLoginUp() => _navigationService.replaceWithLoginView();
}
