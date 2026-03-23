
extension StringExtension on String {
  /// Capitalizes the first letter of a string
  /// Example: 'hello world'.capitalizeFirst => 'Hello world'
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Converts a string to title case (each word capitalized)
  /// Example: 'hello world'.toTitleCase => 'Hello World'
  String get toTitleCase {
    return split(' ').map((word) => word.capitalizeFirst).join(' ');
  }

  /// Returns initials of a full name string
  /// Example: 'John Doe'.initials => 'JD'
  String get initials {
    final names = split(' ');
    if (names.isEmpty) return '';

    if (names.length == 1) {
      return names.first.isNotEmpty ? names.first[0] : '';
    }

    final firstInitial = names.first.isNotEmpty ? names.first[0] : '';
    final lastInitial = names.last.isNotEmpty ? names.last[0] : '';

    return '$firstInitial$lastInitial';
  }
}
