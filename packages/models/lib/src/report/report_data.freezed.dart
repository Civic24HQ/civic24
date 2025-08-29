// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReportData _$ReportDataFromJson(Map<String, dynamic> json) {
  return _ReportData.fromJson(json);
}

/// @nodoc
mixin _$ReportData {
  /// Unique identifier for the report.
  String get reportId => throw _privateConstructorUsedError;

  /// FirstName of the User who created the report.
  String get firstName => throw _privateConstructorUsedError;

  /// LastName of the User who created the report.
  String get lastName => throw _privateConstructorUsedError;

  /// Country where the report was created.
  String get country => throw _privateConstructorUsedError;

  /// State where the report was created.
  String get state => throw _privateConstructorUsedError;

  /// The content of the report.
  String get content => throw _privateConstructorUsedError;

  /// Type of the report (Waste, Electricity, Road)
  CategoryType get type => throw _privateConstructorUsedError;

  /// Number of likes the report has received.
  int get likeCount => throw _privateConstructorUsedError;

  /// Number of dislikes on the report.
  int get dislikeCount => throw _privateConstructorUsedError;

  /// Number of comments on the report.
  int get commentCount => throw _privateConstructorUsedError;

  /// Number of bookmarks for the report.
  int get bookmarkCount => throw _privateConstructorUsedError;

  /// The date when the report was created.
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The date when the report was last updated.
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// The URL of the images or videos associated with the report.
  List<String>? get media => throw _privateConstructorUsedError;

  /// The id of the user who created the report.
  String? get userId => throw _privateConstructorUsedError;

  /// The image URL of the user who created the report.
  String? get userImageUrl => throw _privateConstructorUsedError;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this ReportData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportDataCopyWith<ReportData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportDataCopyWith<$Res> {
  factory $ReportDataCopyWith(
    ReportData value,
    $Res Function(ReportData) then,
  ) = _$ReportDataCopyWithImpl<$Res, ReportData>;
  @useResult
  $Res call({
    String reportId,
    String firstName,
    String lastName,
    String country,
    String state,
    String content,
    CategoryType type,
    int likeCount,
    int dislikeCount,
    int commentCount,
    int bookmarkCount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    List<String>? media,
    String? userId,
    String? userImageUrl,
    String? path,
  });
}

/// @nodoc
class _$ReportDataCopyWithImpl<$Res, $Val extends ReportData>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? country = null,
    Object? state = null,
    Object? content = null,
    Object? type = null,
    Object? likeCount = null,
    Object? dislikeCount = null,
    Object? commentCount = null,
    Object? bookmarkCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? media = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _value.copyWith(
            reportId: null == reportId
                ? _value.reportId
                : reportId // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CategoryType,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            dislikeCount: null == dislikeCount
                ? _value.dislikeCount
                : dislikeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            bookmarkCount: null == bookmarkCount
                ? _value.bookmarkCount
                : bookmarkCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            media: freezed == media
                ? _value.media
                : media // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
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
abstract class _$$ReportDataImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$ReportDataImplCopyWith(
    _$ReportDataImpl value,
    $Res Function(_$ReportDataImpl) then,
  ) = __$$ReportDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String reportId,
    String firstName,
    String lastName,
    String country,
    String state,
    String content,
    CategoryType type,
    int likeCount,
    int dislikeCount,
    int commentCount,
    int bookmarkCount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    List<String>? media,
    String? userId,
    String? userImageUrl,
    String? path,
  });
}

