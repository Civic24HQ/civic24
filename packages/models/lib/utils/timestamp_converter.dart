import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// A converter that converts a [Timestamp] to a [DateTime] and vice versa,
/// but stores the date as an ISO8601 string for Hive compatibility.
/// This is useful when you want to store a [DateTime] in Firestore and also cache it locally using Hive.
///
/// To use this converter, import it and add it to the field you want to
/// convert.
///
/// An example of how to use this converter:
/// ```dart
/// import 'package:cloud_firestore/cloud_firestore.dart';
/// import 'package:freezed_annotation/freezed_annotation.dart';
/// import 'package:models/src/utils/timestamp_converter.dart';
/// ```
class TimestampConverter implements JsonConverter<DateTime, Object?> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json == null) {
      return DateTime.now();
    }

    // Firestore Timestamp
    if (json is Timestamp) {
      return json.toDate().toLocal();
    }

    // Cached ISO8601 string
    if (json is String) {
      return DateTime.parse(json).toLocal();
    }

    // Already DateTime
    if (json is DateTime) {
      return json.toLocal();
    }

    throw Exception('TimestampConverter: Unsupported type ${json.runtimeType}');
  }

  @override
  Object toJson(DateTime date) {
    // Store as ISO8601 string for Hive compatibility
    return date.toUtc().toIso8601String();
  }
}

/// Nullable version of TimestampConverter
class TimestampNullableConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampNullableConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;

    if (json is Timestamp) {
      return json.toDate().toLocal();
    }

    if (json is String) {
      return DateTime.parse(json).toLocal();
    }

    if (json is DateTime) {
      return json.toLocal();
    }

    throw Exception('TimestampNullableConverter: Unsupported type ${json.runtimeType}');
  }

  @override
  Object? toJson(DateTime? date) {
    return date?.toUtc().toIso8601String();
  }
}
