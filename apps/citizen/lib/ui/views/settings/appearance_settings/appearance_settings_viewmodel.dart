import 'package:constants/constants.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class AppearanceSettingsViewModel extends BaseViewModel {
  final _userService = serviceLocator<UserService>();

  AppearanceMode get selectedMode => _userService.displayPreferences.appearanceMode;

  void onAppearanceChanged(AppearanceMode mode) {
    _userService.setAppearance(mode);
  }
}
