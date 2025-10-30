// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  /// The user's unique id.
  String get id => throw _privateConstructorUsedError;

  /// The provider used to authenticate the user.
  /// Example: "google" or "apple" or "email".
  String get provider => throw _privateConstructorUsedError;

  /// The user's email address.
  String get email => throw _privateConstructorUsedError;

  /// The user's account details.
  UserAccount get account => throw _privateConstructorUsedError;

  /// A map containing keys as device models and values
  /// as the last time the user used the device.
  Map<String, UserDeviceModel> get devices =>
      throw _privateConstructorUsedError;

  /// A map containing keys as device models prefixed
  /// with "android" or "ios" and separated by "." then
  /// the following is the device model.
  ///
  /// And the values of each key will be the corresponding
  /// FCM token of the user's device.
  Map<String, dynamic> get fcmTokens => throw _privateConstructorUsedError;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String id,
    String provider,
    String email,
    UserAccount account,
    Map<String, UserDeviceModel> devices,
    Map<String, dynamic> fcmTokens,
    String? path,
  });

  $UserAccountCopyWith<$Res> get account;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? provider = null,
    Object? email = null,
    Object? account = null,
    Object? devices = null,
    Object? fcmTokens = null,
    Object? path = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            account: null == account
                ? _value.account
                : account // ignore: cast_nullable_to_non_nullable
                      as UserAccount,
            devices: null == devices
                ? _value.devices
                : devices // ignore: cast_nullable_to_non_nullable
                      as Map<String, UserDeviceModel>,
            fcmTokens: null == fcmTokens
                ? _value.fcmTokens
                : fcmTokens // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserAccountCopyWith<$Res> get account {
    return $UserAccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String provider,
    String email,
    UserAccount account,
    Map<String, UserDeviceModel> devices,
    Map<String, dynamic> fcmTokens,
    String? path,
  });

  @override
  $UserAccountCopyWith<$Res> get account;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? provider = null,
    Object? email = null,
    Object? account = null,
    Object? devices = null,
    Object? fcmTokens = null,
    Object? path = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        account: null == account
            ? _value.account
            : account // ignore: cast_nullable_to_non_nullable
                  as UserAccount,
        devices: null == devices
            ? _value._devices
            : devices // ignore: cast_nullable_to_non_nullable
                  as Map<String, UserDeviceModel>,
        fcmTokens: null == fcmTokens
            ? _value._fcmTokens
            : fcmTokens // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
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
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.provider,
    required this.email,
    required this.account,
    required final Map<String, UserDeviceModel> devices,
    final Map<String, dynamic> fcmTokens = const {},
    this.path,
  }) : _devices = devices,
       _fcmTokens = fcmTokens,
       super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  /// The user's unique id.
  @override
  final String id;

  /// The provider used to authenticate the user.
  /// Example: "google" or "apple" or "email".
  @override
  final String provider;

  /// The user's email address.
  @override
  final String email;

  /// The user's account details.
  @override
  final UserAccount account;

  /// A map containing keys as device models and values
  /// as the last time the user used the device.
  final Map<String, UserDeviceModel> _devices;

  /// A map containing keys as device models and values
  /// as the last time the user used the device.
  @override
  Map<String, UserDeviceModel> get devices {
    if (_devices is EqualUnmodifiableMapView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_devices);
  }

  /// A map containing keys as device models prefixed
  /// with "android" or "ios" and separated by "." then
  /// the following is the device model.
  ///
  /// And the values of each key will be the corresponding
  /// FCM token of the user's device.
  final Map<String, dynamic> _fcmTokens;

  /// A map containing keys as device models prefixed
  /// with "android" or "ios" and separated by "." then
  /// the following is the device model.
  ///
  /// And the values of each key will be the corresponding
  /// FCM token of the user's device.
  @override
  @JsonKey()
  Map<String, dynamic> get fcmTokens {
    if (_fcmTokens is EqualUnmodifiableMapView) return _fcmTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fcmTokens);
  }

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  final String? path;

  @override
  String toString() {
    return 'UserModel(id: $id, provider: $provider, email: $email, account: $account, devices: $devices, fcmTokens: $fcmTokens, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.account, account) || other.account == account) &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            const DeepCollectionEquality().equals(
              other._fcmTokens,
              _fcmTokens,
            ) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    provider,
    email,
    account,
    const DeepCollectionEquality().hash(_devices),
    const DeepCollectionEquality().hash(_fcmTokens),
    path,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel({
    required final String id,
    required final String provider,
    required final String email,
    required final UserAccount account,
    required final Map<String, UserDeviceModel> devices,
    final Map<String, dynamic> fcmTokens,
    final String? path,
  }) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  /// The user's unique id.
  @override
  String get id;

  /// The provider used to authenticate the user.
  /// Example: "google" or "apple" or "email".
  @override
  String get provider;

  /// The user's email address.
  @override
  String get email;

  /// The user's account details.
  @override
  UserAccount get account;

  /// A map containing keys as device models and values
  /// as the last time the user used the device.
  @override
  Map<String, UserDeviceModel> get devices;

  /// A map containing keys as device models prefixed
  /// with "android" or "ios" and separated by "." then
  /// the following is the device model.
  ///
  /// And the values of each key will be the corresponding
  /// FCM token of the user's device.
  @override
  Map<String, dynamic> get fcmTokens;

  /// The document reference path, only be
  /// parsed when converted from Firestore
  @override
  String? get path;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) {
  return _UserAccount.fromJson(json);
}

