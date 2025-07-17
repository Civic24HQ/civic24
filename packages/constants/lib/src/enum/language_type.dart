enum LanguageType {
  arabic,
  english,
  french,
  hausa,
  igbo,
  spanish,
  yoruba;

  String get title => switch (this) {
    english => 'English',
    hausa => 'Hausa',
    yoruba => 'Yorùbá',
    igbo => 'Igbo',
    french => 'Français',
    spanish => 'Español',
    arabic => 'العربية',
  };

  String get subtitle => switch (this) {
    english => 'English',
    hausa => 'Hausa',
    yoruba => 'Yorùbá',
    igbo => 'Igbo',
    french => 'Français',
    spanish => 'Español',
    arabic => 'العربية',
  };

  String get locale => switch (this) {
    english => 'en',
    hausa => 'ha',
    yoruba => 'yo',
    igbo => 'ig',
    french => 'fr',
    spanish => 'es',
    arabic => 'ar',
  };

  String get flag => switch (this) {
    english => '🇺🇸',
    hausa => '🇳🇬',
    yoruba => '🇳🇬',
    igbo => '🇳🇬',
    french => '🇫🇷',
    spanish => '🇪🇸',
    arabic => '🇸🇦',
  };
}
