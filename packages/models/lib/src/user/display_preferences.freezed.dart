// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'display_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DisplayPreferences {

/// The user's preferred language.
/// Example: "en", "es"
 String get language;/// The user's preferred theme mode.
/// Example: "system - 0", "light - 1", "dark - 2", etc.
 int get themeModeIndex;
/// Create a copy of DisplayPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisplayPreferencesCopyWith<DisplayPreferences> get copyWith => _$DisplayPreferencesCopyWithImpl<DisplayPreferences>(this as DisplayPreferences, _$identity);

  /// Serializes this DisplayPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisplayPreferences&&(identical(other.language, language) || other.language == language)&&(identical(other.themeModeIndex, themeModeIndex) || other.themeModeIndex == themeModeIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,themeModeIndex);

@override
String toString() {
  return 'DisplayPreferences(language: $language, themeModeIndex: $themeModeIndex)';
}


}

/// @nodoc
abstract mixin class $DisplayPreferencesCopyWith<$Res>  {
  factory $DisplayPreferencesCopyWith(DisplayPreferences value, $Res Function(DisplayPreferences) _then) = _$DisplayPreferencesCopyWithImpl;
@useResult
$Res call({
 String language, int themeModeIndex
});




}
/// @nodoc
class _$DisplayPreferencesCopyWithImpl<$Res>
    implements $DisplayPreferencesCopyWith<$Res> {
  _$DisplayPreferencesCopyWithImpl(this._self, this._then);

  final DisplayPreferences _self;
  final $Res Function(DisplayPreferences) _then;

/// Create a copy of DisplayPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? themeModeIndex = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,themeModeIndex: null == themeModeIndex ? _self.themeModeIndex : themeModeIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DisplayPreferences].
extension DisplayPreferencesPatterns on DisplayPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisplayPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisplayPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisplayPreferences value)  $default,){
final _that = this;
switch (_that) {
case _DisplayPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisplayPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _DisplayPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  int themeModeIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisplayPreferences() when $default != null:
return $default(_that.language,_that.themeModeIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  int themeModeIndex)  $default,) {final _that = this;
switch (_that) {
case _DisplayPreferences():
return $default(_that.language,_that.themeModeIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  int themeModeIndex)?  $default,) {final _that = this;
switch (_that) {
case _DisplayPreferences() when $default != null:
return $default(_that.language,_that.themeModeIndex);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _DisplayPreferences extends DisplayPreferences {
  const _DisplayPreferences({this.language = 'en', this.themeModeIndex = 0}): super._();
  factory _DisplayPreferences.fromJson(Map<String, dynamic> json) => _$DisplayPreferencesFromJson(json);

/// The user's preferred language.
/// Example: "en", "es"
@override@JsonKey() final  String language;
/// The user's preferred theme mode.
/// Example: "system - 0", "light - 1", "dark - 2", etc.
@override@JsonKey() final  int themeModeIndex;

/// Create a copy of DisplayPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisplayPreferencesCopyWith<_DisplayPreferences> get copyWith => __$DisplayPreferencesCopyWithImpl<_DisplayPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisplayPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisplayPreferences&&(identical(other.language, language) || other.language == language)&&(identical(other.themeModeIndex, themeModeIndex) || other.themeModeIndex == themeModeIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,themeModeIndex);

@override
String toString() {
  return 'DisplayPreferences(language: $language, themeModeIndex: $themeModeIndex)';
}


}

/// @nodoc
abstract mixin class _$DisplayPreferencesCopyWith<$Res> implements $DisplayPreferencesCopyWith<$Res> {
  factory _$DisplayPreferencesCopyWith(_DisplayPreferences value, $Res Function(_DisplayPreferences) _then) = __$DisplayPreferencesCopyWithImpl;
@override @useResult
$Res call({
 String language, int themeModeIndex
});




}
/// @nodoc
class __$DisplayPreferencesCopyWithImpl<$Res>
    implements _$DisplayPreferencesCopyWith<$Res> {
  __$DisplayPreferencesCopyWithImpl(this._self, this._then);

  final _DisplayPreferences _self;
  final $Res Function(_DisplayPreferences) _then;

/// Create a copy of DisplayPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? themeModeIndex = null,}) {
  return _then(_DisplayPreferences(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,themeModeIndex: null == themeModeIndex ? _self.themeModeIndex : themeModeIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
