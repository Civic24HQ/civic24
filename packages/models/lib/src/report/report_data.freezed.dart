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

  /// FirstName of the user who created the report.
  String get firstName => throw _privateConstructorUsedError;

  /// LastName of the user who created the report.
  String get lastName => throw _privateConstructorUsedError;

  /// Country where the report was created.
  String get country => throw _privateConstructorUsedError;

  /// State where the report was created.
  String get state => throw _privateConstructorUsedError;

  /// The content of the report.
  String get content => throw _privateConstructorUsedError;

  /// Number of likes the report has received (aggregate).
  int get likeCount => throw _privateConstructorUsedError;

  /// Number of dislikes on the report (aggregate).
  int get dislikeCount => throw _privateConstructorUsedError;

  /// Number of comments on the report (aggregate).
  int get commentCount => throw _privateConstructorUsedError;

  /// Number of bookmarks for the report (aggregate).
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

  /// The user’s preferred category types.
  /// Example: [CategoryType.waste, CategoryType.road].
  List<CategoryType> get categoryTypes => throw _privateConstructorUsedError;

  /// The document reference path, only parsed
  /// when converted from Firestore.
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
    int likeCount,
    int dislikeCount,
    int commentCount,
    int bookmarkCount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    List<String>? media,
    String? userId,
    String? userImageUrl,
    List<CategoryType> categoryTypes,
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
    Object? likeCount = null,
    Object? dislikeCount = null,
    Object? commentCount = null,
    Object? bookmarkCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? media = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? categoryTypes = null,
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
            categoryTypes: null == categoryTypes
                ? _value.categoryTypes
                : categoryTypes // ignore: cast_nullable_to_non_nullable
                      as List<CategoryType>,
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
    int likeCount,
    int dislikeCount,
    int commentCount,
    int bookmarkCount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    List<String>? media,
    String? userId,
    String? userImageUrl,
    List<CategoryType> categoryTypes,
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
    Object? likeCount = null,
    Object? dislikeCount = null,
    Object? commentCount = null,
    Object? bookmarkCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? media = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? categoryTypes = null,
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
        categoryTypes: null == categoryTypes
            ? _value._categoryTypes
            : categoryTypes // ignore: cast_nullable_to_non_nullable
                  as List<CategoryType>,
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
    required this.likeCount,
    required this.dislikeCount,
    required this.commentCount,
    required this.bookmarkCount,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
    final List<String>? media = const [],
    this.userId,
    this.userImageUrl,
    final List<CategoryType> categoryTypes = const [],
    this.path,
  }) : _media = media,
       _categoryTypes = categoryTypes,
       super._();

  factory _$ReportDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportDataImplFromJson(json);

  /// Unique identifier for the report.
  @override
  final String reportId;

  /// FirstName of the user who created the report.
  @override
  final String firstName;

  /// LastName of the user who created the report.
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

  /// Number of likes the report has received (aggregate).
  @override
  final int likeCount;

  /// Number of dislikes on the report (aggregate).
  @override
  final int dislikeCount;

  /// Number of comments on the report (aggregate).
  @override
  final int commentCount;

  /// Number of bookmarks for the report (aggregate).
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

  /// The user’s preferred category types.
  /// Example: [CategoryType.waste, CategoryType.road].
  final List<CategoryType> _categoryTypes;

  /// The user’s preferred category types.
  /// Example: [CategoryType.waste, CategoryType.road].
  @override
  @JsonKey()
  List<CategoryType> get categoryTypes {
    if (_categoryTypes is EqualUnmodifiableListView) return _categoryTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryTypes);
  }

  /// The document reference path, only parsed
  /// when converted from Firestore.
  @override
  final String? path;

  @override
  String toString() {
    return 'ReportData(reportId: $reportId, firstName: $firstName, lastName: $lastName, country: $country, state: $state, content: $content, likeCount: $likeCount, dislikeCount: $dislikeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, createdAt: $createdAt, updatedAt: $updatedAt, media: $media, userId: $userId, userImageUrl: $userImageUrl, categoryTypes: $categoryTypes, path: $path)';
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
            const DeepCollectionEquality().equals(
              other._categoryTypes,
              _categoryTypes,
            ) &&
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
    likeCount,
    dislikeCount,
    commentCount,
    bookmarkCount,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_media),
    userId,
    userImageUrl,
    const DeepCollectionEquality().hash(_categoryTypes),
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
    required final int likeCount,
    required final int dislikeCount,
    required final int commentCount,
    required final int bookmarkCount,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
    final List<String>? media,
    final String? userId,
    final String? userImageUrl,
    final List<CategoryType> categoryTypes,
    final String? path,
  }) = _$ReportDataImpl;
  const _ReportData._() : super._();

  factory _ReportData.fromJson(Map<String, dynamic> json) =
      _$ReportDataImpl.fromJson;

  /// Unique identifier for the report.
  @override
  String get reportId;

  /// FirstName of the user who created the report.
  @override
  String get firstName;

  /// LastName of the user who created the report.
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

  /// Number of likes the report has received (aggregate).
  @override
  int get likeCount;

  /// Number of dislikes on the report (aggregate).
  @override
  int get dislikeCount;

  /// Number of comments on the report (aggregate).
  @override
  int get commentCount;

  /// Number of bookmarks for the report (aggregate).
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

  /// The user’s preferred category types.
  /// Example: [CategoryType.waste, CategoryType.road].
  @override
  List<CategoryType> get categoryTypes;

  /// The document reference path, only parsed
  /// when converted from Firestore.
  @override
  String? get path;

  /// Create a copy of ReportData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Report _$ReportFromJson(Map<String, dynamic> json) {
  return _Report.fromJson(json);
}

