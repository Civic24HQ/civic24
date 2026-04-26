import 'package:constants/constants.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class LanguageSettingsViewModel extends BaseViewModel {
  final _userService = serviceLocator<UserService>();

  LanguageType get selectedLanguage => _userService.displayPreferences.languageType;

  void onLanguageChanged(LanguageType language) {
    _userService.setLanguage(language);
  }
}