/// @nodoc
mixin _$UserAccount {
  /// The user's first name.
  String get firstName => throw _privateConstructorUsedError;

  /// The user's last name.
  String get lastName => throw _privateConstructorUsedError;

  /// The user's email address.
  String get email => throw _privateConstructorUsedError;

  /// The user's country of residence.
  /// Example: "Nigeria", "United States", etc.
  String get country => throw _privateConstructorUsedError;

  /// The user's state of residence.
  /// Example: "Lagos", "California", etc.
  String get state => throw _privateConstructorUsedError;

  /// The user's city of residence.
  /// Example: "Ikeja", "Los Angeles", etc.
  String get city => throw _privateConstructorUsedError;

  /// The user's address.
  /// Example: "123, Fake Street, Lagos"
  String get address => throw _privateConstructorUsedError;

  /// The user's postal code.
  /// Example: "100001"
  String get postalCode => throw _privateConstructorUsedError;

  /// Registration date of the user
  @TimestampConverter()
  DateTime get registrationDate => throw _privateConstructorUsedError;

  /// The user's account type.
  UserType get userType => throw _privateConstructorUsedError;

  /// The user's phone number.
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// The user's profile picture.
  String? get profilePicture => throw _privateConstructorUsedError;

  /// The user's gender.
  String? get gender => throw _privateConstructorUsedError;

  /// Date of birth of the user
  @TimestampNullableConverter()
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;

  /// A check to see if the user has completed onboarding.
  bool get hasCompletedOnboarding => throw _privateConstructorUsedError;

  /// If the value of this variable is true, we will navigate
  /// user to authentication screen.
  bool get mustAuthenticate => throw _privateConstructorUsedError;

  /// The date of account deletion
  @TimestampNullableConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// The status of account deletion
  /// (true if the account is deleted, false otherwise)
  bool get isDeleted => throw _privateConstructorUsedError;

  /// The reason for account deletion
  String get deleteReason => throw _privateConstructorUsedError;

  /// For soft delete purpose or emergency
  bool get isDisabled => throw _privateConstructorUsedError;

  /// For soft delete purpose or emergency
  @TimestampNullableConverter()
  DateTime? get disabledAt => throw _privateConstructorUsedError;

  /// The reason for account disable
  /// Example: "suspicious activity", "violating terms", etc.
  String get disableReason => throw _privateConstructorUsedError;

  /// The date the account was last updated
  /// (this includes profile update, password change, etc.)
  @TimestampNullableConverter()
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this UserAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAccountCopyWith<UserAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAccountCopyWith<$Res> {
  factory $UserAccountCopyWith(
    UserAccount value,
    $Res Function(UserAccount) then,
  ) = _$UserAccountCopyWithImpl<$Res, UserAccount>;
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String country,
    String state,
    String city,
    String address,
    String postalCode,
    @TimestampConverter() DateTime registrationDate,
    UserType userType,
    String? phoneNumber,
    String? profilePicture,
    String? gender,
    @TimestampNullableConverter() DateTime? dateOfBirth,
    bool hasCompletedOnboarding,
    bool mustAuthenticate,
    @TimestampNullableConverter() DateTime? deletedAt,
    bool isDeleted,
    String deleteReason,
    bool isDisabled,
    @TimestampNullableConverter() DateTime? disabledAt,
    String disableReason,
    @TimestampNullableConverter() DateTime? lastUpdated,
  });
}

