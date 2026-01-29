// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

/// The user's unique id.
 String get id;/// The provider used to authenticate the user.
/// Example: "google" or "apple" or "email".
 String get provider;/// The user's email address.
 String get email;/// The user's account details.
 UserAccount get account;/// A map containing keys as device models and values
/// as the last time the user used the device.
 Map<String, UserDeviceModel> get devices;/// A map containing keys as device models prefixed
/// with "android" or "ios" and separated by "." then
/// the following is the device model.
///
/// And the values of each key will be the corresponding
/// FCM token of the user's device.
 Map<String, dynamic> get fcmTokens;/// The document reference path, only be
/// parsed when converted from Firestore
 String? get path;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.email, email) || other.email == email)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.devices, devices)&&const DeepCollectionEquality().equals(other.fcmTokens, fcmTokens)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,email,account,const DeepCollectionEquality().hash(devices),const DeepCollectionEquality().hash(fcmTokens),path);

@override
String toString() {
  return 'UserModel(id: $id, provider: $provider, email: $email, account: $account, devices: $devices, fcmTokens: $fcmTokens, path: $path)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String provider, String email, UserAccount account, Map<String, UserDeviceModel> devices, Map<String, dynamic> fcmTokens, String? path
});


$UserAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? provider = null,Object? email = null,Object? account = null,Object? devices = null,Object? fcmTokens = null,Object? path = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as UserAccount,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as Map<String, UserDeviceModel>,fcmTokens: null == fcmTokens ? _self.fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAccountCopyWith<$Res> get account {
  
  return $UserAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String provider,  String email,  UserAccount account,  Map<String, UserDeviceModel> devices,  Map<String, dynamic> fcmTokens,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.provider,_that.email,_that.account,_that.devices,_that.fcmTokens,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String provider,  String email,  UserAccount account,  Map<String, UserDeviceModel> devices,  Map<String, dynamic> fcmTokens,  String? path)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.provider,_that.email,_that.account,_that.devices,_that.fcmTokens,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String provider,  String email,  UserAccount account,  Map<String, UserDeviceModel> devices,  Map<String, dynamic> fcmTokens,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.provider,_that.email,_that.account,_that.devices,_that.fcmTokens,_that.path);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _UserModel extends UserModel {
  const _UserModel({required this.id, required this.provider, required this.email, required this.account, required final  Map<String, UserDeviceModel> devices, final  Map<String, dynamic> fcmTokens = const {}, this.path}): _devices = devices,_fcmTokens = fcmTokens,super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

/// The user's unique id.
@override final  String id;
/// The provider used to authenticate the user.
/// Example: "google" or "apple" or "email".
@override final  String provider;
/// The user's email address.
@override final  String email;
/// The user's account details.
@override final  UserAccount account;
/// A map containing keys as device models and values
/// as the last time the user used the device.
 final  Map<String, UserDeviceModel> _devices;
/// A map containing keys as device models and values
/// as the last time the user used the device.
@override Map<String, UserDeviceModel> get devices {
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
 final  Map<String, dynamic> _fcmTokens;
/// A map containing keys as device models prefixed
/// with "android" or "ios" and separated by "." then
/// the following is the device model.
///
/// And the values of each key will be the corresponding
/// FCM token of the user's device.
@override@JsonKey() Map<String, dynamic> get fcmTokens {
  if (_fcmTokens is EqualUnmodifiableMapView) return _fcmTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fcmTokens);
}

/// The document reference path, only be
/// parsed when converted from Firestore
@override final  String? path;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.email, email) || other.email == email)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other._devices, _devices)&&const DeepCollectionEquality().equals(other._fcmTokens, _fcmTokens)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,email,account,const DeepCollectionEquality().hash(_devices),const DeepCollectionEquality().hash(_fcmTokens),path);

@override
String toString() {
  return 'UserModel(id: $id, provider: $provider, email: $email, account: $account, devices: $devices, fcmTokens: $fcmTokens, path: $path)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String provider, String email, UserAccount account, Map<String, UserDeviceModel> devices, Map<String, dynamic> fcmTokens, String? path
});


