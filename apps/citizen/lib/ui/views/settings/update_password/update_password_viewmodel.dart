import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/ui/views/auth/auth_viewmodel.dart';
import 'package:citizen/ui/views/settings/update_password/update_password_view.form.dart';
import 'package:constants/constants.dart';
import 'package:services/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class UpdatePasswordViewModel extends AuthViewModel {
  final _urlLauncherService = locator<UrlLauncherService>();
  final _alertService = locator<AlertService>();
  final _dialogService = locator<DialogService>();
  final _log = getLogger('UpdatePasswordViewModel');

  Future<void> updatePassword() async {
    if (!isFormValid) {
      return;
    }
    analyticsService.logButtonClick(kAnalyticButtonResetPassword);
    try {
      _log.i('$emailValue');
      await runBusyFuture(authenticationService.sendPasswordResetEmail(emailValue!), throwException: true);

      final response = await _dialogService.showCustomDialog(
        variant: DialogType.sendPasswordResetEmail,
        data: emailValue,
      );

      if (response != null && response.confirmed) {
        _alertService.showSuccessAlert(
          title: 'Password Reset Email Sent',
          message: 'We sent a link to your email. Open it to set your password.',
        );
        await _urlLauncherService.openEmailAppChooser();
      }
    } catch (e) {
      _log.e('Error sending password reset email, error: $e');
    }
  }
}
