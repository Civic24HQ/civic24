import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:models/utils/timestamp_converter.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

/// Represents a users notification with various attributes.
@freezed
class NotificationData with _$NotificationData, SerializeJson {
  @JsonSerializable()
  const factory NotificationData({
    /// Unique identifier for the notification.
    required String notificationId,

    /// The title of the user notification.
    required String title,

    /// The description of the user notification.
    required String description,

    /// The date when the notification was created.
    @TimestampConverter() required DateTime createdAt,

    /// The date when the notification was last updated.
    @TimestampConverter() required DateTime updatedAt,

    /// The variable that checks if a notification has been seen by the user
    @Default(false) bool hasBeenSeen,

    /// The id of the user who has the notification.
    String? userId,

    /// The icon data string of the notification.
    String? notificationIconData,

    /// The document reference path, only be
    /// parsed when converted from Firestore
    String? path,
  }) = _NotificationData;
  const NotificationData._();

  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

  /// Creates an unknown comment instance.
  factory NotificationData.unknown() => NotificationData(
    notificationId: '0',
    title: 'N/A',
    description: 'No content available',
    notificationIconData: 'N/A',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  factory NotificationData.empty() => NotificationData(
    notificationId: '',
    title: '',
    description: '',
    notificationIconData: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
