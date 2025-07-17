enum AppearanceMode {
  system,
  light,
  dark;

  String get title => switch (this) {
    AppearanceMode.system => 'System Settings',
    AppearanceMode.light => 'Light Mode',
    AppearanceMode.dark => 'Dark Mode',
  };

  String get description => switch (this) {
    AppearanceMode.system => 'System Settings',
    AppearanceMode.light => 'Light Mode',
    AppearanceMode.dark => 'Dark Mode',
  };

  int get themeIndex => switch (this) {
    AppearanceMode.system => 0,
    AppearanceMode.light => 1,
    AppearanceMode.dark => 2,
  };
}
