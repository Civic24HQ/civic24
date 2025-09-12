import 'package:constants/constants.dart';
import 'package:stacked/stacked.dart';

class AppearanceSettingsViewModel extends BaseViewModel {
  AppearanceMode get selectedMode => AppearanceMode.system;

  void onAppearanceChanged(AppearanceMode mode) {}
}
