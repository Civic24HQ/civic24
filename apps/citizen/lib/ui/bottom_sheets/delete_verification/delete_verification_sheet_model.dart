import 'dart:async';

import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteVerificationSheetModel extends FormViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  final _authService = locator<AuthenticationService>();
  final _urlLauncherService = locator<UrlLauncherService>();
  final _userService = locator<UserService>();

  UserModel get user => _userService.user!;

  bool get isSocialAuth => user.isGoogleUser || user.isAppleUser;

  String _password = '';
  String get password => _password;

  String? _passwordError;
  String? get passwordError => _passwordError;

  bool get isButtonEnabled => _password.isNotEmpty;

  void updatePassword(String? value) {
    _password = value ?? '';
    _passwordError = null;
    rebuildUi();
  }

  Future<void> reauthenticateWithEmail() async {
    if (_password.isEmpty) {
      _passwordError = l10n.featureDialogDeleteVerificationEmptyPassword;
      notifyListeners();
      return;
    }

    unawaited(_dialogService.showCustomDialog(variant: DialogType.loading, title: 'Reauthenticating...'));

    final result = await _authService.reauthenticateUser(password: _password);
    _dialogService.completeDialog(DialogResponse());
    if (!result) {
      _passwordError = '';
      notifyListeners();
      return;
    }

    _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
  }

  Future<void> reauthenticateWithSocialAuth() async {
    unawaited(_dialogService.showCustomDialog(variant: DialogType.loading, title: 'Reauthenticating...'));
    final result = await _authService.reauthenticateUserWithProvider();
    _dialogService.completeDialog(DialogResponse());

    if (result) {
      _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
    }
  }

  Future<void> handleForgetPassword() async {
    await _authService.sendPasswordResetEmail(user.email);
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.sendPasswordResetEmail,
      data: user.email,
    );

    if (response != null && response.confirmed) {
      await _urlLauncherService.openEmailAppChooser();
    }
  }
}
