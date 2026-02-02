// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportData {

/// Unique identifier for the report.
 String get reportId;/// FirstName of the user who created the report.
 String get firstName;/// LastName of the user who created the report.
 String get lastName;/// Country where the report was created.
 String get country;/// State where the report was created.
 String get state;/// The content of the report.
 String get content;/// Number of likes the report has received (aggregate).
 int get likeCount;/// Number of dislikes on the report (aggregate).
 int get dislikeCount;/// Number of comments on the report (aggregate).
 int get commentCount;/// Number of bookmarks for the report (aggregate).
 int get bookmarkCount;/// The date when the report was created.
@TimestampConverter() DateTime get createdAt;/// The date when the report was last updated.
@TimestampConverter() DateTime get updatedAt;/// The URL of the images or videos associated with the report.
 List<String>? get media;/// The id of the user who created the report.
 String? get userId;/// The image URL of the user who created the report.
 String? get userImageUrl;/// The user’s preferred category types.
/// Example: [CategoryType.waste, CategoryType.road].
 List<CategoryType> get categoryTypes;/// The document reference path, only parsed
/// when converted from Firestore.
 String? get path;
/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDataCopyWith<ReportData> get copyWith => _$ReportDataCopyWithImpl<ReportData>(this as ReportData, _$identity);

  /// Serializes this ReportData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportData&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.content, content) || other.content == content)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.dislikeCount, dislikeCount) || other.dislikeCount == dislikeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.bookmarkCount, bookmarkCount) || other.bookmarkCount == bookmarkCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userImageUrl, userImageUrl) || other.userImageUrl == userImageUrl)&&const DeepCollectionEquality().equals(other.categoryTypes, categoryTypes)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportId,firstName,lastName,country,state,content,likeCount,dislikeCount,commentCount,bookmarkCount,createdAt,updatedAt,const DeepCollectionEquality().hash(media),userId,userImageUrl,const DeepCollectionEquality().hash(categoryTypes),path);

@override
String toString() {
  return 'ReportData(reportId: $reportId, firstName: $firstName, lastName: $lastName, country: $country, state: $state, content: $content, likeCount: $likeCount, dislikeCount: $dislikeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, createdAt: $createdAt, updatedAt: $updatedAt, media: $media, userId: $userId, userImageUrl: $userImageUrl, categoryTypes: $categoryTypes, path: $path)';
}


}

