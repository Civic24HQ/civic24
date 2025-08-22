import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:models/utils/timestamp_converter.dart';

part 'post_data.freezed.dart';
part 'post_data.g.dart';

/// Represents a users post with various attributes.
@freezed
class PostData with _$PostData, SerializeJson {
  @JsonSerializable()
  const factory PostData({
    /// Unique identifier for the post.
    required String id,

    /// FirstName of the User who created the post.
    required String firstName,

    /// LastName of the User who created the post.
    required String lastName,

    /// Country where the post was created.
    required String country,

    /// State where the post was created.
    required String state,

    /// The content of the post.
    required String content,

    /// Number of likes the post has received.
    required int likeCount,

    /// Number of dislikes on the post.
    required int dislikeCount,

    /// Number of comments on the post.
    required int commentCount,

    /// Number of bookmarks for the post.
    required int bookmarkCount,

    /// The date when the post was created.
    @TimestampConverter() required DateTime createdAt,

    /// The date when the post was last updated.
    @TimestampConverter() required DateTime updatedAt,

    /// The URL of the images or videos associated with the post.
    @Default([]) List<String>? media,

    /// The id of the user who created the post.
    String? userId,

    /// The image URL of the user who created the post.
    String? userImageUrl,

    /// The document reference path, only be
    /// parsed when converted from Firestore
    String? path,
  }) = _PostData;
  const PostData._();

  factory PostData.fromJson(Map<String, dynamic> json) => _$PostDataFromJson(json);

  /// Creates an unknown post instance.
  factory PostData.unknown() => PostData(
    id: '0',
    firstName: 'N/A',
    lastName: 'N/A',
    country: 'Location unknown',
    state: 'Region unknown',
    content: 'No content available',
    likeCount: 0,
    dislikeCount: 0,
    commentCount: 0,
    bookmarkCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  factory PostData.empty() => PostData(
    id: '',
    firstName: '',
    lastName: '',
    country: '',
    state: '',
    content: '',
    likeCount: 0,
    dislikeCount: 0,
    commentCount: 0,
    bookmarkCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  bool get basicInfoIsNotEmpty {
    return firstName.isNotEmpty && lastName.isNotEmpty && state.isNotEmpty && country.isNotEmpty;
  }

  String get fullName => '$firstName $lastName';

  String get location => '$state, $country';
}
