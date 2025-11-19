part of '../user_model.dart';

@freezed
class UserAccount with _$UserAccount {
  @JsonSerializable()
  const factory UserAccount({
    /// The user's first name.
    required String firstName,

    /// The user's last name.
    required String lastName,

    /// The user's email address.
    required String email,

    /// The user's country of residence.
    /// Example: "Nigeria", "United States", etc.
    required String country,

    /// The user's state of residence.
    /// Example: "Lagos", "California", etc.
    required String state,

    /// The user's city of residence.
    /// Example: "Ikeja", "Los Angeles", etc.
    required String city,

    /// The user's address.
    /// Example: "123, Fake Street, Lagos"
    required String address,

    /// The user's postal code.
    /// Example: "100001"
    required String postalCode,

    /// Registration date of the user
    @TimestampConverter() required DateTime registrationDate,

    /// The user's account type.
    @Default(UserType.citizen) UserType userType,

    /// The user's phone number.
    String? phoneNumber,

    /// The user's profile picture.
    String? profilePicture,

    /// The user's gender.
    String? gender,

    /// Date of birth of the user
    @TimestampNullableConverter() DateTime? dateOfBirth,

    /// A check to see if the user has completed onboarding.
    @Default(false) bool hasCompletedOnboarding,

    /// If the value of this variable is true, we will navigate
    /// user to authentication screen.
    @Default(false) bool mustAuthenticate,

    /// The date of account deletion
    @TimestampNullableConverter() DateTime? deletedAt,

    /// The status of account deletion
    /// (true if the account is deleted, false otherwise)
    @Default(false) bool isDeleted,

    /// The reason for account deletion
    @Default('') String deleteReason,

    /// For soft delete purpose or emergency
    @Default(false) bool isDisabled,

    /// For soft delete purpose or emergency
    @TimestampNullableConverter() DateTime? disabledAt,

    /// The reason for account disable
    /// Example: "suspicious activity", "violating terms", etc.
    @Default('') String disableReason,

    /// The date the account was last updated
    /// (this includes profile update, password change, etc.)
    @TimestampNullableConverter() DateTime? lastUpdated,
  }) = _UserAccount;
  const UserAccount._();

  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);
}

@freezed
class UserDeviceModel with _$UserDeviceModel {
  @JsonSerializable()
  const factory UserDeviceModel({
    /// The device model of the user.
    /// Example: "android_pixel_3a", "ios_iphone_12", etc.
    required String deviceModel,

    /// The time zone this device is being used.
    required TimeZone currentTimeZone,

    /// The last time the user used the device.
    @TimestampNullableConverter() DateTime? lastUsed,
  }) = _UserDeviceModel;
  const UserDeviceModel._();

  factory UserDeviceModel.fromJson(Map<String, dynamic> json) => _$UserDeviceModelFromJson(json);
}

@freezed
class TimeZone with _$TimeZone {
  @JsonSerializable()
  const factory TimeZone({
    /// The name of the time zone. Example: "Europe/Berlin"
    required String name,

    /// The abbreviation of the time zone. Example: "CET"
    required String abbreviation,

    /// The offset in hours. Example: 1 or -5
    required int offset,

    /// The offset display. Example: "GMT+01:00"
    required String offsetDisplay,
  }) = _TimeZone;

  const TimeZone._();

  factory TimeZone.fromJson(Map<String, dynamic> json) => _$TimeZoneFromJson(json);

  factory TimeZone.empty() => const TimeZone(name: '', abbreviation: '', offset: 0, offsetDisplay: 'GMT+00:00');
}
