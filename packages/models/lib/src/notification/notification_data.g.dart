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
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      hasBeenSeen: json['hasBeenSeen'] as bool? ?? false,
      userId: json['userId'] as String?,
      notificationIconData: json['notificationIconData'] as String?,
      path: json['path'] as String?,
      type:
          $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']) ??
          NotificationType.unknown,
      actorUserId: json['actorUserId'] as String?,
      actorName: json['actorName'] as String?,
      reportId: json['reportId'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(_NotificationData instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'title': instance.title,
      'description': instance.description,
      'createdAt': ?const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': ?const TimestampConverter().toJson(instance.updatedAt),
      'hasBeenSeen': instance.hasBeenSeen,
      'userId': ?instance.userId,
      'notificationIconData': ?instance.notificationIconData,
      'path': ?instance.path,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'actorUserId': ?instance.actorUserId,
      'actorName': ?instance.actorName,
      'reportId': ?instance.reportId,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.unknown: 'unknown',
  NotificationType.reportCreated: 'reportCreated',
  NotificationType.reportLiked: 'reportLiked',
  NotificationType.reportDisliked: 'reportDisliked',
};
