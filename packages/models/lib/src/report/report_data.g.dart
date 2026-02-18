// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportData _$ReportDataFromJson(Map<String, dynamic> json) => _ReportData(
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
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
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

Map<String, dynamic> _$ReportDataToJson(_ReportData instance) =>
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
      'createdAt': ?const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': ?const TimestampConverter().toJson(instance.updatedAt),
      'media': ?instance.media,
      'userId': ?instance.userId,
      'userImageUrl': ?instance.userImageUrl,
      'categoryTypes': instance.categoryTypes
          .map((e) => _$CategoryTypeEnumMap[e]!)
          .toList(),
      'path': ?instance.path,
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

_Report _$ReportFromJson(Map<String, dynamic> json) => _Report(
  reportData: ReportData.fromJson(json['reportData'] as Map<String, dynamic>),
  hasLiked: json['hasLiked'] as bool? ?? false,
  hasDisliked: json['hasDisliked'] as bool? ?? false,
  hasBookmarked: json['hasBookmarked'] as bool? ?? false,
  path: json['path'] as String?,
);

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'reportData': instance.reportData.toJson(),
  'hasLiked': instance.hasLiked,
  'hasDisliked': instance.hasDisliked,
  'hasBookmarked': instance.hasBookmarked,
  'path': ?instance.path,
};