/// @nodoc
class __$$ReportDataImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$ReportDataImpl>
    implements _$$ReportDataImplCopyWith<$Res> {
  __$$ReportDataImplCopyWithImpl(
    _$ReportDataImpl _value,
    $Res Function(_$ReportDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? country = null,
    Object? state = null,
    Object? content = null,
    Object? type = null,
    Object? likeCount = null,
    Object? dislikeCount = null,
    Object? commentCount = null,
    Object? bookmarkCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? media = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _$ReportDataImpl(
        reportId: null == reportId
            ? _value.reportId
            : reportId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CategoryType,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        dislikeCount: null == dislikeCount
            ? _value.dislikeCount
            : dislikeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        bookmarkCount: null == bookmarkCount
            ? _value.bookmarkCount
            : bookmarkCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        media: freezed == media
            ? _value._media
            : media // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
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
class _$ReportDataImpl extends _ReportData {
  const _$ReportDataImpl({
    required this.reportId,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.state,
    required this.content,
    required this.type,
    required this.likeCount,
    required this.dislikeCount,
    required this.commentCount,
    required this.bookmarkCount,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
    final List<String>? media = const [],
    this.userId,
    this.userImageUrl,
    this.path,
  }) : _media = media,
       super._();

  factory _$ReportDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportDataImplFromJson(json);

  /// Unique identifier for the report.
  @override
  final String reportId;

  /// FirstName of the User who created the report.
  @override
  final String firstName;

  /// LastName of the User who created the report.
  @override
  final String lastName;

  /// Country where the report was created.
  @override
  final String country;

  /// State where the report was created.
  @override
  final String state;

  /// The content of the report.
  @override
  final String content;

  /// Type of the report (Waste, Electricity, Road)
  @override
  final CategoryType type;

  /// Number of likes the report has received.
  @override
  final int likeCount;

  /// Number of dislikes on the report.
  @override
  final int dislikeCount;

  /// Number of comments on the report.
  @override
  final int commentCount;

  /// Number of bookmarks for the report.
  @override
  final int bookmarkCount;

  /// The date when the report was created.
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// The date when the report was last updated.
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  /// The URL of the images or videos associated with the report.
  final List<String>? _media;

  /// The URL of the images or videos associated with the report.
  @override
  @JsonKey()
  List<String>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// The id of the user who created the report.
  @override
  final String? userId;

  /// The image URL of the user who created the report.
  @override
  final String? userImageUrl;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  final String? path;

  @override
  String toString() {
    return 'ReportData(reportId: $reportId, firstName: $firstName, lastName: $lastName, country: $country, state: $state, content: $content, type: $type, likeCount: $likeCount, dislikeCount: $dislikeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, createdAt: $createdAt, updatedAt: $updatedAt, media: $media, userId: $userId, userImageUrl: $userImageUrl, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportDataImpl &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.dislikeCount, dislikeCount) ||
                other.dislikeCount == dislikeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.bookmarkCount, bookmarkCount) ||
                other.bookmarkCount == bookmarkCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userImageUrl, userImageUrl) ||
                other.userImageUrl == userImageUrl) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    reportId,
    firstName,
    lastName,
    country,
    state,
    content,
    type,
    likeCount,
    dislikeCount,
    commentCount,
    bookmarkCount,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_media),
    userId,
    userImageUrl,
    path,
  );

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      __$$ReportDataImplCopyWithImpl<_$ReportDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportDataImplToJson(this);
  }
}

abstract class _ReportData extends ReportData {
  const factory _ReportData({
    required final String reportId,
    required final String firstName,
    required final String lastName,
    required final String country,
    required final String state,
    required final String content,
    required final CategoryType type,
    required final int likeCount,
    required final int dislikeCount,
    required final int commentCount,
    required final int bookmarkCount,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
    final List<String>? media,
    final String? userId,
    final String? userImageUrl,
    final String? path,
  }) = _$ReportDataImpl;
  const _ReportData._() : super._();

  factory _ReportData.fromJson(Map<String, dynamic> json) =
      _$ReportDataImpl.fromJson;

  /// Unique identifier for the report.
  @override
  String get reportId;

  /// FirstName of the User who created the report.
  @override
  String get firstName;

  /// LastName of the User who created the report.
  @override
  String get lastName;

  /// Country where the report was created.
  @override
  String get country;

  /// State where the report was created.
  @override
  String get state;

  /// The content of the report.
  @override
  String get content;

  /// Type of the report (Waste, Electricity, Road)
  @override
  CategoryType get type;

  /// Number of likes the report has received.
  @override
  int get likeCount;

  /// Number of dislikes on the report.
  @override
  int get dislikeCount;

  /// Number of comments on the report.
  @override
  int get commentCount;

  /// Number of bookmarks for the report.
  @override
  int get bookmarkCount;

  /// The date when the report was created.
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// The date when the report was last updated.
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// The URL of the images or videos associated with the report.
  @override
  List<String>? get media;

  /// The id of the user who created the report.
  @override
  String? get userId;

  /// The image URL of the user who created the report.
  @override
  String? get userImageUrl;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  String? get path;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
