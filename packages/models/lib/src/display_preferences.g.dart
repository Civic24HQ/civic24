// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DisplayPreferencesImpl _$$DisplayPreferencesImplFromJson(
  Map<String, dynamic> json,
) => _$DisplayPreferencesImpl(
  language: json['language'] as String? ?? 'en',
  themeModeIndex: (json['themeModeIndex'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DisplayPreferencesImplToJson(
  _$DisplayPreferencesImpl instance,
) => <String, dynamic>{
  'language': instance.language,
  'themeModeIndex': instance.themeModeIndex,
};
