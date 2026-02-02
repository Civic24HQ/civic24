// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DisplayPreferences _$DisplayPreferencesFromJson(Map<String, dynamic> json) =>
    _DisplayPreferences(
      language: json['language'] as String? ?? 'en',
      themeModeIndex: (json['themeModeIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DisplayPreferencesToJson(_DisplayPreferences instance) =>
    <String, dynamic>{
      'language': instance.language,
      'themeModeIndex': instance.themeModeIndex,
    };
