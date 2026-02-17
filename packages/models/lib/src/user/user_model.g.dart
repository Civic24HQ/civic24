// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  provider: json['provider'] as String,
  email: json['email'] as String,
  account: UserAccount.fromJson(json['account'] as Map<String, dynamic>),
  devices: (json['devices'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, UserDeviceModel.fromJson(e as Map<String, dynamic>)),
  ),
  fcmTokens: json['fcmTokens'] as Map<String, dynamic>? ?? const {},
  path: json['path'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': instance.provider,
      'email': instance.email,
      'account': instance.account.toJson(),
      'devices': instance.devices.map((k, e) => MapEntry(k, e.toJson())),
      'fcmTokens': instance.fcmTokens,
      'path': ?instance.path,
    };

_UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => _UserAccount(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  country: json['country'] as String,
  state: json['state'] as String,
  city: json['city'] as String,
  address: json['address'] as String,
  postalCode: json['postalCode'] as String,
  registrationDate: const TimestampConverter().fromJson(
    json['registrationDate'],
  ),
  userType:
      $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
      UserType.citizen,
  phoneNumber: json['phoneNumber'] as String?,
  profilePicture: json['profilePicture'] as String?,
  gender: json['gender'] as String?,
  dateOfBirth: const TimestampNullableConverter().fromJson(json['dateOfBirth']),
  hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
  mustAuthenticate: json['mustAuthenticate'] as bool? ?? false,
  deletedAt: const TimestampNullableConverter().fromJson(json['deletedAt']),
  isDeleted: json['isDeleted'] as bool? ?? false,
  deleteReason: json['deleteReason'] as String? ?? '',
  isDisabled: json['isDisabled'] as bool? ?? false,
  disabledAt: const TimestampNullableConverter().fromJson(json['disabledAt']),
  disableReason: json['disableReason'] as String? ?? '',
  lastUpdated: const TimestampNullableConverter().fromJson(json['lastUpdated']),
);

Map<String, dynamic> _$UserAccountToJson(
  _UserAccount instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'country': instance.country,
  'state': instance.state,
  'city': instance.city,
  'address': instance.address,
  'postalCode': instance.postalCode,
  'registrationDate': ?const TimestampConverter().toJson(
    instance.registrationDate,
  ),
  'userType': _$UserTypeEnumMap[instance.userType]!,
  'phoneNumber': ?instance.phoneNumber,
  'profilePicture': ?instance.profilePicture,
  'gender': ?instance.gender,
  'dateOfBirth': ?const TimestampNullableConverter().toJson(
    instance.dateOfBirth,
  ),
  'hasCompletedOnboarding': instance.hasCompletedOnboarding,
  'mustAuthenticate': instance.mustAuthenticate,
  'deletedAt': ?const TimestampNullableConverter().toJson(instance.deletedAt),
  'isDeleted': instance.isDeleted,
  'deleteReason': instance.deleteReason,
  'isDisabled': instance.isDisabled,
  'disabledAt': ?const TimestampNullableConverter().toJson(instance.disabledAt),
  'disableReason': instance.disableReason,
  'lastUpdated': ?const TimestampNullableConverter().toJson(
    instance.lastUpdated,
  ),
};

const _$UserTypeEnumMap = {
  UserType.citizen: 'citizen',
  UserType.admin: 'admin',
};

_UserDeviceModel _$UserDeviceModelFromJson(Map<String, dynamic> json) =>
    _UserDeviceModel(
      deviceModel: json['deviceModel'] as String,
      currentTimeZone: TimeZone.fromJson(
        json['currentTimeZone'] as Map<String, dynamic>,
      ),
      lastUsed: const TimestampNullableConverter().fromJson(json['lastUsed']),
    );

Map<String, dynamic> _$UserDeviceModelToJson(_UserDeviceModel instance) =>
    <String, dynamic>{
      'deviceModel': instance.deviceModel,
      'currentTimeZone': instance.currentTimeZone.toJson(),
      'lastUsed': ?const TimestampNullableConverter().toJson(instance.lastUsed),
    };

_TimeZone _$TimeZoneFromJson(Map<String, dynamic> json) => _TimeZone(
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  offset: (json['offset'] as num).toInt(),
  offsetDisplay: json['offsetDisplay'] as String,
);

Map<String, dynamic> _$TimeZoneToJson(_TimeZone instance) => <String, dynamic>{
  'name': instance.name,
  'abbreviation': instance.abbreviation,
  'offset': instance.offset,
  'offsetDisplay': instance.offsetDisplay,
};