/// @nodoc
class _$UserAccountCopyWithImpl<$Res, $Val extends UserAccount>
    implements $UserAccountCopyWith<$Res> {
  _$UserAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? country = null,
    Object? state = null,
    Object? city = null,
    Object? address = null,
    Object? postalCode = null,
    Object? registrationDate = null,
    Object? userType = null,
    Object? phoneNumber = freezed,
    Object? profilePicture = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? hasCompletedOnboarding = null,
    Object? mustAuthenticate = null,
    Object? deletedAt = freezed,
    Object? isDeleted = null,
    Object? deleteReason = null,
    Object? isDisabled = null,
    Object? disabledAt = freezed,
    Object? disableReason = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            postalCode: null == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                      as String,
            registrationDate: null == registrationDate
                ? _value.registrationDate
                : registrationDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userType: null == userType
                ? _value.userType
                : userType // ignore: cast_nullable_to_non_nullable
                      as UserType,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            profilePicture: freezed == profilePicture
                ? _value.profilePicture
                : profilePicture // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            hasCompletedOnboarding: null == hasCompletedOnboarding
                ? _value.hasCompletedOnboarding
                : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                      as bool,
            mustAuthenticate: null == mustAuthenticate
                ? _value.mustAuthenticate
                : mustAuthenticate // ignore: cast_nullable_to_non_nullable
                      as bool,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            deleteReason: null == deleteReason
                ? _value.deleteReason
                : deleteReason // ignore: cast_nullable_to_non_nullable
                      as String,
            isDisabled: null == isDisabled
                ? _value.isDisabled
                : isDisabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            disabledAt: freezed == disabledAt
                ? _value.disabledAt
                : disabledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            disableReason: null == disableReason
                ? _value.disableReason
                : disableReason // ignore: cast_nullable_to_non_nullable
                      as String,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAccountImplCopyWith<$Res>
    implements $UserAccountCopyWith<$Res> {
  factory _$$UserAccountImplCopyWith(
    _$UserAccountImpl value,
    $Res Function(_$UserAccountImpl) then,
  ) = __$$UserAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String country,
    String state,
    String city,
    String address,
    String postalCode,
    @TimestampConverter() DateTime registrationDate,
    UserType userType,
    String? phoneNumber,
    String? profilePicture,
    String? gender,
    @TimestampNullableConverter() DateTime? dateOfBirth,
    bool hasCompletedOnboarding,
    bool mustAuthenticate,
    @TimestampNullableConverter() DateTime? deletedAt,
    bool isDeleted,
    String deleteReason,
    bool isDisabled,
    @TimestampNullableConverter() DateTime? disabledAt,
    String disableReason,
    @TimestampNullableConverter() DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$UserAccountImplCopyWithImpl<$Res>
    extends _$UserAccountCopyWithImpl<$Res, _$UserAccountImpl>
    implements _$$UserAccountImplCopyWith<$Res> {
  __$$UserAccountImplCopyWithImpl(
    _$UserAccountImpl _value,
    $Res Function(_$UserAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? country = null,
    Object? state = null,
    Object? city = null,
    Object? address = null,
    Object? postalCode = null,
    Object? registrationDate = null,
    Object? userType = null,
    Object? phoneNumber = freezed,
    Object? profilePicture = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? hasCompletedOnboarding = null,
    Object? mustAuthenticate = null,
    Object? deletedAt = freezed,
    Object? isDeleted = null,
    Object? deleteReason = null,
    Object? isDisabled = null,
    Object? disabledAt = freezed,
    Object? disableReason = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$UserAccountImpl(
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        postalCode: null == postalCode
            ? _value.postalCode
            : postalCode // ignore: cast_nullable_to_non_nullable
                  as String,
        registrationDate: null == registrationDate
            ? _value.registrationDate
            : registrationDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userType: null == userType
            ? _value.userType
            : userType // ignore: cast_nullable_to_non_nullable
                  as UserType,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        profilePicture: freezed == profilePicture
            ? _value.profilePicture
            : profilePicture // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        hasCompletedOnboarding: null == hasCompletedOnboarding
            ? _value.hasCompletedOnboarding
            : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                  as bool,
        mustAuthenticate: null == mustAuthenticate
            ? _value.mustAuthenticate
            : mustAuthenticate // ignore: cast_nullable_to_non_nullable
                  as bool,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        deleteReason: null == deleteReason
            ? _value.deleteReason
            : deleteReason // ignore: cast_nullable_to_non_nullable
                  as String,
        isDisabled: null == isDisabled
            ? _value.isDisabled
            : isDisabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        disabledAt: freezed == disabledAt
            ? _value.disabledAt
            : disabledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        disableReason: null == disableReason
            ? _value.disableReason
            : disableReason // ignore: cast_nullable_to_non_nullable
                  as String,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable()
class _$UserAccountImpl extends _UserAccount {
  const _$UserAccountImpl({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.postalCode,
    @TimestampConverter() required this.registrationDate,
    this.userType = UserType.citizen,
    this.phoneNumber,
    this.profilePicture,
    this.gender,
    @TimestampNullableConverter() this.dateOfBirth,
    this.hasCompletedOnboarding = false,
    this.mustAuthenticate = false,
    @TimestampNullableConverter() this.deletedAt,
    this.isDeleted = false,
    this.deleteReason = '',
    this.isDisabled = false,
    @TimestampNullableConverter() this.disabledAt,
    this.disableReason = '',
    @TimestampNullableConverter() this.lastUpdated,
  }) : super._();

  factory _$UserAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAccountImplFromJson(json);

  /// The user's first name.
  @override
  final String firstName;

  /// The user's last name.
  @override
  final String lastName;

  /// The user's email address.
  @override
  final String email;

  /// The user's country of residence.
  /// Example: "Nigeria", "United States", etc.
  @override
  final String country;

  /// The user's state of residence.
  /// Example: "Lagos", "California", etc.
  @override
  final String state;

  /// The user's city of residence.
  /// Example: "Ikeja", "Los Angeles", etc.
  @override
  final String city;

  /// The user's address.
  /// Example: "123, Fake Street, Lagos"
  @override
  final String address;

  /// The user's postal code.
  /// Example: "100001"
  @override
  final String postalCode;

  /// Registration date of the user
  @override
  @TimestampConverter()
  final DateTime registrationDate;

  /// The user's account type.
  @override
  @JsonKey()
  final UserType userType;

  /// The user's phone number.
  @override
  final String? phoneNumber;

  /// The user's profile picture.
  @override
  final String? profilePicture;

  /// The user's gender.
  @override
  final String? gender;

  /// Date of birth of the user
  @override
  @TimestampNullableConverter()
  final DateTime? dateOfBirth;

  /// A check to see if the user has completed onboarding.
  @override
  @JsonKey()
  final bool hasCompletedOnboarding;

  /// If the value of this variable is true, we will navigate
  /// user to authentication screen.
  @override
  @JsonKey()
  final bool mustAuthenticate;

  /// The date of account deletion
  @override
  @TimestampNullableConverter()
  final DateTime? deletedAt;

  /// The status of account deletion
  /// (true if the account is deleted, false otherwise)
  @override
  @JsonKey()
  final bool isDeleted;

  /// The reason for account deletion
  @override
  @JsonKey()
  final String deleteReason;

  /// For soft delete purpose or emergency
  @override
  @JsonKey()
  final bool isDisabled;

  /// For soft delete purpose or emergency
  @override
  @TimestampNullableConverter()
  final DateTime? disabledAt;

  /// The reason for account disable
  /// Example: "suspicious activity", "violating terms", etc.
  @override
  @JsonKey()
  final String disableReason;

  /// The date the account was last updated
  /// (this includes profile update, password change, etc.)
  @override
  @TimestampNullableConverter()
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'UserAccount(firstName: $firstName, lastName: $lastName, email: $email, country: $country, state: $state, city: $city, address: $address, postalCode: $postalCode, registrationDate: $registrationDate, userType: $userType, phoneNumber: $phoneNumber, profilePicture: $profilePicture, gender: $gender, dateOfBirth: $dateOfBirth, hasCompletedOnboarding: $hasCompletedOnboarding, mustAuthenticate: $mustAuthenticate, deletedAt: $deletedAt, isDeleted: $isDeleted, deleteReason: $deleteReason, isDisabled: $isDisabled, disabledAt: $disabledAt, disableReason: $disableReason, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAccountImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.registrationDate, registrationDate) ||
                other.registrationDate == registrationDate) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding) &&
            (identical(other.mustAuthenticate, mustAuthenticate) ||
                other.mustAuthenticate == mustAuthenticate) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deleteReason, deleteReason) ||
                other.deleteReason == deleteReason) &&
            (identical(other.isDisabled, isDisabled) ||
                other.isDisabled == isDisabled) &&
            (identical(other.disabledAt, disabledAt) ||
                other.disabledAt == disabledAt) &&
            (identical(other.disableReason, disableReason) ||
                other.disableReason == disableReason) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    firstName,
    lastName,
    email,
    country,
    state,
    city,
    address,
    postalCode,
    registrationDate,
    userType,
    phoneNumber,
    profilePicture,
    gender,
    dateOfBirth,
    hasCompletedOnboarding,
    mustAuthenticate,
    deletedAt,
    isDeleted,
    deleteReason,
    isDisabled,
    disabledAt,
    disableReason,
    lastUpdated,
  ]);

  /// Create a copy of UserAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAccountImplCopyWith<_$UserAccountImpl> get copyWith =>
      __$$UserAccountImplCopyWithImpl<_$UserAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAccountImplToJson(this);
  }
}

