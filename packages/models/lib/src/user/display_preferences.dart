import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localization/localization.dart';

part 'display_preferences.freezed.dart';
part 'display_preferences.g.dart';

/// A model representing user-specific display preferences
/// that include language selection and theme mode
@freezed
class DisplayPreferences with _$DisplayPreferences {
  @JsonSerializable()
  const factory DisplayPreferences({
    /// The user's preferred language.
    /// Example: "en", "es"
    @Default('en') String language,

    /// The user's preferred theme mode.
    /// Example: "system - 0", "light - 1", "dark - 2", etc.
    @Default(0) int themeModeIndex,
  }) = _DisplayPreferences;
  const DisplayPreferences._();

  factory DisplayPreferences.fromJson(Map<String, dynamic> json) => _$DisplayPreferencesFromJson(json);

  /// Returns the [LanguageType] based on the [language].
  LanguageType get languageType =>
      LanguageType.values.firstWhere((e) => e.locale == language, orElse: () => LanguageType.english);

  /// Returns the [Locale] based on the user's preference.
  Locale get locale => delegate.supportedLocales.firstWhere(
    (element) => element.languageCode == language,
    orElse: () => const Locale('en'),
  );

  /// Returns the [ThemeMode] based on the [themeModeIndex].
  ThemeMode get themeMode => ThemeMode.values[themeModeIndex];

  /// Returns the [AppearanceMode] based on the [themeModeIndex].
  AppearanceMode get appearanceMode => AppearanceMode.values[themeModeIndex];
}
