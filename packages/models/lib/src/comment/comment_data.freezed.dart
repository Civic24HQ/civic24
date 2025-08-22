// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommentData _$CommentDataFromJson(Map<String, dynamic> json) {
  return _CommentData.fromJson(json);
}

/// @nodoc
mixin _$CommentData {
  /// Unique identifier for the comment.
  String get id => throw _privateConstructorUsedError;

  /// FirstName of the User who created the comment.
  String get firstName => throw _privateConstructorUsedError;

  /// LastName of the User who created the comment.
  String get lastName => throw _privateConstructorUsedError;

  /// The comment on the created post.
  String get comment => throw _privateConstructorUsedError;

  /// Number of likes the comment has received.
  int get likeCount => throw _privateConstructorUsedError;

  /// The date when the comment was created.
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The date when the comment was last updated.
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// The id of the user who created the comment.
  String? get userId => throw _privateConstructorUsedError;

  /// The image URL of the user who created the comment.
  String? get userImageUrl => throw _privateConstructorUsedError;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this CommentData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentDataCopyWith<CommentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentDataCopyWith<$Res> {
  factory $CommentDataCopyWith(
    CommentData value,
    $Res Function(CommentData) then,
  ) = _$CommentDataCopyWithImpl<$Res, CommentData>;
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String comment,
    int likeCount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    String? userId,
    String? userImageUrl,
    String? path,
  });
}

/// @nodoc
class _$CommentDataCopyWithImpl<$Res, $Val extends CommentData>
    implements $CommentDataCopyWith<$Res> {
  _$CommentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? comment = null,
    Object? likeCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            comment: null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            userImageUrl: freezed == userImageUrl
                ? _value.userImageUrl
                : userImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommentDataImplCopyWith<$Res>
    implements $CommentDataCopyWith<$Res> {
  factory _$$CommentDataImplCopyWith(
    _$CommentDataImpl value,
    $Res Function(_$CommentDataImpl) then,
  ) = __$$CommentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String comment,
    int likeCount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    String? userId,
    String? userImageUrl,
    String? path,
  });
}

/// @nodoc
class __$$CommentDataImplCopyWithImpl<$Res>
    extends _$CommentDataCopyWithImpl<$Res, _$CommentDataImpl>
    implements _$$CommentDataImplCopyWith<$Res> {
  __$$CommentDataImplCopyWithImpl(
    _$CommentDataImpl _value,
    $Res Function(_$CommentDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? comment = null,
    Object? likeCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _$CommentDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        comment: null == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        userImageUrl: freezed == userImageUrl
            ? _value.userImageUrl
            : userImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        path: freezed == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable()
class _$CommentDataImpl extends _CommentData {
  const _$CommentDataImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.comment,
    required this.likeCount,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
    this.userId,
    this.userImageUrl,
    this.path,
  }) : super._();

  factory _$CommentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentDataImplFromJson(json);

  /// Unique identifier for the comment.
  @override
  final String id;

  /// FirstName of the User who created the comment.
  @override
  final String firstName;

  /// LastName of the User who created the comment.
  @override
  final String lastName;

  /// The comment on the created post.
  @override
  final String comment;

  /// Number of likes the comment has received.
  @override
  final int likeCount;

  /// The date when the comment was created.
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// The date when the comment was last updated.
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  /// The id of the user who created the comment.
  @override
  final String? userId;

  /// The image URL of the user who created the comment.
  @override
  final String? userImageUrl;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  final String? path;

  @override
  String toString() {
    return 'CommentData(id: $id, firstName: $firstName, lastName: $lastName, comment: $comment, likeCount: $likeCount, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, userImageUrl: $userImageUrl, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userImageUrl, userImageUrl) ||
                other.userImageUrl == userImageUrl) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    firstName,
    lastName,
    comment,
    likeCount,
    createdAt,
    updatedAt,
    userId,
    userImageUrl,
    path,
  );

  /// Create a copy of CommentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentDataImplCopyWith<_$CommentDataImpl> get copyWith =>
      __$$CommentDataImplCopyWithImpl<_$CommentDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentDataImplToJson(this);
  }
}

abstract class _CommentData extends CommentData {
  const factory _CommentData({
    required final String id,
    required final String firstName,
    required final String lastName,
    required final String comment,
    required final int likeCount,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
    final String? userId,
    final String? userImageUrl,
    final String? path,
  }) = _$CommentDataImpl;
  const _CommentData._() : super._();

  factory _CommentData.fromJson(Map<String, dynamic> json) =
      _$CommentDataImpl.fromJson;

  /// Unique identifier for the comment.
  @override
  String get id;

  /// FirstName of the User who created the comment.
  @override
  String get firstName;

  /// LastName of the User who created the comment.
  @override
  String get lastName;

  /// The comment on the created post.
  @override
  String get comment;

  /// Number of likes the comment has received.
  @override
  int get likeCount;

  /// The date when the comment was created.
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// The date when the comment was last updated.
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// The id of the user who created the comment.
  @override
  String? get userId;

  /// The image URL of the user who created the comment.
  @override
  String? get userImageUrl;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  String? get path;

  /// Create a copy of CommentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentDataImplCopyWith<_$CommentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
