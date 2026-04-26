// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPreferences _$NotificationPreferencesFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferences(
  pushEnabled: json['pushEnabled'] as bool? ?? true,
  likesEnabled: json['likesEnabled'] as bool? ?? true,
  dislikesEnabled: json['dislikesEnabled'] as bool? ?? true,
  reportCreatedEnabled: json['reportCreatedEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationPreferencesToJson(
  _NotificationPreferences instance,
) => <String, dynamic>{
  'pushEnabled': instance.pushEnabled,
  'likesEnabled': instance.likesEnabled,
  'dislikesEnabled': instance.dislikesEnabled,
  'reportCreatedEnabled': instance.reportCreatedEnabled,
};
