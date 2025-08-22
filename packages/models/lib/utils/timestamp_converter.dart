import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// A converter that converts a [Timestamp] to a [DateTime] and vice versa.
/// This is useful when you want to store a [DateTime] in Firestore.
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
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate().toLocal();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date.toUtc());
  }
}

class TimestampNullableConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampNullableConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate().toLocal();
  }

  @override
  Timestamp? toJson(DateTime? date) {
    return date == null ? null : Timestamp.fromDate(date.toUtc());
  }
}
