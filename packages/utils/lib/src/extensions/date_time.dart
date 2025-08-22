import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Returns the date time ago in Instagram-style words
  /// Examples:
  ///   Just now (if less than a minute)
  ///   20m
  ///   2h
  ///   3d
  ///   8w
  ///   Jan 15 (if same year, older than ~8w)
  ///   Jan 15, 2024 (if different year)
  String get timeAgoInWords {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return '1m';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays}d';
    }

    final weeks = diff.inDays ~/ 7;
    if (weeks < 8) {
      return '${weeks}w';
    }

    // Older than 8 weeks shows calendar date
    if (year == now.year) {
      return DateFormat('MMM d').format(this); // e.g., Jan 15
    } else {
      return DateFormat('MMM d, y').format(this); // e.g., Jan 15, 2024
    }
  }
}
