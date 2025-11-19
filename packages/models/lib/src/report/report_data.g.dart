// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportDataImpl _$$ReportDataImplFromJson(Map<String, dynamic> json) =>
    _$ReportDataImpl(
      reportId: json['reportId'] as String,
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
      categoryTypes:
          (json['categoryTypes'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$CategoryTypeEnumMap, e))
              .toList() ??
          const [],
      path: json['path'] as String?,
    );

Map<String, dynamic> _$$ReportDataImplToJson(_$ReportDataImpl instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
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
      'categoryTypes': instance.categoryTypes
          .map((e) => _$CategoryTypeEnumMap[e]!)
          .toList(),
      if (instance.path case final value?) 'path': value,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.road: 'road',
  CategoryType.light: 'light',
  CategoryType.waste: 'waste',
  CategoryType.abandoned: 'abandoned',
  CategoryType.health: 'health',
  CategoryType.security: 'security',
  CategoryType.education: 'education',
  CategoryType.governance: 'governance',
  CategoryType.urban: 'urban',
};

_$ReportImpl _$$ReportImplFromJson(Map<String, dynamic> json) => _$ReportImpl(
  reportData: ReportData.fromJson(json['reportData'] as Map<String, dynamic>),
  hasLiked: json['hasLiked'] as bool? ?? false,
  hasDisliked: json['hasDisliked'] as bool? ?? false,
  hasBookmarked: json['hasBookmarked'] as bool? ?? false,
  path: json['path'] as String?,
);

Map<String, dynamic> _$$ReportImplToJson(_$ReportImpl instance) =>
    <String, dynamic>{
      'reportData': instance.reportData.toJson(),
      'hasLiked': instance.hasLiked,
      'hasDisliked': instance.hasDisliked,
      'hasBookmarked': instance.hasBookmarked,
      if (instance.path case final value?) 'path': value,
    };
