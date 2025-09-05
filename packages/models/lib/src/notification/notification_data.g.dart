// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDataImpl _$$NotificationDataImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationDataImpl(
  notificationId: json['notificationId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: const TimestampConverter().fromJson(
    json['updatedAt'] as Timestamp,
  ),
  hasBeenSeen: json['hasBeenSeen'] as bool? ?? false,
  userId: json['userId'] as String?,
  notificationIconData: json['notificationIconData'] as String?,
  path: json['path'] as String?,
);

Map<String, dynamic> _$$NotificationDataImplToJson(
  _$NotificationDataImpl instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'title': instance.title,
  'description': instance.description,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'hasBeenSeen': instance.hasBeenSeen,
  if (instance.userId case final value?) 'userId': value,
  if (instance.notificationIconData case final value?)
    'notificationIconData': value,
  if (instance.path case final value?) 'path': value,
};