abstract class _UserAccount extends UserAccount {
  const factory _UserAccount({
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String country,
    required final String state,
    required final String city,
    required final String address,
    required final String postalCode,
    @TimestampConverter() required final DateTime registrationDate,
    final UserType userType,
    final String? phoneNumber,
    final String? profilePicture,
    final String? gender,
    @TimestampNullableConverter() final DateTime? dateOfBirth,
    final bool hasCompletedOnboarding,
    final bool mustAuthenticate,
    @TimestampNullableConverter() final DateTime? deletedAt,
    final bool isDeleted,
    final String deleteReason,
    final bool isDisabled,
    @TimestampNullableConverter() final DateTime? disabledAt,
    final String disableReason,
    @TimestampNullableConverter() final DateTime? lastUpdated,
  }) = _$UserAccountImpl;
  const _UserAccount._() : super._();

  factory _UserAccount.fromJson(Map<String, dynamic> json) =
      _$UserAccountImpl.fromJson;

  /// The user's first name.
  @override
  String get firstName;

  /// The user's last name.
  @override
  String get lastName;

  /// The user's email address.
  @override
  String get email;

  /// The user's country of residence.
  /// Example: "Nigeria", "United States", etc.
  @override
  String get country;

  /// The user's state of residence.
  /// Example: "Lagos", "California", etc.
  @override
  String get state;