/// @nodoc
mixin _$Report {
  /// The report data model associated with this report.
  ReportData get reportData => throw _privateConstructorUsedError;

  /// The variable the checks if the current user has liked the report.
  bool get hasLiked => throw _privateConstructorUsedError;

  /// The variable that checks if the current user has disliked the report.
  bool get hasDisliked => throw _privateConstructorUsedError;

  /// The variable that checks if the current user has bookmarked the report.
  bool get hasBookmarked => throw _privateConstructorUsedError;

  /// The document reference path, only parsed
  /// when converted from Firestore.
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportCopyWith<Report> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCopyWith<$Res> {
  factory $ReportCopyWith(Report value, $Res Function(Report) then) =
      _$ReportCopyWithImpl<$Res, Report>;
  @useResult
  $Res call({
    ReportData reportData,
    bool hasLiked,
    bool hasDisliked,
    bool hasBookmarked,
    String? path,
  });

  $ReportDataCopyWith<$Res> get reportData;
}

/// @nodoc
class _$ReportCopyWithImpl<$Res, $Val extends Report>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportData = null,
    Object? hasLiked = null,
    Object? hasDisliked = null,
    Object? hasBookmarked = null,
    Object? path = freezed,
  }) {
    return _then(
      _value.copyWith(
            reportData: null == reportData
                ? _value.reportData
                : reportData // ignore: cast_nullable_to_non_nullable
                      as ReportData,
            hasLiked: null == hasLiked
                ? _value.hasLiked
                : hasLiked // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasDisliked: null == hasDisliked
                ? _value.hasDisliked
                : hasDisliked // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasBookmarked: null == hasBookmarked
                ? _value.hasBookmarked
                : hasBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReportDataCopyWith<$Res> get reportData {
    return $ReportDataCopyWith<$Res>(_value.reportData, (value) {
      return _then(_value.copyWith(reportData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReportImplCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$$ReportImplCopyWith(
    _$ReportImpl value,
    $Res Function(_$ReportImpl) then,
  ) = __$$ReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReportData reportData,
    bool hasLiked,
    bool hasDisliked,
    bool hasBookmarked,
    String? path,
  });

  @override
  $ReportDataCopyWith<$Res> get reportData;
}

/// @nodoc
class __$$ReportImplCopyWithImpl<$Res>
    extends _$ReportCopyWithImpl<$Res, _$ReportImpl>
    implements _$$ReportImplCopyWith<$Res> {
  __$$ReportImplCopyWithImpl(
    _$ReportImpl _value,
    $Res Function(_$ReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportData = null,
    Object? hasLiked = null,
    Object? hasDisliked = null,
    Object? hasBookmarked = null,
    Object? path = freezed,
  }) {
    return _then(
      _$ReportImpl(
        reportData: null == reportData
            ? _value.reportData
            : reportData // ignore: cast_nullable_to_non_nullable
                  as ReportData,
        hasLiked: null == hasLiked
            ? _value.hasLiked
            : hasLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasDisliked: null == hasDisliked
            ? _value.hasDisliked
            : hasDisliked // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasBookmarked: null == hasBookmarked
            ? _value.hasBookmarked
            : hasBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$ReportImpl extends _Report {
  const _$ReportImpl({
    required this.reportData,
    this.hasLiked = false,
    this.hasDisliked = false,
    this.hasBookmarked = false,
    this.path,
  }) : super._();

  factory _$ReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportImplFromJson(json);

  /// The report data model associated with this report.
  @override
  final ReportData reportData;

  /// The variable the checks if the current user has liked the report.
  @override
  @JsonKey()
  final bool hasLiked;

  /// The variable that checks if the current user has disliked the report.
  @override
  @JsonKey()
  final bool hasDisliked;

  /// The variable that checks if the current user has bookmarked the report.
  @override
  @JsonKey()
  final bool hasBookmarked;

  /// The document reference path, only parsed
  /// when converted from Firestore.
  @override
  final String? path;

  @override
  String toString() {
    return 'Report(reportData: $reportData, hasLiked: $hasLiked, hasDisliked: $hasDisliked, hasBookmarked: $hasBookmarked, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportImpl &&
            (identical(other.reportData, reportData) ||
                other.reportData == reportData) &&
            (identical(other.hasLiked, hasLiked) ||
                other.hasLiked == hasLiked) &&
            (identical(other.hasDisliked, hasDisliked) ||
                other.hasDisliked == hasDisliked) &&
            (identical(other.hasBookmarked, hasBookmarked) ||
                other.hasBookmarked == hasBookmarked) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    reportData,
    hasLiked,
    hasDisliked,
    hasBookmarked,
    path,
  );

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      __$$ReportImplCopyWithImpl<_$ReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportImplToJson(this);
  }
}

abstract class _Report extends Report {
  const factory _Report({
    required final ReportData reportData,
    final bool hasLiked,
    final bool hasDisliked,
    final bool hasBookmarked,
    final String? path,
  }) = _$ReportImpl;
  const _Report._() : super._();

  factory _Report.fromJson(Map<String, dynamic> json) = _$ReportImpl.fromJson;

  /// The report data model associated with this report.
  @override
  ReportData get reportData;

  /// The variable the checks if the current user has liked the report.
  @override
  bool get hasLiked;

  /// The variable that checks if the current user has disliked the report.
  @override
  bool get hasDisliked;

  /// The variable that checks if the current user has bookmarked the report.
  @override
  bool get hasBookmarked;

  /// The document reference path, only parsed
  /// when converted from Firestore.
  @override
  String? get path;

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
