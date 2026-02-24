import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/utils/timestamp_converter.dart';

part 'interaction.freezed.dart';
part 'interaction.g.dart';

@freezed
abstract class Interaction with _$Interaction {
  @JsonSerializable()
  const factory Interaction({
    @Default(false) bool hasLiked,

    @Default(false) bool hasDisliked,

    @Default(false) bool hasBookmarked,

    @TimestampConverter() DateTime? updatedAt,
  }) = _Interaction;

  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);
}
