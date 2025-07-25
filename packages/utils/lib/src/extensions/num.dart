extension IntExtensions on int {
  /// Returns a shortened version of the number
  /// Example: '10' returns '10'
  /// Example: '100' returns '99+'
  String get toShortNumber {
    if (this > 99) {
      return '99+';
    } else {
      return toString();
    }
  }
}
