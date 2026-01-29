import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:models/utils/timestamp_converter.dart';

part 'comment_data.freezed.dart';
part 'comment_data.g.dart';

/// Represents a users comment with various attributes.
@freezed
abstract class CommentData with _$CommentData, SerializeJson {
  @JsonSerializable()
  const factory CommentData({
    /// Unique identifier for the comment.
    required String commentId,

    /// Unique identifier for the report where the comment was created.
    required String reportId,

    /// FirstName of the User who created the comment.
    required String firstName,

    /// LastName of the User who created the comment.
    required String lastName,

    /// The comment on the created report.
    required String comment,

    /// Number of likes the comment has received.
    required int likeCount,

    /// The date when the comment was created.
    @TimestampConverter() required DateTime createdAt,

    /// The date when the comment was last updated.
    @TimestampConverter() required DateTime updatedAt,

    /// The id of the user who created the comment.
    String? userId,

    /// The image URL of the user who created the comment.
    String? userImageUrl,

    /// The document reference path, only be
    /// parsed when converted from Firestore
    String? path,
  }) = _CommentData;
  const CommentData._();

  factory CommentData.fromJson(Map<String, dynamic> json) => _$CommentDataFromJson(json);

  /// Creates an unknown comment instance.
  factory CommentData.unknown() => CommentData(
    commentId: '0',
    reportId: '0',
    firstName: 'N/A',
    lastName: 'N/A',
    comment: 'No content available',
    likeCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  factory CommentData.empty() => CommentData(
    commentId: '',
    reportId: '',
    firstName: '',
    lastName: '',
    comment: '',
    likeCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  bool get basicInfoIsNotEmpty {
    return firstName.isNotEmpty && lastName.isNotEmpty && comment.isNotEmpty;
  }

  String get fullName => '$firstName $lastName';
}
