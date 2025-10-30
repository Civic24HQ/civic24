// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      provider: json['provider'] as String,
      email: json['email'] as String,
      account: UserAccount.fromJson(json['account'] as Map<String, dynamic>),
      devices: (json['devices'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, UserDeviceModel.fromJson(e as Map<String, dynamic>)),
      ),
      fcmTokens: json['fcmTokens'] as Map<String, dynamic>? ?? const {},
      path: json['path'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': instance.provider,
      'email': instance.email,
      'account': instance.account.toJson(),
      'devices': instance.devices.map((k, e) => MapEntry(k, e.toJson())),
      'fcmTokens': instance.fcmTokens,
      if (instance.path case final value?) 'path': value,
    };

_$UserAccountImpl _$$UserAccountImplFromJson(Map<String, dynamic> json) =>
    _$UserAccountImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      postalCode: json['postalCode'] as String,
      registrationDate: const TimestampConverter().fromJson(
        json['registrationDate'] as Timestamp,
      ),
      userType:
          $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.citizen,
      phoneNumber: json['phoneNumber'] as String?,
      profilePicture: json['profilePicture'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: const TimestampNullableConverter().fromJson(
        json['dateOfBirth'] as Timestamp?,
      ),
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      mustAuthenticate: json['mustAuthenticate'] as bool? ?? false,
      deletedAt: const TimestampNullableConverter().fromJson(
        json['deletedAt'] as Timestamp?,
      ),
      isDeleted: json['isDeleted'] as bool? ?? false,
      deleteReason: json['deleteReason'] as String? ?? '',
      isDisabled: json['isDisabled'] as bool? ?? false,
      disabledAt: const TimestampNullableConverter().fromJson(
        json['disabledAt'] as Timestamp?,
      ),
      disableReason: json['disableReason'] as String? ?? '',
      lastUpdated: const TimestampNullableConverter().fromJson(
        json['lastUpdated'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$$UserAccountImplToJson(_$UserAccountImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'postalCode': instance.postalCode,
      'registrationDate': const TimestampConverter().toJson(
        instance.registrationDate,
      ),
      'userType': _$UserTypeEnumMap[instance.userType]!,
      if (instance.phoneNumber case final value?) 'phoneNumber': value,
      if (instance.profilePicture case final value?) 'profilePicture': value,
      if (instance.gender case final value?) 'gender': value,
      if (const TimestampNullableConverter().toJson(instance.dateOfBirth)
          case final value?)
        'dateOfBirth': value,
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
      'mustAuthenticate': instance.mustAuthenticate,
      if (const TimestampNullableConverter().toJson(instance.deletedAt)
          case final value?)
        'deletedAt': value,
      'isDeleted': instance.isDeleted,
      'deleteReason': instance.deleteReason,
      'isDisabled': instance.isDisabled,
      if (const TimestampNullableConverter().toJson(instance.disabledAt)
          case final value?)
        'disabledAt': value,
      'disableReason': instance.disableReason,
      if (const TimestampNullableConverter().toJson(instance.lastUpdated)
          case final value?)
        'lastUpdated': value,
    };

const _$UserTypeEnumMap = {
  UserType.citizen: 'citizen',
  UserType.admin: 'admin',
};

_$UserDeviceModelImpl _$$UserDeviceModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserDeviceModelImpl(
  deviceModel: json['deviceModel'] as String,
  currentTimeZone: TimeZone.fromJson(
    json['currentTimeZone'] as Map<String, dynamic>,
  ),
  lastUsed: const TimestampNullableConverter().fromJson(
    json['lastUsed'] as Timestamp?,
  ),
);

Map<String, dynamic> _$$UserDeviceModelImplToJson(
  _$UserDeviceModelImpl instance,
) => <String, dynamic>{
  'deviceModel': instance.deviceModel,
  'currentTimeZone': instance.currentTimeZone.toJson(),
  if (const TimestampNullableConverter().toJson(instance.lastUsed)
      case final value?)
    'lastUsed': value,
};

_$TimeZoneImpl _$$TimeZoneImplFromJson(Map<String, dynamic> json) =>
    _$TimeZoneImpl(
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String,
      offset: (json['offset'] as num).toInt(),
      offsetDisplay: json['offsetDisplay'] as String,
    );

Map<String, dynamic> _$$TimeZoneImplToJson(_$TimeZoneImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'offset': instance.offset,
      'offsetDisplay': instance.offsetDisplay,
    };
