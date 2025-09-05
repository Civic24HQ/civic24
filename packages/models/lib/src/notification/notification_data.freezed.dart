// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return _NotificationData.fromJson(json);
}

/// @nodoc
mixin _$NotificationData {
  /// Unique identifier for the notification.
  String get notificationId => throw _privateConstructorUsedError;

  /// The title of the user notification.
  String get title => throw _privateConstructorUsedError;

  /// The description of the user notification.
  String get description => throw _privateConstructorUsedError;

  /// The date when the notification was created.
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The date when the notification was last updated.
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// The variable that checks if a notification has been seen by the user
  bool get hasBeenSeen => throw _privateConstructorUsedError;

  /// The id of the user who has the notification.
  String? get userId => throw _privateConstructorUsedError;

  /// The icon data string of the notification.
  String? get notificationIconData => throw _privateConstructorUsedError;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this NotificationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationDataCopyWith<NotificationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDataCopyWith<$Res> {
  factory $NotificationDataCopyWith(
    NotificationData value,
    $Res Function(NotificationData) then,
  ) = _$NotificationDataCopyWithImpl<$Res, NotificationData>;
  @useResult
  $Res call({
    String notificationId,
    String title,
    String description,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    bool hasBeenSeen,
    String? userId,
    String? notificationIconData,
    String? path,
  });
}

/// @nodoc
class _$NotificationDataCopyWithImpl<$Res, $Val extends NotificationData>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? title = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasBeenSeen = null,
    Object? userId = freezed,
    Object? notificationIconData = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _value.copyWith(
            notificationId: null == notificationId
                ? _value.notificationId
                : notificationId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            hasBeenSeen: null == hasBeenSeen
                ? _value.hasBeenSeen
                : hasBeenSeen // ignore: cast_nullable_to_non_nullable
                      as bool,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            notificationIconData: freezed == notificationIconData
                ? _value.notificationIconData
                : notificationIconData // ignore: cast_nullable_to_non_nullable
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
abstract class _$$NotificationDataImplCopyWith<$Res>
    implements $NotificationDataCopyWith<$Res> {
  factory _$$NotificationDataImplCopyWith(
    _$NotificationDataImpl value,
    $Res Function(_$NotificationDataImpl) then,
  ) = __$$NotificationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String notificationId,
    String title,
    String description,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    bool hasBeenSeen,
    String? userId,
    String? notificationIconData,
    String? path,
  });
}

/// @nodoc
class __$$NotificationDataImplCopyWithImpl<$Res>
    extends _$NotificationDataCopyWithImpl<$Res, _$NotificationDataImpl>
    implements _$$NotificationDataImplCopyWith<$Res> {
  __$$NotificationDataImplCopyWithImpl(
    _$NotificationDataImpl _value,
    $Res Function(_$NotificationDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? title = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasBeenSeen = null,
    Object? userId = freezed,
    Object? notificationIconData = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _$NotificationDataImpl(
        notificationId: null == notificationId
            ? _value.notificationId
            : notificationId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        hasBeenSeen: null == hasBeenSeen
            ? _value.hasBeenSeen
            : hasBeenSeen // ignore: cast_nullable_to_non_nullable
                  as bool,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        notificationIconData: freezed == notificationIconData
            ? _value.notificationIconData
            : notificationIconData // ignore: cast_nullable_to_non_nullable
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
class _$NotificationDataImpl extends _NotificationData {
  const _$NotificationDataImpl({
    required this.notificationId,
    required this.title,
    required this.description,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
    this.hasBeenSeen = false,
    this.userId,
    this.notificationIconData,
    this.path,
  }) : super._();

  factory _$NotificationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDataImplFromJson(json);

  /// Unique identifier for the notification.
  @override
  final String notificationId;

  /// The title of the user notification.
  @override
  final String title;

  /// The description of the user notification.
  @override
  final String description;

  /// The date when the notification was created.
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// The date when the notification was last updated.
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  /// The variable that checks if a notification has been seen by the user
  @override
  @JsonKey()
  final bool hasBeenSeen;

  /// The id of the user who has the notification.
  @override
  final String? userId;

  /// The icon data string of the notification.
  @override
  final String? notificationIconData;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  final String? path;

  @override
  String toString() {
    return 'NotificationData(notificationId: $notificationId, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, hasBeenSeen: $hasBeenSeen, userId: $userId, notificationIconData: $notificationIconData, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataImpl &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.hasBeenSeen, hasBeenSeen) ||
                other.hasBeenSeen == hasBeenSeen) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.notificationIconData, notificationIconData) ||
                other.notificationIconData == notificationIconData) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    notificationId,
    title,
    description,
    createdAt,
    updatedAt,
    hasBeenSeen,
    userId,
    notificationIconData,
    path,
  );

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      __$$NotificationDataImplCopyWithImpl<_$NotificationDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDataImplToJson(this);
  }
}

abstract class _NotificationData extends NotificationData {
  const factory _NotificationData({
    required final String notificationId,
    required final String title,
    required final String description,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
    final bool hasBeenSeen,
    final String? userId,
    final String? notificationIconData,
    final String? path,
  }) = _$NotificationDataImpl;
  const _NotificationData._() : super._();

  factory _NotificationData.fromJson(Map<String, dynamic> json) =
      _$NotificationDataImpl.fromJson;

  /// Unique identifier for the notification.
  @override
  String get notificationId;

  /// The title of the user notification.
  @override
  String get title;

  /// The description of the user notification.
  @override
  String get description;

  /// The date when the notification was created.
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// The date when the notification was last updated.
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// The variable that checks if a notification has been seen by the user
  @override
  bool get hasBeenSeen;

  /// The id of the user who has the notification.
  @override
  String? get userId;

  /// The icon data string of the notification.
  @override
  String? get notificationIconData;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  String? get path;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
