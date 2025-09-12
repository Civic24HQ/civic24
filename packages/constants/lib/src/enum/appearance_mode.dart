import 'package:localization/localization.dart';

enum AppearanceMode {
  system,
  light,
  dark;

  String get title => switch (this) {
    AppearanceMode.system => l10n.featureSettingsAppearanceSystem,
    AppearanceMode.light => l10n.featureSettingsAppearanceLight,
    AppearanceMode.dark => l10n.featureSettingsAppearanceDark,
  };

  String get description => switch (this) {
    AppearanceMode.system => l10n.featureSettingsAppearanceSystemDesc,
    AppearanceMode.light => l10n.featureSettingsAppearanceLightDesc,
    AppearanceMode.dark => l10n.featureSettingsAppearanceDarkDesc,
  };

  int get themeIndex => switch (this) {
    AppearanceMode.system => 0,
    AppearanceMode.light => 1,
    AppearanceMode.dark => 2,
  };
}
