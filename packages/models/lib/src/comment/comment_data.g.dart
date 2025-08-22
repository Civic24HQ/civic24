// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentDataImpl _$$CommentDataImplFromJson(Map<String, dynamic> json) =>
    _$CommentDataImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      comment: json['comment'] as String,
      likeCount: (json['likeCount'] as num).toInt(),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp,
      ),
      userId: json['userId'] as String?,
      userImageUrl: json['userImageUrl'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$$CommentDataImplToJson(_$CommentDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'comment': instance.comment,
      'likeCount': instance.likeCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      if (instance.userId case final value?) 'userId': value,
      if (instance.userImageUrl case final value?) 'userImageUrl': value,
      if (instance.path case final value?) 'path': value,
    };