@override $UserAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? provider = null,Object? email = null,Object? account = null,Object? devices = null,Object? fcmTokens = null,Object? path = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as UserAccount,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as Map<String, UserDeviceModel>,fcmTokens: null == fcmTokens ? _self._fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAccountCopyWith<$Res> get account {
  
  return $UserAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// @nodoc
mixin _$UserAccount {

/// The user's first name.
 String get firstName;/// The user's last name.
 String get lastName;/// The user's email address.
 String get email;/// The user's country of residence.
/// Example: "Nigeria", "United States", etc.
 String get country;/// The user's state of residence.
/// Example: "Lagos", "California", etc.
 String get state;/// The user's city of residence.
/// Example: "Ikeja", "Los Angeles", etc.
 String get city;/// The user's address.
/// Example: "123, Fake Street, Lagos"
 String get address;/// The user's postal code.
/// Example: "100001"
 String get postalCode;/// Registration date of the user
@TimestampConverter() DateTime get registrationDate;/// The user's account type.
 UserType get userType;/// The user's phone number.
 String? get phoneNumber;/// The user's profile picture.
 String? get profilePicture;/// The user's gender.
 String? get gender;/// Date of birth of the user
@TimestampNullableConverter() DateTime? get dateOfBirth;/// A check to see if the user has completed onboarding.
 bool get hasCompletedOnboarding;/// If the value of this variable is true, we will navigate
/// user to authentication screen.
 bool get mustAuthenticate;/// The date of account deletion
@TimestampNullableConverter() DateTime? get deletedAt;/// The status of account deletion
/// (true if the account is deleted, false otherwise)
 bool get isDeleted;/// The reason for account deletion
 String get deleteReason;/// For soft delete purpose or emergency
 bool get isDisabled;/// For soft delete purpose or emergency
@TimestampNullableConverter() DateTime? get disabledAt;/// The reason for account disable
/// Example: "suspicious activity", "violating terms", etc.
 String get disableReason;/// The date the account was last updated
/// (this includes profile update, password change, etc.)
@TimestampNullableConverter() DateTime? get lastUpdated;
/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAccountCopyWith<UserAccount> get copyWith => _$UserAccountCopyWithImpl<UserAccount>(this as UserAccount, _$identity);

  /// Serializes this UserAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAccount&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.registrationDate, registrationDate) || other.registrationDate == registrationDate)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.mustAuthenticate, mustAuthenticate) || other.mustAuthenticate == mustAuthenticate)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deleteReason, deleteReason) || other.deleteReason == deleteReason)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled)&&(identical(other.disabledAt, disabledAt) || other.disabledAt == disabledAt)&&(identical(other.disableReason, disableReason) || other.disableReason == disableReason)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,firstName,lastName,email,country,state,city,address,postalCode,registrationDate,userType,phoneNumber,profilePicture,gender,dateOfBirth,hasCompletedOnboarding,mustAuthenticate,deletedAt,isDeleted,deleteReason,isDisabled,disabledAt,disableReason,lastUpdated]);

@override
String toString() {
  return 'UserAccount(firstName: $firstName, lastName: $lastName, email: $email, country: $country, state: $state, city: $city, address: $address, postalCode: $postalCode, registrationDate: $registrationDate, userType: $userType, phoneNumber: $phoneNumber, profilePicture: $profilePicture, gender: $gender, dateOfBirth: $dateOfBirth, hasCompletedOnboarding: $hasCompletedOnboarding, mustAuthenticate: $mustAuthenticate, deletedAt: $deletedAt, isDeleted: $isDeleted, deleteReason: $deleteReason, isDisabled: $isDisabled, disabledAt: $disabledAt, disableReason: $disableReason, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $UserAccountCopyWith<$Res>  {
  factory $UserAccountCopyWith(UserAccount value, $Res Function(UserAccount) _then) = _$UserAccountCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String email, String country, String state, String city, String address, String postalCode,@TimestampConverter() DateTime registrationDate, UserType userType, String? phoneNumber, String? profilePicture, String? gender,@TimestampNullableConverter() DateTime? dateOfBirth, bool hasCompletedOnboarding, bool mustAuthenticate,@TimestampNullableConverter() DateTime? deletedAt, bool isDeleted, String deleteReason, bool isDisabled,@TimestampNullableConverter() DateTime? disabledAt, String disableReason,@TimestampNullableConverter() DateTime? lastUpdated
});




}
/// @nodoc
class _$UserAccountCopyWithImpl<$Res>
    implements $UserAccountCopyWith<$Res> {
  _$UserAccountCopyWithImpl(this._self, this._then);

  final UserAccount _self;
  final $Res Function(UserAccount) _then;

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? country = null,Object? state = null,Object? city = null,Object? address = null,Object? postalCode = null,Object? registrationDate = null,Object? userType = null,Object? phoneNumber = freezed,Object? profilePicture = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? hasCompletedOnboarding = null,Object? mustAuthenticate = null,Object? deletedAt = freezed,Object? isDeleted = null,Object? deleteReason = null,Object? isDisabled = null,Object? disabledAt = freezed,Object? disableReason = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,registrationDate: null == registrationDate ? _self.registrationDate : registrationDate // ignore: cast_nullable_to_non_nullable
as DateTime,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as UserType,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,mustAuthenticate: null == mustAuthenticate ? _self.mustAuthenticate : mustAuthenticate // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deleteReason: null == deleteReason ? _self.deleteReason : deleteReason // ignore: cast_nullable_to_non_nullable
as String,isDisabled: null == isDisabled ? _self.isDisabled : isDisabled // ignore: cast_nullable_to_non_nullable
as bool,disabledAt: freezed == disabledAt ? _self.disabledAt : disabledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,disableReason: null == disableReason ? _self.disableReason : disableReason // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAccount].
extension UserAccountPatterns on UserAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAccount value)  $default,){
final _that = this;
switch (_that) {
case _UserAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAccount value)?  $default,){
final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String country,  String state,  String city,  String address,  String postalCode, @TimestampConverter()  DateTime registrationDate,  UserType userType,  String? phoneNumber,  String? profilePicture,  String? gender, @TimestampNullableConverter()  DateTime? dateOfBirth,  bool hasCompletedOnboarding,  bool mustAuthenticate, @TimestampNullableConverter()  DateTime? deletedAt,  bool isDeleted,  String deleteReason,  bool isDisabled, @TimestampNullableConverter()  DateTime? disabledAt,  String disableReason, @TimestampNullableConverter()  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.country,_that.state,_that.city,_that.address,_that.postalCode,_that.registrationDate,_that.userType,_that.phoneNumber,_that.profilePicture,_that.gender,_that.dateOfBirth,_that.hasCompletedOnboarding,_that.mustAuthenticate,_that.deletedAt,_that.isDeleted,_that.deleteReason,_that.isDisabled,_that.disabledAt,_that.disableReason,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String country,  String state,  String city,  String address,  String postalCode, @TimestampConverter()  DateTime registrationDate,  UserType userType,  String? phoneNumber,  String? profilePicture,  String? gender, @TimestampNullableConverter()  DateTime? dateOfBirth,  bool hasCompletedOnboarding,  bool mustAuthenticate, @TimestampNullableConverter()  DateTime? deletedAt,  bool isDeleted,  String deleteReason,  bool isDisabled, @TimestampNullableConverter()  DateTime? disabledAt,  String disableReason, @TimestampNullableConverter()  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _UserAccount():
return $default(_that.firstName,_that.lastName,_that.email,_that.country,_that.state,_that.city,_that.address,_that.postalCode,_that.registrationDate,_that.userType,_that.phoneNumber,_that.profilePicture,_that.gender,_that.dateOfBirth,_that.hasCompletedOnboarding,_that.mustAuthenticate,_that.deletedAt,_that.isDeleted,_that.deleteReason,_that.isDisabled,_that.disabledAt,_that.disableReason,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String email,  String country,  String state,  String city,  String address,  String postalCode, @TimestampConverter()  DateTime registrationDate,  UserType userType,  String? phoneNumber,  String? profilePicture,  String? gender, @TimestampNullableConverter()  DateTime? dateOfBirth,  bool hasCompletedOnboarding,  bool mustAuthenticate, @TimestampNullableConverter()  DateTime? deletedAt,  bool isDeleted,  String deleteReason,  bool isDisabled, @TimestampNullableConverter()  DateTime? disabledAt,  String disableReason, @TimestampNullableConverter()  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.country,_that.state,_that.city,_that.address,_that.postalCode,_that.registrationDate,_that.userType,_that.phoneNumber,_that.profilePicture,_that.gender,_that.dateOfBirth,_that.hasCompletedOnboarding,_that.mustAuthenticate,_that.deletedAt,_that.isDeleted,_that.deleteReason,_that.isDisabled,_that.disabledAt,_that.disableReason,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _UserAccount extends UserAccount {
  const _UserAccount({required this.firstName, required this.lastName, required this.email, required this.country, required this.state, required this.city, required this.address, required this.postalCode, @TimestampConverter() required this.registrationDate, this.userType = UserType.citizen, this.phoneNumber, this.profilePicture, this.gender, @TimestampNullableConverter() this.dateOfBirth, this.hasCompletedOnboarding = false, this.mustAuthenticate = false, @TimestampNullableConverter() this.deletedAt, this.isDeleted = false, this.deleteReason = '', this.isDisabled = false, @TimestampNullableConverter() this.disabledAt, this.disableReason = '', @TimestampNullableConverter() this.lastUpdated}): super._();
  factory _UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);

/// The user's first name.
@override final  String firstName;
/// The user's last name.
@override final  String lastName;
/// The user's email address.
@override final  String email;
/// The user's country of residence.
/// Example: "Nigeria", "United States", etc.
@override final  String country;
/// The user's state of residence.
/// Example: "Lagos", "California", etc.
@override final  String state;
/// The user's city of residence.
/// Example: "Ikeja", "Los Angeles", etc.
@override final  String city;
/// The user's address.
/// Example: "123, Fake Street, Lagos"
@override final  String address;
/// The user's postal code.
/// Example: "100001"
@override final  String postalCode;
/// Registration date of the user
@override@TimestampConverter() final  DateTime registrationDate;
/// The user's account type.
@override@JsonKey() final  UserType userType;
/// The user's phone number.
@override final  String? phoneNumber;
/// The user's profile picture.
@override final  String? profilePicture;
/// The user's gender.
@override final  String? gender;
/// Date of birth of the user
@override@TimestampNullableConverter() final  DateTime? dateOfBirth;
/// A check to see if the user has completed onboarding.
@override@JsonKey() final  bool hasCompletedOnboarding;
/// If the value of this variable is true, we will navigate
/// user to authentication screen.
@override@JsonKey() final  bool mustAuthenticate;
/// The date of account deletion
@override@TimestampNullableConverter() final  DateTime? deletedAt;
/// The status of account deletion
/// (true if the account is deleted, false otherwise)
@override@JsonKey() final  bool isDeleted;
/// The reason for account deletion
@override@JsonKey() final  String deleteReason;
/// For soft delete purpose or emergency
@override@JsonKey() final  bool isDisabled;
/// For soft delete purpose or emergency
@override@TimestampNullableConverter() final  DateTime? disabledAt;
/// The reason for account disable
/// Example: "suspicious activity", "violating terms", etc.
@override@JsonKey() final  String disableReason;
/// The date the account was last updated
/// (this includes profile update, password change, etc.)
@override@TimestampNullableConverter() final  DateTime? lastUpdated;

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAccountCopyWith<_UserAccount> get copyWith => __$UserAccountCopyWithImpl<_UserAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAccount&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.registrationDate, registrationDate) || other.registrationDate == registrationDate)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.mustAuthenticate, mustAuthenticate) || other.mustAuthenticate == mustAuthenticate)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deleteReason, deleteReason) || other.deleteReason == deleteReason)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled)&&(identical(other.disabledAt, disabledAt) || other.disabledAt == disabledAt)&&(identical(other.disableReason, disableReason) || other.disableReason == disableReason)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,firstName,lastName,email,country,state,city,address,postalCode,registrationDate,userType,phoneNumber,profilePicture,gender,dateOfBirth,hasCompletedOnboarding,mustAuthenticate,deletedAt,isDeleted,deleteReason,isDisabled,disabledAt,disableReason,lastUpdated]);

