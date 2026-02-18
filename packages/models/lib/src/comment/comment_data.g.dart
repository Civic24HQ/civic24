// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentData _$CommentDataFromJson(Map<String, dynamic> json) => _CommentData(
  commentId: json['commentId'] as String,
  reportId: json['reportId'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  comment: json['comment'] as String,
  likeCount: (json['likeCount'] as num).toInt(),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  userId: json['userId'] as String?,
  userImageUrl: json['userImageUrl'] as String?,
  path: json['path'] as String?,
);

Map<String, dynamic> _$CommentDataToJson(_CommentData instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'reportId': instance.reportId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'comment': instance.comment,
      'likeCount': instance.likeCount,
      'createdAt': ?const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': ?const TimestampConverter().toJson(instance.updatedAt),
      'userId': ?instance.userId,
      'userImageUrl': ?instance.userImageUrl,
      'path': ?instance.path,
    };
