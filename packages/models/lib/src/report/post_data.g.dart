// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostDataImpl _$$PostDataImplFromJson(Map<String, dynamic> json) =>
    _$PostDataImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      content: json['content'] as String,
      likeCount: (json['likeCount'] as num).toInt(),
      dislikeCount: (json['dislikeCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      bookmarkCount: (json['bookmarkCount'] as num).toInt(),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp,
      ),
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      userId: json['userId'] as String?,
      userImageUrl: json['userImageUrl'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$$PostDataImplToJson(_$PostDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'country': instance.country,
      'state': instance.state,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'commentCount': instance.commentCount,
      'bookmarkCount': instance.bookmarkCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      if (instance.media case final value?) 'media': value,
      if (instance.userId case final value?) 'userId': value,
      if (instance.userImageUrl case final value?) 'userImageUrl': value,
      if (instance.path case final value?) 'path': value,
    };
