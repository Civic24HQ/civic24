// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationData {

/// Unique identifier for the notification.
 String get notificationId;/// The title of the user notification.
 String get title;/// The description of the user notification.
 String get description;/// The date when the notification was created.
@TimestampConverter() DateTime get createdAt;/// The date when the notification was last updated.
@TimestampConverter() DateTime get updatedAt;/// The variable that checks if a notification has been seen by the user
 bool get hasBeenSeen;/// The id of the user who has the notification.
 String? get userId;/// The icon data string of the notification.
 String? get notificationIconData;/// The document reference path, only be
/// parsed when converted from Firestore
 String? get path;
/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDataCopyWith<NotificationData> get copyWith => _$NotificationDataCopyWithImpl<NotificationData>(this as NotificationData, _$identity);

  /// Serializes this NotificationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationData&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.hasBeenSeen, hasBeenSeen) || other.hasBeenSeen == hasBeenSeen)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.notificationIconData, notificationIconData) || other.notificationIconData == notificationIconData)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,title,description,createdAt,updatedAt,hasBeenSeen,userId,notificationIconData,path);

@override
String toString() {
  return 'NotificationData(notificationId: $notificationId, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, hasBeenSeen: $hasBeenSeen, userId: $userId, notificationIconData: $notificationIconData, path: $path)';
}


}

/// @nodoc
abstract mixin class $NotificationDataCopyWith<$Res>  {
  factory $NotificationDataCopyWith(NotificationData value, $Res Function(NotificationData) _then) = _$NotificationDataCopyWithImpl;
@useResult
$Res call({
 String notificationId, String title, String description,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, bool hasBeenSeen, String? userId, String? notificationIconData, String? path
});




}
/// @nodoc
class _$NotificationDataCopyWithImpl<$Res>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._self, this._then);

  final NotificationData _self;
  final $Res Function(NotificationData) _then;

/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? title = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? hasBeenSeen = null,Object? userId = freezed,Object? notificationIconData = freezed,Object? path = freezed,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hasBeenSeen: null == hasBeenSeen ? _self.hasBeenSeen : hasBeenSeen // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,notificationIconData: freezed == notificationIconData ? _self.notificationIconData : notificationIconData // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationData].
extension NotificationDataPatterns on NotificationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationData value)  $default,){
final _that = this;
switch (_that) {
case _NotificationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationData value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String notificationId,  String title,  String description, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  bool hasBeenSeen,  String? userId,  String? notificationIconData,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
return $default(_that.notificationId,_that.title,_that.description,_that.createdAt,_that.updatedAt,_that.hasBeenSeen,_that.userId,_that.notificationIconData,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String notificationId,  String title,  String description, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  bool hasBeenSeen,  String? userId,  String? notificationIconData,  String? path)  $default,) {final _that = this;
switch (_that) {
case _NotificationData():
return $default(_that.notificationId,_that.title,_that.description,_that.createdAt,_that.updatedAt,_that.hasBeenSeen,_that.userId,_that.notificationIconData,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String notificationId,  String title,  String description, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  bool hasBeenSeen,  String? userId,  String? notificationIconData,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _NotificationData() when $default != null:
return $default(_that.notificationId,_that.title,_that.description,_that.createdAt,_that.updatedAt,_that.hasBeenSeen,_that.userId,_that.notificationIconData,_that.path);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _NotificationData extends NotificationData {
  const _NotificationData({required this.notificationId, required this.title, required this.description, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.hasBeenSeen = false, this.userId, this.notificationIconData, this.path}): super._();
  factory _NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

/// Unique identifier for the notification.
@override final  String notificationId;
/// The title of the user notification.
@override final  String title;
/// The description of the user notification.
@override final  String description;
/// The date when the notification was created.
@override@TimestampConverter() final  DateTime createdAt;
/// The date when the notification was last updated.
@override@TimestampConverter() final  DateTime updatedAt;
/// The variable that checks if a notification has been seen by the user
@override@JsonKey() final  bool hasBeenSeen;
/// The id of the user who has the notification.
@override final  String? userId;
/// The icon data string of the notification.
@override final  String? notificationIconData;
/// The document reference path, only be
/// parsed when converted from Firestore
@override final  String? path;

/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDataCopyWith<_NotificationData> get copyWith => __$NotificationDataCopyWithImpl<_NotificationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationData&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.hasBeenSeen, hasBeenSeen) || other.hasBeenSeen == hasBeenSeen)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.notificationIconData, notificationIconData) || other.notificationIconData == notificationIconData)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,title,description,createdAt,updatedAt,hasBeenSeen,userId,notificationIconData,path);

@override
String toString() {
  return 'NotificationData(notificationId: $notificationId, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, hasBeenSeen: $hasBeenSeen, userId: $userId, notificationIconData: $notificationIconData, path: $path)';
}


}

/// @nodoc
abstract mixin class _$NotificationDataCopyWith<$Res> implements $NotificationDataCopyWith<$Res> {
  factory _$NotificationDataCopyWith(_NotificationData value, $Res Function(_NotificationData) _then) = __$NotificationDataCopyWithImpl;
@override @useResult
$Res call({
 String notificationId, String title, String description,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, bool hasBeenSeen, String? userId, String? notificationIconData, String? path
});




}
/// @nodoc
class __$NotificationDataCopyWithImpl<$Res>
    implements _$NotificationDataCopyWith<$Res> {
  __$NotificationDataCopyWithImpl(this._self, this._then);

  final _NotificationData _self;
  final $Res Function(_NotificationData) _then;

/// Create a copy of NotificationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? title = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? hasBeenSeen = null,Object? userId = freezed,Object? notificationIconData = freezed,Object? path = freezed,}) {
  return _then(_NotificationData(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hasBeenSeen: null == hasBeenSeen ? _self.hasBeenSeen : hasBeenSeen // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,notificationIconData: freezed == notificationIconData ? _self.notificationIconData : notificationIconData // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
