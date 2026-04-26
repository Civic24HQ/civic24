import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';
part 'notification_preferences.g.dart';

/// Controls which push + in-app notifications a user receives.
/// All flags default to true (opt-in). Users adjust these in Settings.
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  @JsonSerializable()
  const factory NotificationPreferences({
    /// Master switch — when false, no push notifications are sent at all.
    @Default(true) bool pushEnabled,

    /// Notify when someone likes one of the user's reports.
    @Default(true) bool likesEnabled,

    /// Notify when someone dislikes one of the user's reports.
    @Default(true) bool dislikesEnabled,

    /// Notify the author when their own report is published.
    @Default(true) bool reportCreatedEnabled,
  }) = _NotificationPreferences;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesFromJson(json);
}
