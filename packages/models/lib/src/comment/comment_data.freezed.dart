// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentData {

/// Unique identifier for the comment.
 String get commentId;/// Unique identifier for the report where the comment was created.
 String get reportId;/// FirstName of the User who created the comment.
 String get firstName;/// LastName of the User who created the comment.
 String get lastName;/// The comment on the created report.
 String get comment;/// Number of likes the comment has received.
 int get likeCount;/// The date when the comment was created.
@TimestampConverter() DateTime get createdAt;/// The date when the comment was last updated.
@TimestampConverter() DateTime get updatedAt;/// The id of the user who created the comment.
 String? get userId;/// The image URL of the user who created the comment.
 String? get userImageUrl;/// The document reference path, only be
/// parsed when converted from Firestore
 String? get path;
/// Create a copy of CommentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentDataCopyWith<CommentData> get copyWith => _$CommentDataCopyWithImpl<CommentData>(this as CommentData, _$identity);

  /// Serializes this CommentData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentData&&(identical(other.commentId, commentId) || other.commentId == commentId)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userImageUrl, userImageUrl) || other.userImageUrl == userImageUrl)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commentId,reportId,firstName,lastName,comment,likeCount,createdAt,updatedAt,userId,userImageUrl,path);

@override
String toString() {
  return 'CommentData(commentId: $commentId, reportId: $reportId, firstName: $firstName, lastName: $lastName, comment: $comment, likeCount: $likeCount, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, userImageUrl: $userImageUrl, path: $path)';
}


}

/// @nodoc
abstract mixin class $CommentDataCopyWith<$Res>  {
  factory $CommentDataCopyWith(CommentData value, $Res Function(CommentData) _then) = _$CommentDataCopyWithImpl;
@useResult
$Res call({
 String commentId, String reportId, String firstName, String lastName, String comment, int likeCount,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String? userId, String? userImageUrl, String? path
});




}
/// @nodoc
class _$CommentDataCopyWithImpl<$Res>
    implements $CommentDataCopyWith<$Res> {
  _$CommentDataCopyWithImpl(this._self, this._then);

  final CommentData _self;
  final $Res Function(CommentData) _then;

/// Create a copy of CommentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commentId = null,Object? reportId = null,Object? firstName = null,Object? lastName = null,Object? comment = null,Object? likeCount = null,Object? createdAt = null,Object? updatedAt = null,Object? userId = freezed,Object? userImageUrl = freezed,Object? path = freezed,}) {
  return _then(_self.copyWith(
commentId: null == commentId ? _self.commentId : commentId // ignore: cast_nullable_to_non_nullable
as String,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userImageUrl: freezed == userImageUrl ? _self.userImageUrl : userImageUrl // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentData].
extension CommentDataPatterns on CommentData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentData value)  $default,){
final _that = this;
switch (_that) {
case _CommentData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentData value)?  $default,){
final _that = this;
switch (_that) {
case _CommentData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String commentId,  String reportId,  String firstName,  String lastName,  String comment,  int likeCount, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String? userId,  String? userImageUrl,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentData() when $default != null:
return $default(_that.commentId,_that.reportId,_that.firstName,_that.lastName,_that.comment,_that.likeCount,_that.createdAt,_that.updatedAt,_that.userId,_that.userImageUrl,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String commentId,  String reportId,  String firstName,  String lastName,  String comment,  int likeCount, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String? userId,  String? userImageUrl,  String? path)  $default,) {final _that = this;
switch (_that) {
case _CommentData():
return $default(_that.commentId,_that.reportId,_that.firstName,_that.lastName,_that.comment,_that.likeCount,_that.createdAt,_that.updatedAt,_that.userId,_that.userImageUrl,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String commentId,  String reportId,  String firstName,  String lastName,  String comment,  int likeCount, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String? userId,  String? userImageUrl,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _CommentData() when $default != null:
return $default(_that.commentId,_that.reportId,_that.firstName,_that.lastName,_that.comment,_that.likeCount,_that.createdAt,_that.updatedAt,_that.userId,_that.userImageUrl,_that.path);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _CommentData extends CommentData {
  const _CommentData({required this.commentId, required this.reportId, required this.firstName, required this.lastName, required this.comment, required this.likeCount, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.userId, this.userImageUrl, this.path}): super._();
  factory _CommentData.fromJson(Map<String, dynamic> json) => _$CommentDataFromJson(json);

/// Unique identifier for the comment.
@override final  String commentId;
/// Unique identifier for the report where the comment was created.
@override final  String reportId;
/// FirstName of the User who created the comment.
@override final  String firstName;
/// LastName of the User who created the comment.
@override final  String lastName;
/// The comment on the created report.
@override final  String comment;
/// Number of likes the comment has received.
@override final  int likeCount;
/// The date when the comment was created.
@override@TimestampConverter() final  DateTime createdAt;
/// The date when the comment was last updated.
@override@TimestampConverter() final  DateTime updatedAt;
/// The id of the user who created the comment.
@override final  String? userId;
/// The image URL of the user who created the comment.
@override final  String? userImageUrl;
/// The document reference path, only be
/// parsed when converted from Firestore
@override final  String? path;

/// Create a copy of CommentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentDataCopyWith<_CommentData> get copyWith => __$CommentDataCopyWithImpl<_CommentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentData&&(identical(other.commentId, commentId) || other.commentId == commentId)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userImageUrl, userImageUrl) || other.userImageUrl == userImageUrl)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commentId,reportId,firstName,lastName,comment,likeCount,createdAt,updatedAt,userId,userImageUrl,path);

@override
String toString() {
  return 'CommentData(commentId: $commentId, reportId: $reportId, firstName: $firstName, lastName: $lastName, comment: $comment, likeCount: $likeCount, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, userImageUrl: $userImageUrl, path: $path)';
}


}

/// @nodoc
abstract mixin class _$CommentDataCopyWith<$Res> implements $CommentDataCopyWith<$Res> {
  factory _$CommentDataCopyWith(_CommentData value, $Res Function(_CommentData) _then) = __$CommentDataCopyWithImpl;
@override @useResult
$Res call({
 String commentId, String reportId, String firstName, String lastName, String comment, int likeCount,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String? userId, String? userImageUrl, String? path
});




}
/// @nodoc
class __$CommentDataCopyWithImpl<$Res>
    implements _$CommentDataCopyWith<$Res> {
  __$CommentDataCopyWithImpl(this._self, this._then);

  final _CommentData _self;
  final $Res Function(_CommentData) _then;

/// Create a copy of CommentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commentId = null,Object? reportId = null,Object? firstName = null,Object? lastName = null,Object? comment = null,Object? likeCount = null,Object? createdAt = null,Object? updatedAt = null,Object? userId = freezed,Object? userImageUrl = freezed,Object? path = freezed,}) {
  return _then(_CommentData(
commentId: null == commentId ? _self.commentId : commentId // ignore: cast_nullable_to_non_nullable
as String,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userImageUrl: freezed == userImageUrl ? _self.userImageUrl : userImageUrl // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