  /// The user's city of residence.
  /// Example: "Ikeja", "Los Angeles", etc.
  @override
  String get city;

  /// The user's address.
  /// Example: "123, Fake Street, Lagos"
  @override
  String get address;

  /// The user's postal code.
  /// Example: "100001"
  @override
  String get postalCode;

  /// Registration date of the user
  @override
  @TimestampConverter()
  DateTime get registrationDate;

  /// The user's account type.
  @override
  UserType get userType;

  /// The user's phone number.
  @override
  String? get phoneNumber;

  /// The user's profile picture.
  @override
  String? get profilePicture;

  /// The user's gender.
  @override
  String? get gender;

  /// Date of birth of the user
  @override
  @TimestampNullableConverter()
  DateTime? get dateOfBirth;

  /// A check to see if the user has completed onboarding.
  @override
  bool get hasCompletedOnboarding;

  /// If the value of this variable is true, we will navigate
  /// user to authentication screen.
  @override
  bool get mustAuthenticate;

  /// The date of account deletion
  @override
  @TimestampNullableConverter()
  DateTime? get deletedAt;

  /// The status of account deletion
  /// (true if the account is deleted, false otherwise)
  @override
  bool get isDeleted;

  /// The reason for account deletion
  @override
  String get deleteReason;

  /// For soft delete purpose or emergency
  @override
  bool get isDisabled;

