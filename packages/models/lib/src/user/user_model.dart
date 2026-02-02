import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:models/utils/timestamp_converter.dart';

part 'src/user_account.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserType {
  /// All citizens using the app
  citizen,

  /// Reserve for Administrators and Super Administrators
  /// who have access to the admin panel.
  admin,
}

@freezed
abstract class UserModel with _$UserModel, SerializeJson {
  @JsonSerializable()
  const factory UserModel({
    /// The user's unique id.
    required String id,

    /// The provider used to authenticate the user.
    /// Example: "google" or "apple" or "email".
    required String provider,

    /// The user's email address.
    required String email,

    /// The user's account details.
    required UserAccount account,

    /// A map containing keys as device models and values
    /// as the last time the user used the device.
    required Map<String, UserDeviceModel> devices,

    /// A map containing keys as device models prefixed
    /// with "android" or "ios" and separated by "." then
    /// the following is the device model.
    ///
    /// And the values of each key will be the corresponding
    /// FCM token of the user's device.
    @Default({}) Map<String, dynamic> fcmTokens,

    /// The document reference path, only be
    /// parsed when converted from Firestore
    String? path,
  }) = _UserModel;
  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

extension UserModelExtension on UserModel {
  /// Returns full name of the user.
  String get displayName => '${account.firstName} ${account.lastName}'.trim();

  /// Returns the user's full name for analytics format.
  /// Example: "John_Doe"
  String get analyticsName => '${account.firstName}_${account.lastName}'.trim();

  /// Returns the user's first name.
  String get firstName => account.firstName;

  /// Returns the user's last name.
  String get lastName => account.lastName;

  /// Returns the user's initials
  String get initials => '${firstName[0]}${lastName[0]}';

  /// Returns the user's display name with email.
  String get nameWithEmail => '$displayName | $email';

  /// Returns the user's country.
  String get country => account.country;

  /// Returns the user's state.
  String get state => account.state;

  /// Returns the user's city.
  String get city => account.city;

  /// Returns the user's profile picture.
  String? get profilePicture => account.profilePicture;

  /// Returns the list of the user's devices.
  List<UserDeviceModel> get deviceList => devices.values.toList();

  /// Returns true if the user uses google to authenticate.
  bool get isGoogleUser => provider == 'Google';

  /// Returns true if the user uses apple to authenticate.
  bool get isAppleUser => provider == 'Apple';

  /// Returns the user's account type.
  UserType get userType => account.userType;

  /// Returns true if the user is an admin.
  bool get isAdmin => userType == UserType.admin;

  /// Returns true if the user account is disabled.
  bool get isDisabled => account.disableReason.isNotEmpty && !account.isDisabled;
}