/// @nodoc
abstract mixin class $ReportDataCopyWith<$Res>  {
  factory $ReportDataCopyWith(ReportData value, $Res Function(ReportData) _then) = _$ReportDataCopyWithImpl;
@useResult
$Res call({
 String reportId, String firstName, String lastName, String country, String state, String content, int likeCount, int dislikeCount, int commentCount, int bookmarkCount,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, List<String>? media, String? userId, String? userImageUrl, List<CategoryType> categoryTypes, String? path
});




}
/// @nodoc
class _$ReportDataCopyWithImpl<$Res>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._self, this._then);

  final ReportData _self;
  final $Res Function(ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportId = null,Object? firstName = null,Object? lastName = null,Object? country = null,Object? state = null,Object? content = null,Object? likeCount = null,Object? dislikeCount = null,Object? commentCount = null,Object? bookmarkCount = null,Object? createdAt = null,Object? updatedAt = null,Object? media = freezed,Object? userId = freezed,Object? userImageUrl = freezed,Object? categoryTypes = null,Object? path = freezed,}) {
  return _then(_self.copyWith(
reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,dislikeCount: null == dislikeCount ? _self.dislikeCount : dislikeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,bookmarkCount: null == bookmarkCount ? _self.bookmarkCount : bookmarkCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<String>?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userImageUrl: freezed == userImageUrl ? _self.userImageUrl : userImageUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryTypes: null == categoryTypes ? _self.categoryTypes : categoryTypes // ignore: cast_nullable_to_non_nullable
as List<CategoryType>,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportData].
extension ReportDataPatterns on ReportData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportData value)  $default,){
final _that = this;
switch (_that) {
case _ReportData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportData value)?  $default,){
final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reportId,  String firstName,  String lastName,  String country,  String state,  String content,  int likeCount,  int dislikeCount,  int commentCount,  int bookmarkCount, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  List<String>? media,  String? userId,  String? userImageUrl,  List<CategoryType> categoryTypes,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.reportId,_that.firstName,_that.lastName,_that.country,_that.state,_that.content,_that.likeCount,_that.dislikeCount,_that.commentCount,_that.bookmarkCount,_that.createdAt,_that.updatedAt,_that.media,_that.userId,_that.userImageUrl,_that.categoryTypes,_that.path);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reportId,  String firstName,  String lastName,  String country,  String state,  String content,  int likeCount,  int dislikeCount,  int commentCount,  int bookmarkCount, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  List<String>? media,  String? userId,  String? userImageUrl,  List<CategoryType> categoryTypes,  String? path)  $default,) {final _that = this;
switch (_that) {
case _ReportData():
return $default(_that.reportId,_that.firstName,_that.lastName,_that.country,_that.state,_that.content,_that.likeCount,_that.dislikeCount,_that.commentCount,_that.bookmarkCount,_that.createdAt,_that.updatedAt,_that.media,_that.userId,_that.userImageUrl,_that.categoryTypes,_that.path);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reportId,  String firstName,  String lastName,  String country,  String state,  String content,  int likeCount,  int dislikeCount,  int commentCount,  int bookmarkCount, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  List<String>? media,  String? userId,  String? userImageUrl,  List<CategoryType> categoryTypes,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.reportId,_that.firstName,_that.lastName,_that.country,_that.state,_that.content,_that.likeCount,_that.dislikeCount,_that.commentCount,_that.bookmarkCount,_that.createdAt,_that.updatedAt,_that.media,_that.userId,_that.userImageUrl,_that.categoryTypes,_that.path);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _ReportData extends ReportData {
  const _ReportData({required this.reportId, required this.firstName, required this.lastName, required this.country, required this.state, required this.content, required this.likeCount, required this.dislikeCount, required this.commentCount, required this.bookmarkCount, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, final  List<String>? media = const [], this.userId, this.userImageUrl, final  List<CategoryType> categoryTypes = const [], this.path}): _media = media,_categoryTypes = categoryTypes,super._();
  factory _ReportData.fromJson(Map<String, dynamic> json) => _$ReportDataFromJson(json);

/// Unique identifier for the report.
@override final  String reportId;
/// FirstName of the user who created the report.
@override final  String firstName;
/// LastName of the user who created the report.
@override final  String lastName;
/// Country where the report was created.
@override final  String country;
/// State where the report was created.
@override final  String state;
/// The content of the report.
@override final  String content;
/// Number of likes the report has received (aggregate).
@override final  int likeCount;
/// Number of dislikes on the report (aggregate).
@override final  int dislikeCount;
/// Number of comments on the report (aggregate).
@override final  int commentCount;
/// Number of bookmarks for the report (aggregate).
@override final  int bookmarkCount;
/// The date when the report was created.
@override@TimestampConverter() final  DateTime createdAt;
/// The date when the report was last updated.
@override@TimestampConverter() final  DateTime updatedAt;
/// The URL of the images or videos associated with the report.
 final  List<String>? _media;
/// The URL of the images or videos associated with the report.
@override@JsonKey() List<String>? get media {
  final value = _media;
  if (value == null) return null;
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// The id of the user who created the report.
@override final  String? userId;
/// The image URL of the user who created the report.
@override final  String? userImageUrl;
/// The user’s preferred category types.
/// Example: [CategoryType.waste, CategoryType.road].
 final  List<CategoryType> _categoryTypes;
/// The user’s preferred category types.
/// Example: [CategoryType.waste, CategoryType.road].
@override@JsonKey() List<CategoryType> get categoryTypes {
  if (_categoryTypes is EqualUnmodifiableListView) return _categoryTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryTypes);
}

/// The document reference path, only parsed
/// when converted from Firestore.
@override final  String? path;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDataCopyWith<_ReportData> get copyWith => __$ReportDataCopyWithImpl<_ReportData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportData&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.content, content) || other.content == content)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.dislikeCount, dislikeCount) || other.dislikeCount == dislikeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.bookmarkCount, bookmarkCount) || other.bookmarkCount == bookmarkCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userImageUrl, userImageUrl) || other.userImageUrl == userImageUrl)&&const DeepCollectionEquality().equals(other._categoryTypes, _categoryTypes)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportId,firstName,lastName,country,state,content,likeCount,dislikeCount,commentCount,bookmarkCount,createdAt,updatedAt,const DeepCollectionEquality().hash(_media),userId,userImageUrl,const DeepCollectionEquality().hash(_categoryTypes),path);

