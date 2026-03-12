// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Interaction {

 bool get hasLiked; bool get hasDisliked; bool get hasBookmarked;@TimestampConverter() DateTime? get updatedAt;
/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InteractionCopyWith<Interaction> get copyWith => _$InteractionCopyWithImpl<Interaction>(this as Interaction, _$identity);

  /// Serializes this Interaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Interaction&&(identical(other.hasLiked, hasLiked) || other.hasLiked == hasLiked)&&(identical(other.hasDisliked, hasDisliked) || other.hasDisliked == hasDisliked)&&(identical(other.hasBookmarked, hasBookmarked) || other.hasBookmarked == hasBookmarked)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasLiked,hasDisliked,hasBookmarked,updatedAt);

@override
String toString() {
  return 'Interaction(hasLiked: $hasLiked, hasDisliked: $hasDisliked, hasBookmarked: $hasBookmarked, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $InteractionCopyWith<$Res>  {
  factory $InteractionCopyWith(Interaction value, $Res Function(Interaction) _then) = _$InteractionCopyWithImpl;
@useResult
$Res call({
 bool hasLiked, bool hasDisliked, bool hasBookmarked,@TimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$InteractionCopyWithImpl<$Res>
    implements $InteractionCopyWith<$Res> {
  _$InteractionCopyWithImpl(this._self, this._then);

  final Interaction _self;
  final $Res Function(Interaction) _then;

/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasLiked = null,Object? hasDisliked = null,Object? hasBookmarked = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
hasLiked: null == hasLiked ? _self.hasLiked : hasLiked // ignore: cast_nullable_to_non_nullable
as bool,hasDisliked: null == hasDisliked ? _self.hasDisliked : hasDisliked // ignore: cast_nullable_to_non_nullable
as bool,hasBookmarked: null == hasBookmarked ? _self.hasBookmarked : hasBookmarked // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Interaction].
extension InteractionPatterns on Interaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Interaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Interaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Interaction value)  $default,){
final _that = this;
switch (_that) {
case _Interaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Interaction value)?  $default,){
final _that = this;
switch (_that) {
case _Interaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasLiked,  bool hasDisliked,  bool hasBookmarked, @TimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Interaction() when $default != null:
return $default(_that.hasLiked,_that.hasDisliked,_that.hasBookmarked,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasLiked,  bool hasDisliked,  bool hasBookmarked, @TimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Interaction():
return $default(_that.hasLiked,_that.hasDisliked,_that.hasBookmarked,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasLiked,  bool hasDisliked,  bool hasBookmarked, @TimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Interaction() when $default != null:
return $default(_that.hasLiked,_that.hasDisliked,_that.hasBookmarked,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _Interaction implements Interaction {
  const _Interaction({this.hasLiked = false, this.hasDisliked = false, this.hasBookmarked = false, @TimestampConverter() this.updatedAt});
  factory _Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);

@override@JsonKey() final  bool hasLiked;
@override@JsonKey() final  bool hasDisliked;
@override@JsonKey() final  bool hasBookmarked;
@override@TimestampConverter() final  DateTime? updatedAt;

/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InteractionCopyWith<_Interaction> get copyWith => __$InteractionCopyWithImpl<_Interaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InteractionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Interaction&&(identical(other.hasLiked, hasLiked) || other.hasLiked == hasLiked)&&(identical(other.hasDisliked, hasDisliked) || other.hasDisliked == hasDisliked)&&(identical(other.hasBookmarked, hasBookmarked) || other.hasBookmarked == hasBookmarked)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasLiked,hasDisliked,hasBookmarked,updatedAt);

@override
String toString() {
  return 'Interaction(hasLiked: $hasLiked, hasDisliked: $hasDisliked, hasBookmarked: $hasBookmarked, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$InteractionCopyWith<$Res> implements $InteractionCopyWith<$Res> {
  factory _$InteractionCopyWith(_Interaction value, $Res Function(_Interaction) _then) = __$InteractionCopyWithImpl;
@override @useResult
$Res call({
 bool hasLiked, bool hasDisliked, bool hasBookmarked,@TimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$InteractionCopyWithImpl<$Res>
    implements _$InteractionCopyWith<$Res> {
  __$InteractionCopyWithImpl(this._self, this._then);

  final _Interaction _self;
  final $Res Function(_Interaction) _then;

/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasLiked = null,Object? hasDisliked = null,Object? hasBookmarked = null,Object? updatedAt = freezed,}) {
  return _then(_Interaction(
hasLiked: null == hasLiked ? _self.hasLiked : hasLiked // ignore: cast_nullable_to_non_nullable
as bool,hasDisliked: null == hasDisliked ? _self.hasDisliked : hasDisliked // ignore: cast_nullable_to_non_nullable
as bool,hasBookmarked: null == hasBookmarked ? _self.hasBookmarked : hasBookmarked // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