  /// For soft delete purpose or emergency
  @override
  @TimestampNullableConverter()
  DateTime? get disabledAt;

  /// The reason for account disable
  /// Example: "suspicious activity", "violating terms", etc.
  @override
  String get disableReason;

  /// The date the account was last updated
  /// (this includes profile update, password change, etc.)
  @override
  @TimestampNullableConverter()
  DateTime? get lastUpdated;

  /// Create a copy of UserAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAccountImplCopyWith<_$UserAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserDeviceModel _$UserDeviceModelFromJson(Map<String, dynamic> json) {
  return _UserDeviceModel.fromJson(json);
}

/// @nodoc
mixin _$UserDeviceModel {
  /// The device model of the user.
  /// Example: "android_pixel_3a", "ios_iphone_12", etc.
  String get deviceModel => throw _privateConstructorUsedError;

  /// The time zone this device is being used.
  TimeZone get currentTimeZone => throw _privateConstructorUsedError;

  /// The last time the user used the device.
  @TimestampNullableConverter()
  DateTime? get lastUsed => throw _privateConstructorUsedError;

  /// Serializes this UserDeviceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserDeviceModelCopyWith<UserDeviceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDeviceModelCopyWith<$Res> {
  factory $UserDeviceModelCopyWith(
    UserDeviceModel value,
    $Res Function(UserDeviceModel) then,
  ) = _$UserDeviceModelCopyWithImpl<$Res, UserDeviceModel>;
  @useResult
  $Res call({
    String deviceModel,
    TimeZone currentTimeZone,
    @TimestampNullableConverter() DateTime? lastUsed,
  });

  $TimeZoneCopyWith<$Res> get currentTimeZone;
}