@override
String toString() {
  return 'ReportData(reportId: $reportId, firstName: $firstName, lastName: $lastName, country: $country, state: $state, content: $content, likeCount: $likeCount, dislikeCount: $dislikeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, createdAt: $createdAt, updatedAt: $updatedAt, media: $media, userId: $userId, userImageUrl: $userImageUrl, categoryTypes: $categoryTypes, path: $path)';
}


}

/// @nodoc
abstract mixin class _$ReportDataCopyWith<$Res> implements $ReportDataCopyWith<$Res> {
  factory _$ReportDataCopyWith(_ReportData value, $Res Function(_ReportData) _then) = __$ReportDataCopyWithImpl;
@override @useResult
$Res call({
 String reportId, String firstName, String lastName, String country, String state, String content, int likeCount, int dislikeCount, int commentCount, int bookmarkCount,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, List<String>? media, String? userId, String? userImageUrl, List<CategoryType> categoryTypes, String? path
});




}
/// @nodoc
class __$ReportDataCopyWithImpl<$Res>
    implements _$ReportDataCopyWith<$Res> {
  __$ReportDataCopyWithImpl(this._self, this._then);

  final _ReportData _self;
  final $Res Function(_ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportId = null,Object? firstName = null,Object? lastName = null,Object? country = null,Object? state = null,Object? content = null,Object? likeCount = null,Object? dislikeCount = null,Object? commentCount = null,Object? bookmarkCount = null,Object? createdAt = null,Object? updatedAt = null,Object? media = freezed,Object? userId = freezed,Object? userImageUrl = freezed,Object? categoryTypes = null,Object? path = freezed,}) {
  return _then(_ReportData(
reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,dislikeCount: null == dislikeCount ? _self.dislikeCount : dislikeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,bookmarkCount: null == bookmarkCount ? _self.bookmarkCount : bookmarkCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,media: freezed == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<String>?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userImageUrl: freezed == userImageUrl ? _self.userImageUrl : userImageUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryTypes: null == categoryTypes ? _self._categoryTypes : categoryTypes // ignore: cast_nullable_to_non_nullable
as List<CategoryType>,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Report {

/// The report data model associated with this report.
 ReportData get reportData;/// The variable the checks if the current user has liked the report.
 bool get hasLiked;/// The variable that checks if the current user has disliked the report.
 bool get hasDisliked;/// The variable that checks if the current user has bookmarked the report.
 bool get hasBookmarked;/// The document reference path, only parsed
/// when converted from Firestore.
 String? get path;
/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCopyWith<Report> get copyWith => _$ReportCopyWithImpl<Report>(this as Report, _$identity);

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Report&&(identical(other.reportData, reportData) || other.reportData == reportData)&&(identical(other.hasLiked, hasLiked) || other.hasLiked == hasLiked)&&(identical(other.hasDisliked, hasDisliked) || other.hasDisliked == hasDisliked)&&(identical(other.hasBookmarked, hasBookmarked) || other.hasBookmarked == hasBookmarked)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportData,hasLiked,hasDisliked,hasBookmarked,path);

@override
String toString() {
  return 'Report(reportData: $reportData, hasLiked: $hasLiked, hasDisliked: $hasDisliked, hasBookmarked: $hasBookmarked, path: $path)';
}


}

/// @nodoc
abstract mixin class $ReportCopyWith<$Res>  {
  factory $ReportCopyWith(Report value, $Res Function(Report) _then) = _$ReportCopyWithImpl;
@useResult
$Res call({
 ReportData reportData, bool hasLiked, bool hasDisliked, bool hasBookmarked, String? path
});


$ReportDataCopyWith<$Res> get reportData;

}
/// @nodoc
class _$ReportCopyWithImpl<$Res>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._self, this._then);

  final Report _self;
  final $Res Function(Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportData = null,Object? hasLiked = null,Object? hasDisliked = null,Object? hasBookmarked = null,Object? path = freezed,}) {
  return _then(_self.copyWith(
reportData: null == reportData ? _self.reportData : reportData // ignore: cast_nullable_to_non_nullable
as ReportData,hasLiked: null == hasLiked ? _self.hasLiked : hasLiked // ignore: cast_nullable_to_non_nullable
as bool,hasDisliked: null == hasDisliked ? _self.hasDisliked : hasDisliked // ignore: cast_nullable_to_non_nullable
as bool,hasBookmarked: null == hasBookmarked ? _self.hasBookmarked : hasBookmarked // ignore: cast_nullable_to_non_nullable
as bool,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportDataCopyWith<$Res> get reportData {
  
  return $ReportDataCopyWith<$Res>(_self.reportData, (value) {
    return _then(_self.copyWith(reportData: value));
  });
}
}


/// Adds pattern-matching-related methods to [Report].
extension ReportPatterns on Report {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Report value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Report value)  $default,){
final _that = this;
switch (_that) {
case _Report():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Report value)?  $default,){
final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportData reportData,  bool hasLiked,  bool hasDisliked,  bool hasBookmarked,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.reportData,_that.hasLiked,_that.hasDisliked,_that.hasBookmarked,_that.path);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportData reportData,  bool hasLiked,  bool hasDisliked,  bool hasBookmarked,  String? path)  $default,) {final _that = this;
switch (_that) {
case _Report():
return $default(_that.reportData,_that.hasLiked,_that.hasDisliked,_that.hasBookmarked,_that.path);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportData reportData,  bool hasLiked,  bool hasDisliked,  bool hasBookmarked,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.reportData,_that.hasLiked,_that.hasDisliked,_that.hasBookmarked,_that.path);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _Report extends Report {
  const _Report({required this.reportData, this.hasLiked = false, this.hasDisliked = false, this.hasBookmarked = false, this.path}): super._();
  factory _Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

/// The report data model associated with this report.
@override final  ReportData reportData;
/// The variable the checks if the current user has liked the report.
@override@JsonKey() final  bool hasLiked;
/// The variable that checks if the current user has disliked the report.
@override@JsonKey() final  bool hasDisliked;
/// The variable that checks if the current user has bookmarked the report.
@override@JsonKey() final  bool hasBookmarked;
/// The document reference path, only parsed
/// when converted from Firestore.
@override final  String? path;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCopyWith<_Report> get copyWith => __$ReportCopyWithImpl<_Report>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Report&&(identical(other.reportData, reportData) || other.reportData == reportData)&&(identical(other.hasLiked, hasLiked) || other.hasLiked == hasLiked)&&(identical(other.hasDisliked, hasDisliked) || other.hasDisliked == hasDisliked)&&(identical(other.hasBookmarked, hasBookmarked) || other.hasBookmarked == hasBookmarked)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportData,hasLiked,hasDisliked,hasBookmarked,path);

@override
String toString() {
  return 'Report(reportData: $reportData, hasLiked: $hasLiked, hasDisliked: $hasDisliked, hasBookmarked: $hasBookmarked, path: $path)';
}


}

