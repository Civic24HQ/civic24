// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    _NotificationData(
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

Map<String, dynamic> _$NotificationDataToJson(_NotificationData instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'title': instance.title,
      'description': instance.description,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'hasBeenSeen': instance.hasBeenSeen,
      'userId': ?instance.userId,
      'notificationIconData': ?instance.notificationIconData,
      'path': ?instance.path,
    };