@override
String toString() {
  return 'UserAccount(firstName: $firstName, lastName: $lastName, email: $email, country: $country, state: $state, city: $city, address: $address, postalCode: $postalCode, registrationDate: $registrationDate, userType: $userType, phoneNumber: $phoneNumber, profilePicture: $profilePicture, gender: $gender, dateOfBirth: $dateOfBirth, hasCompletedOnboarding: $hasCompletedOnboarding, mustAuthenticate: $mustAuthenticate, deletedAt: $deletedAt, isDeleted: $isDeleted, deleteReason: $deleteReason, isDisabled: $isDisabled, disabledAt: $disabledAt, disableReason: $disableReason, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$UserAccountCopyWith<$Res> implements $UserAccountCopyWith<$Res> {
  factory _$UserAccountCopyWith(_UserAccount value, $Res Function(_UserAccount) _then) = __$UserAccountCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String email, String country, String state, String city, String address, String postalCode,@TimestampConverter() DateTime registrationDate, UserType userType, String? phoneNumber, String? profilePicture, String? gender,@TimestampNullableConverter() DateTime? dateOfBirth, bool hasCompletedOnboarding, bool mustAuthenticate,@TimestampNullableConverter() DateTime? deletedAt, bool isDeleted, String deleteReason, bool isDisabled,@TimestampNullableConverter() DateTime? disabledAt, String disableReason,@TimestampNullableConverter() DateTime? lastUpdated
});




}
/// @nodoc
class __$UserAccountCopyWithImpl<$Res>
    implements _$UserAccountCopyWith<$Res> {
  __$UserAccountCopyWithImpl(this._self, this._then);

  final _UserAccount _self;
  final $Res Function(_UserAccount) _then;

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? country = null,Object? state = null,Object? city = null,Object? address = null,Object? postalCode = null,Object? registrationDate = null,Object? userType = null,Object? phoneNumber = freezed,Object? profilePicture = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? hasCompletedOnboarding = null,Object? mustAuthenticate = null,Object? deletedAt = freezed,Object? isDeleted = null,Object? deleteReason = null,Object? isDisabled = null,Object? disabledAt = freezed,Object? disableReason = null,Object? lastUpdated = freezed,}) {
  return _then(_UserAccount(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,registrationDate: null == registrationDate ? _self.registrationDate : registrationDate // ignore: cast_nullable_to_non_nullable
as DateTime,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as UserType,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,mustAuthenticate: null == mustAuthenticate ? _self.mustAuthenticate : mustAuthenticate // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deleteReason: null == deleteReason ? _self.deleteReason : deleteReason // ignore: cast_nullable_to_non_nullable
as String,isDisabled: null == isDisabled ? _self.isDisabled : isDisabled // ignore: cast_nullable_to_non_nullable
as bool,disabledAt: freezed == disabledAt ? _self.disabledAt : disabledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,disableReason: null == disableReason ? _self.disableReason : disableReason // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UserDeviceModel {

/// The device model of the user.
/// Example: "android_pixel_3a", "ios_iphone_12", etc.
 String get deviceModel;/// The time zone this device is being used.
 TimeZone get currentTimeZone;/// The last time the user used the device.
@TimestampNullableConverter() DateTime? get lastUsed;
/// Create a copy of UserDeviceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDeviceModelCopyWith<UserDeviceModel> get copyWith => _$UserDeviceModelCopyWithImpl<UserDeviceModel>(this as UserDeviceModel, _$identity);

  /// Serializes this UserDeviceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDeviceModel&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.currentTimeZone, currentTimeZone) || other.currentTimeZone == currentTimeZone)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceModel,currentTimeZone,lastUsed);

@override
String toString() {
  return 'UserDeviceModel(deviceModel: $deviceModel, currentTimeZone: $currentTimeZone, lastUsed: $lastUsed)';
}


}

/// @nodoc
abstract mixin class $UserDeviceModelCopyWith<$Res>  {
  factory $UserDeviceModelCopyWith(UserDeviceModel value, $Res Function(UserDeviceModel) _then) = _$UserDeviceModelCopyWithImpl;
@useResult
$Res call({
 String deviceModel, TimeZone currentTimeZone,@TimestampNullableConverter() DateTime? lastUsed
});


$TimeZoneCopyWith<$Res> get currentTimeZone;

}
/// @nodoc
class _$UserDeviceModelCopyWithImpl<$Res>
    implements $UserDeviceModelCopyWith<$Res> {
  _$UserDeviceModelCopyWithImpl(this._self, this._then);

  final UserDeviceModel _self;
  final $Res Function(UserDeviceModel) _then;

/// Create a copy of UserDeviceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceModel = null,Object? currentTimeZone = null,Object? lastUsed = freezed,}) {
  return _then(_self.copyWith(
deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,currentTimeZone: null == currentTimeZone ? _self.currentTimeZone : currentTimeZone // ignore: cast_nullable_to_non_nullable
as TimeZone,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of UserDeviceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeZoneCopyWith<$Res> get currentTimeZone {
  
  return $TimeZoneCopyWith<$Res>(_self.currentTimeZone, (value) {
    return _then(_self.copyWith(currentTimeZone: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserDeviceModel].
extension UserDeviceModelPatterns on UserDeviceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDeviceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDeviceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDeviceModel value)  $default,){
final _that = this;
switch (_that) {
case _UserDeviceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDeviceModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserDeviceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceModel,  TimeZone currentTimeZone, @TimestampNullableConverter()  DateTime? lastUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDeviceModel() when $default != null:
return $default(_that.deviceModel,_that.currentTimeZone,_that.lastUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceModel,  TimeZone currentTimeZone, @TimestampNullableConverter()  DateTime? lastUsed)  $default,) {final _that = this;
switch (_that) {
case _UserDeviceModel():
return $default(_that.deviceModel,_that.currentTimeZone,_that.lastUsed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceModel,  TimeZone currentTimeZone, @TimestampNullableConverter()  DateTime? lastUsed)?  $default,) {final _that = this;
switch (_that) {
case _UserDeviceModel() when $default != null:
return $default(_that.deviceModel,_that.currentTimeZone,_that.lastUsed);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _UserDeviceModel extends UserDeviceModel {
  const _UserDeviceModel({required this.deviceModel, required this.currentTimeZone, @TimestampNullableConverter() this.lastUsed}): super._();
  factory _UserDeviceModel.fromJson(Map<String, dynamic> json) => _$UserDeviceModelFromJson(json);

/// The device model of the user.
/// Example: "android_pixel_3a", "ios_iphone_12", etc.
@override final  String deviceModel;
/// The time zone this device is being used.
@override final  TimeZone currentTimeZone;
/// The last time the user used the device.
@override@TimestampNullableConverter() final  DateTime? lastUsed;

/// Create a copy of UserDeviceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDeviceModelCopyWith<_UserDeviceModel> get copyWith => __$UserDeviceModelCopyWithImpl<_UserDeviceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDeviceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDeviceModel&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.currentTimeZone, currentTimeZone) || other.currentTimeZone == currentTimeZone)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceModel,currentTimeZone,lastUsed);

@override
String toString() {
  return 'UserDeviceModel(deviceModel: $deviceModel, currentTimeZone: $currentTimeZone, lastUsed: $lastUsed)';
}


}

/// @nodoc
abstract mixin class _$UserDeviceModelCopyWith<$Res> implements $UserDeviceModelCopyWith<$Res> {
  factory _$UserDeviceModelCopyWith(_UserDeviceModel value, $Res Function(_UserDeviceModel) _then) = __$UserDeviceModelCopyWithImpl;
@override @useResult
$Res call({
 String deviceModel, TimeZone currentTimeZone,@TimestampNullableConverter() DateTime? lastUsed
});


@override $TimeZoneCopyWith<$Res> get currentTimeZone;

}
/// @nodoc
class __$UserDeviceModelCopyWithImpl<$Res>
    implements _$UserDeviceModelCopyWith<$Res> {
  __$UserDeviceModelCopyWithImpl(this._self, this._then);

  final _UserDeviceModel _self;
  final $Res Function(_UserDeviceModel) _then;

/// Create a copy of UserDeviceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceModel = null,Object? currentTimeZone = null,Object? lastUsed = freezed,}) {
  return _then(_UserDeviceModel(
deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,currentTimeZone: null == currentTimeZone ? _self.currentTimeZone : currentTimeZone // ignore: cast_nullable_to_non_nullable
as TimeZone,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of UserDeviceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeZoneCopyWith<$Res> get currentTimeZone {
  
  return $TimeZoneCopyWith<$Res>(_self.currentTimeZone, (value) {
    return _then(_self.copyWith(currentTimeZone: value));
  });
}
}


/// @nodoc
mixin _$TimeZone {

/// The name of the time zone. Example: "Europe/Berlin"
 String get name;/// The abbreviation of the time zone. Example: "CET"
 String get abbreviation;/// The offset in hours. Example: 1 or -5
 int get offset;/// The offset display. Example: "GMT+01:00"
 String get offsetDisplay;
/// Create a copy of TimeZone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeZoneCopyWith<TimeZone> get copyWith => _$TimeZoneCopyWithImpl<TimeZone>(this as TimeZone, _$identity);

  /// Serializes this TimeZone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeZone&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.offsetDisplay, offsetDisplay) || other.offsetDisplay == offsetDisplay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,abbreviation,offset,offsetDisplay);

@override
String toString() {
  return 'TimeZone(name: $name, abbreviation: $abbreviation, offset: $offset, offsetDisplay: $offsetDisplay)';
}


}

/// @nodoc
abstract mixin class $TimeZoneCopyWith<$Res>  {
  factory $TimeZoneCopyWith(TimeZone value, $Res Function(TimeZone) _then) = _$TimeZoneCopyWithImpl;
@useResult
$Res call({
 String name, String abbreviation, int offset, String offsetDisplay
});




}
/// @nodoc
class _$TimeZoneCopyWithImpl<$Res>
    implements $TimeZoneCopyWith<$Res> {
  _$TimeZoneCopyWithImpl(this._self, this._then);

  final TimeZone _self;
  final $Res Function(TimeZone) _then;

/// Create a copy of TimeZone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? abbreviation = null,Object? offset = null,Object? offsetDisplay = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,offsetDisplay: null == offsetDisplay ? _self.offsetDisplay : offsetDisplay // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeZone].
extension TimeZonePatterns on TimeZone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeZone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeZone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeZone value)  $default,){
final _that = this;
switch (_that) {
case _TimeZone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeZone value)?  $default,){
final _that = this;
switch (_that) {
case _TimeZone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String abbreviation,  int offset,  String offsetDisplay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeZone() when $default != null:
return $default(_that.name,_that.abbreviation,_that.offset,_that.offsetDisplay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String abbreviation,  int offset,  String offsetDisplay)  $default,) {final _that = this;
switch (_that) {
case _TimeZone():
return $default(_that.name,_that.abbreviation,_that.offset,_that.offsetDisplay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String abbreviation,  int offset,  String offsetDisplay)?  $default,) {final _that = this;
switch (_that) {
case _TimeZone() when $default != null:
return $default(_that.name,_that.abbreviation,_that.offset,_that.offsetDisplay);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _TimeZone extends TimeZone {
  const _TimeZone({required this.name, required this.abbreviation, required this.offset, required this.offsetDisplay}): super._();
  factory _TimeZone.fromJson(Map<String, dynamic> json) => _$TimeZoneFromJson(json);

/// The name of the time zone. Example: "Europe/Berlin"
@override final  String name;
/// The abbreviation of the time zone. Example: "CET"
@override final  String abbreviation;
/// The offset in hours. Example: 1 or -5
@override final  int offset;
/// The offset display. Example: "GMT+01:00"
@override final  String offsetDisplay;

/// Create a copy of TimeZone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeZoneCopyWith<_TimeZone> get copyWith => __$TimeZoneCopyWithImpl<_TimeZone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeZoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeZone&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.offsetDisplay, offsetDisplay) || other.offsetDisplay == offsetDisplay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,abbreviation,offset,offsetDisplay);

@override
String toString() {
  return 'TimeZone(name: $name, abbreviation: $abbreviation, offset: $offset, offsetDisplay: $offsetDisplay)';
}


}

/// @nodoc
abstract mixin class _$TimeZoneCopyWith<$Res> implements $TimeZoneCopyWith<$Res> {
  factory _$TimeZoneCopyWith(_TimeZone value, $Res Function(_TimeZone) _then) = __$TimeZoneCopyWithImpl;
@override @useResult
$Res call({
 String name, String abbreviation, int offset, String offsetDisplay
});




}
/// @nodoc
class __$TimeZoneCopyWithImpl<$Res>
    implements _$TimeZoneCopyWith<$Res> {
  __$TimeZoneCopyWithImpl(this._self, this._then);

  final _TimeZone _self;
  final $Res Function(_TimeZone) _then;

/// Create a copy of TimeZone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? abbreviation = null,Object? offset = null,Object? offsetDisplay = null,}) {
  return _then(_TimeZone(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,offsetDisplay: null == offsetDisplay ? _self.offsetDisplay : offsetDisplay // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
