import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:constants/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<RouterService>();
  final _dialogService = locator<DialogService>();

  // TODO(Civic24): Implement functionality to get actual app version
  final String appVersion = '0.0.1+1';

  Future<void> navigateToProfile() async {
    await _navigationService.navigateToProfileView();
  }

  Future<void> navigateToLanguageSettings() async {
    await _navigationService.navigateToLanguageSettingsView();
  }

  Future<void> navigateToAppearanceSettings() async {
    await _navigationService.navigateToAppearanceSettingsView();
  }

  void navigateToAboutSettings() {}

  Future<bool> showLogoutConfirmationDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.logout,
      barrierDismissible: true,
    );

    if (response != null && response.confirmed) {
      return response.data == DialogActionType.main;
    }
    return false;
  }
}
