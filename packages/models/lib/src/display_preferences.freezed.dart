// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'display_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DisplayPreferences _$DisplayPreferencesFromJson(Map<String, dynamic> json) {
  return _DisplayPreferences.fromJson(json);
}

/// @nodoc
mixin _$DisplayPreferences {
  /// The user's preferred language.
  /// Example: "en", "es"
  String get language => throw _privateConstructorUsedError;

  /// The user's preferred theme mode.
  /// Example: "system - 0", "light - 1", "dark - 2", etc.
  int get themeModeIndex => throw _privateConstructorUsedError;

  /// Serializes this DisplayPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DisplayPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DisplayPreferencesCopyWith<DisplayPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisplayPreferencesCopyWith<$Res> {
  factory $DisplayPreferencesCopyWith(
    DisplayPreferences value,
    $Res Function(DisplayPreferences) then,
  ) = _$DisplayPreferencesCopyWithImpl<$Res, DisplayPreferences>;
  @useResult
  $Res call({String language, int themeModeIndex});
}

/// @nodoc
class _$DisplayPreferencesCopyWithImpl<$Res, $Val extends DisplayPreferences>
    implements $DisplayPreferencesCopyWith<$Res> {
  _$DisplayPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DisplayPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? language = null, Object? themeModeIndex = null}) {
    return _then(
      _value.copyWith(
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            themeModeIndex: null == themeModeIndex
                ? _value.themeModeIndex
                : themeModeIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DisplayPreferencesImplCopyWith<$Res>
    implements $DisplayPreferencesCopyWith<$Res> {
  factory _$$DisplayPreferencesImplCopyWith(
    _$DisplayPreferencesImpl value,
    $Res Function(_$DisplayPreferencesImpl) then,
  ) = __$$DisplayPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String language, int themeModeIndex});
}

/// @nodoc
class __$$DisplayPreferencesImplCopyWithImpl<$Res>
    extends _$DisplayPreferencesCopyWithImpl<$Res, _$DisplayPreferencesImpl>
    implements _$$DisplayPreferencesImplCopyWith<$Res> {
  __$$DisplayPreferencesImplCopyWithImpl(
    _$DisplayPreferencesImpl _value,
    $Res Function(_$DisplayPreferencesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisplayPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? language = null, Object? themeModeIndex = null}) {
    return _then(
      _$DisplayPreferencesImpl(
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        themeModeIndex: null == themeModeIndex
            ? _value.themeModeIndex
            : themeModeIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable()
class _$DisplayPreferencesImpl extends _DisplayPreferences {
  const _$DisplayPreferencesImpl({
    this.language = 'en',
    this.themeModeIndex = 0,
  }) : super._();

  factory _$DisplayPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$DisplayPreferencesImplFromJson(json);

  /// The user's preferred language.
  /// Example: "en", "es"
  @override
  @JsonKey()
  final String language;

  /// The user's preferred theme mode.
  /// Example: "system - 0", "light - 1", "dark - 2", etc.
  @override
  @JsonKey()
  final int themeModeIndex;

  @override
  String toString() {
    return 'DisplayPreferences(language: $language, themeModeIndex: $themeModeIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisplayPreferencesImpl &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.themeModeIndex, themeModeIndex) ||
                other.themeModeIndex == themeModeIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, language, themeModeIndex);

  /// Create a copy of DisplayPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DisplayPreferencesImplCopyWith<_$DisplayPreferencesImpl> get copyWith =>
      __$$DisplayPreferencesImplCopyWithImpl<_$DisplayPreferencesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DisplayPreferencesImplToJson(this);
  }
}

abstract class _DisplayPreferences extends DisplayPreferences {
  const factory _DisplayPreferences({
    final String language,
    final int themeModeIndex,
  }) = _$DisplayPreferencesImpl;
  const _DisplayPreferences._() : super._();

  factory _DisplayPreferences.fromJson(Map<String, dynamic> json) =
      _$DisplayPreferencesImpl.fromJson;

  /// The user's preferred language.
  /// Example: "en", "es"
  @override
  String get language;

  /// The user's preferred theme mode.
  /// Example: "system - 0", "light - 1", "dark - 2", etc.
  @override
  int get themeModeIndex;

  /// Create a copy of DisplayPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DisplayPreferencesImplCopyWith<_$DisplayPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
