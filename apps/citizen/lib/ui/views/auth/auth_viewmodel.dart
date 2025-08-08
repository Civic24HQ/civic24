import 'package:stacked/stacked.dart';

enum AuthMethod { email, google, apple }

abstract class AuthViewModel extends FormViewModel {
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

  Future<void> handleGoogle() async {}

  void setAuthBusy(AuthMethod method) => setBusyForObject(method, true);

  void setAuthNotBusy(AuthMethod method) => setBusyForObject(method, false);
}