/// @nodoc
abstract mixin class _$ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$ReportCopyWith(_Report value, $Res Function(_Report) _then) = __$ReportCopyWithImpl;
@override @useResult
$Res call({
 ReportData reportData, bool hasLiked, bool hasDisliked, bool hasBookmarked, String? path
});


@override $ReportDataCopyWith<$Res> get reportData;

}
/// @nodoc
class __$ReportCopyWithImpl<$Res>
    implements _$ReportCopyWith<$Res> {
  __$ReportCopyWithImpl(this._self, this._then);

  final _Report _self;
  final $Res Function(_Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportData = null,Object? hasLiked = null,Object? hasDisliked = null,Object? hasBookmarked = null,Object? path = freezed,}) {
  return _then(_Report(
reportData: null == reportData ? _self.reportData : reportData // ignore: cast_nullable_to_non_nullable
as ReportData,hasLiked: null == hasLiked ? _self.hasLiked : hasLiked // ignore: cast_nullable_to_non_nullable
as bool,hasDisliked: null == hasDisliked ? _self.hasDisliked : hasDisliked // ignore: cast_nullable_to_non_nullable
as bool,hasBookmarked: null == hasBookmarked ? _self.hasBookmarked : hasBookmarked // ignore: cast_nullable_to_non_nullable
as bool,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportDataCopyWith<$Res> get reportData {
  
  return $ReportDataCopyWith<$Res>(_self.reportData, (value) {
    return _then(_self.copyWith(reportData: value));
  });
}
}

// dart format on
