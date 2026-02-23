// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Interaction _$InteractionFromJson(Map<String, dynamic> json) => _Interaction(
  userId: json['userId'] as String,
  hasLiked: json['hasLiked'] as bool? ?? false,
  hasDisliked: json['hasDisliked'] as bool? ?? false,
  hasBookmarked: json['hasBookmarked'] as bool? ?? false,
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$InteractionToJson(_Interaction instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'hasLiked': instance.hasLiked,
      'hasDisliked': instance.hasDisliked,
      'hasBookmarked': instance.hasBookmarked,
      'updatedAt': ?_$JsonConverterToJson<Object?, DateTime>(
        instance.updatedAt,
        const TimestampConverter().toJson,
      ),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