/// @nodoc
class _$UserDeviceModelCopyWithImpl<$Res, $Val extends UserDeviceModel>
    implements $UserDeviceModelCopyWith<$Res> {
  _$UserDeviceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceModel = null,
    Object? currentTimeZone = null,
    Object? lastUsed = freezed,
  }) {
    return _then(
      _value.copyWith(
            deviceModel: null == deviceModel
                ? _value.deviceModel
                : deviceModel // ignore: cast_nullable_to_non_nullable
                      as String,
            currentTimeZone: null == currentTimeZone
                ? _value.currentTimeZone
                : currentTimeZone // ignore: cast_nullable_to_non_nullable
                      as TimeZone,
            lastUsed: freezed == lastUsed
                ? _value.lastUsed
                : lastUsed // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeZoneCopyWith<$Res> get currentTimeZone {
    return $TimeZoneCopyWith<$Res>(_value.currentTimeZone, (value) {
      return _then(_value.copyWith(currentTimeZone: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserDeviceModelImplCopyWith<$Res>
    implements $UserDeviceModelCopyWith<$Res> {
  factory _$$UserDeviceModelImplCopyWith(
    _$UserDeviceModelImpl value,
    $Res Function(_$UserDeviceModelImpl) then,
  ) = __$$UserDeviceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String deviceModel,
    TimeZone currentTimeZone,
    @TimestampNullableConverter() DateTime? lastUsed,
  });

  @override
  $TimeZoneCopyWith<$Res> get currentTimeZone;
}

/// @nodoc
class __$$UserDeviceModelImplCopyWithImpl<$Res>
    extends _$UserDeviceModelCopyWithImpl<$Res, _$UserDeviceModelImpl>
    implements _$$UserDeviceModelImplCopyWith<$Res> {
  __$$UserDeviceModelImplCopyWithImpl(
    _$UserDeviceModelImpl _value,
    $Res Function(_$UserDeviceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceModel = null,
    Object? currentTimeZone = null,
    Object? lastUsed = freezed,
  }) {
    return _then(
      _$UserDeviceModelImpl(
        deviceModel: null == deviceModel
            ? _value.deviceModel
            : deviceModel // ignore: cast_nullable_to_non_nullable
                  as String,
        currentTimeZone: null == currentTimeZone
            ? _value.currentTimeZone
            : currentTimeZone // ignore: cast_nullable_to_non_nullable
                  as TimeZone,
        lastUsed: freezed == lastUsed
            ? _value.lastUsed
            : lastUsed // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable()
class _$UserDeviceModelImpl extends _UserDeviceModel {
  const _$UserDeviceModelImpl({
    required this.deviceModel,
    required this.currentTimeZone,
    @TimestampNullableConverter() this.lastUsed,
  }) : super._();

  factory _$UserDeviceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDeviceModelImplFromJson(json);

  /// The device model of the user.
  /// Example: "android_pixel_3a", "ios_iphone_12", etc.
  @override
  final String deviceModel;

  /// The time zone this device is being used.
  @override
  final TimeZone currentTimeZone;

  /// The last time the user used the device.
  @override
  @TimestampNullableConverter()
  final DateTime? lastUsed;

  @override
  String toString() {
    return 'UserDeviceModel(deviceModel: $deviceModel, currentTimeZone: $currentTimeZone, lastUsed: $lastUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDeviceModelImpl &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.currentTimeZone, currentTimeZone) ||
                other.currentTimeZone == currentTimeZone) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, deviceModel, currentTimeZone, lastUsed);

  /// Create a copy of UserDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDeviceModelImplCopyWith<_$UserDeviceModelImpl> get copyWith =>
      __$$UserDeviceModelImplCopyWithImpl<_$UserDeviceModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDeviceModelImplToJson(this);
  }
}

abstract class _UserDeviceModel extends UserDeviceModel {
  const factory _UserDeviceModel({
    required final String deviceModel,
    required final TimeZone currentTimeZone,
    @TimestampNullableConverter() final DateTime? lastUsed,
  }) = _$UserDeviceModelImpl;
  const _UserDeviceModel._() : super._();

  factory _UserDeviceModel.fromJson(Map<String, dynamic> json) =
      _$UserDeviceModelImpl.fromJson;

  /// The device model of the user.
  /// Example: "android_pixel_3a", "ios_iphone_12", etc.
  @override
  String get deviceModel;

  /// The time zone this device is being used.
  @override
  TimeZone get currentTimeZone;

  /// The last time the user used the device.
  @override
  @TimestampNullableConverter()
  DateTime? get lastUsed;

  /// Create a copy of UserDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDeviceModelImplCopyWith<_$UserDeviceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeZone _$TimeZoneFromJson(Map<String, dynamic> json) {
  return _TimeZone.fromJson(json);
}

/// @nodoc
mixin _$TimeZone {
  /// The name of the time zone. Example: "Europe/Berlin"
  String get name => throw _privateConstructorUsedError;

  /// The abbreviation of the time zone. Example: "CET"
  String get abbreviation => throw _privateConstructorUsedError;

  /// The offset in hours. Example: 1 or -5
  int get offset => throw _privateConstructorUsedError;

  /// The offset display. Example: "GMT+01:00"
  String get offsetDisplay => throw _privateConstructorUsedError;

  /// Serializes this TimeZone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeZoneCopyWith<TimeZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeZoneCopyWith<$Res> {
  factory $TimeZoneCopyWith(TimeZone value, $Res Function(TimeZone) then) =
      _$TimeZoneCopyWithImpl<$Res, TimeZone>;
  @useResult
  $Res call({
    String name,
    String abbreviation,
    int offset,
    String offsetDisplay,
  });
}

/// @nodoc
class _$TimeZoneCopyWithImpl<$Res, $Val extends TimeZone>
    implements $TimeZoneCopyWith<$Res> {
  _$TimeZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? abbreviation = null,
    Object? offset = null,
    Object? offsetDisplay = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            abbreviation: null == abbreviation
                ? _value.abbreviation
                : abbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
            offsetDisplay: null == offsetDisplay
                ? _value.offsetDisplay
                : offsetDisplay // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeZoneImplCopyWith<$Res>
    implements $TimeZoneCopyWith<$Res> {
  factory _$$TimeZoneImplCopyWith(
    _$TimeZoneImpl value,
    $Res Function(_$TimeZoneImpl) then,
  ) = __$$TimeZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String abbreviation,
    int offset,
    String offsetDisplay,
  });
}

/// @nodoc
class __$$TimeZoneImplCopyWithImpl<$Res>
    extends _$TimeZoneCopyWithImpl<$Res, _$TimeZoneImpl>
    implements _$$TimeZoneImplCopyWith<$Res> {
  __$$TimeZoneImplCopyWithImpl(
    _$TimeZoneImpl _value,
    $Res Function(_$TimeZoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeZone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? abbreviation = null,
    Object? offset = null,
    Object? offsetDisplay = null,
  }) {
    return _then(
      _$TimeZoneImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        abbreviation: null == abbreviation
            ? _value.abbreviation
            : abbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
        offsetDisplay: null == offsetDisplay
            ? _value.offsetDisplay
            : offsetDisplay // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable()
class _$TimeZoneImpl extends _TimeZone {
  const _$TimeZoneImpl({
    required this.name,
    required this.abbreviation,
    required this.offset,
    required this.offsetDisplay,
  }) : super._();

  factory _$TimeZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeZoneImplFromJson(json);

  /// The name of the time zone. Example: "Europe/Berlin"
  @override
  final String name;

  /// The abbreviation of the time zone. Example: "CET"
  @override
  final String abbreviation;

  /// The offset in hours. Example: 1 or -5
  @override
  final int offset;

  /// The offset display. Example: "GMT+01:00"
  @override
  final String offsetDisplay;

  @override
  String toString() {
    return 'TimeZone(name: $name, abbreviation: $abbreviation, offset: $offset, offsetDisplay: $offsetDisplay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeZoneImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.offsetDisplay, offsetDisplay) ||
                other.offsetDisplay == offsetDisplay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, abbreviation, offset, offsetDisplay);

  /// Create a copy of TimeZone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeZoneImplCopyWith<_$TimeZoneImpl> get copyWith =>
      __$$TimeZoneImplCopyWithImpl<_$TimeZoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeZoneImplToJson(this);
  }
}

abstract class _TimeZone extends TimeZone {
  const factory _TimeZone({
    required final String name,
    required final String abbreviation,
    required final int offset,
    required final String offsetDisplay,
  }) = _$TimeZoneImpl;
  const _TimeZone._() : super._();

  factory _TimeZone.fromJson(Map<String, dynamic> json) =
      _$TimeZoneImpl.fromJson;

  /// The name of the time zone. Example: "Europe/Berlin"
  @override
  String get name;

  /// The abbreviation of the time zone. Example: "CET"
  @override
  String get abbreviation;

  /// The offset in hours. Example: 1 or -5
  @override
  int get offset;

  /// The offset display. Example: "GMT+01:00"
  @override
  String get offsetDisplay;

  /// Create a copy of TimeZone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeZoneImplCopyWith<_$TimeZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
