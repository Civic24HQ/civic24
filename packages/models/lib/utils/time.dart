import 'package:meta/meta.dart';

@immutable
/// A utility class representing a time of day without a date component.
///
/// This class is useful for storing and manipulating time values
/// independently of the `TimeOfDay` class from Flutter's material library,
/// making it easier to use in unit tests and backend logic.
///
/// It provides functionality for serializing and deserializing time values
/// and can be used in models where only the time component is needed.
class Time {
  const Time({this.hour = 10, this.minute = 0});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(hour: json['hour'] as int? ?? 10, minute: json['minute'] as int? ?? 0);
  }

  /// Converts from a [DateTime]
  factory Time.fromDateTime(DateTime dateTime) {
    return Time(hour: dateTime.hour, minute: dateTime.minute);
  }
  final int hour;
  final int minute;

  Map<String, dynamic> toJson() {
    return {'hour': hour, 'minute': minute};
  }

  Time copyWith({int? hour, int? minute}) {
    return Time(hour: hour ?? this.hour, minute: minute ?? this.minute);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time && runtimeType == other.runtimeType && hour == other.hour && minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() {
    return 'Time{hour: $hour, minute: $minute}';
  }

  /// Converts to a [DateTime].
  DateTime get toDateTime {
    final now = DateTime.now().toUtc();
    return DateTime(now.year, now.month, now.day, hour, minute).toLocal();
  }

  /// Returns a formatted string
  /// Example: "10:00"
  String get formatted => '$hour:${minute.toString().padLeft(2, '0')}';

  /// Returns a formatted string
  /// Example: "10:00 AM"
  String get formattedWithPeriod {
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    final formattedMinute = minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'AM' : 'PM';
    return '$formattedHour:$formattedMinute $period';
  }

  bool isBefore(Time time) {
    if (hour < time.hour) {
      return true;
    } else if (hour == time.hour) {
      return minute < time.minute;
    } else {
      return false;
    }
  }

  bool isAfter(Time closingTime) {
    if (hour > closingTime.hour) {
      return true;
    } else if (hour == closingTime.hour) {
      return minute > closingTime.minute;
    } else {
      return false;
    }
  }
}
