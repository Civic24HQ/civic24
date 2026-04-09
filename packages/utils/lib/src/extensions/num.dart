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

  /// Returns a compact social count string
  /// Example: 999    → '999'
  /// Example: 1500   → '1.5K'
  /// Example: 15800  → '15.8K'
  /// Example: 1200000 → '1.2M'
  String get toCompactCount {
    if (this >= 1000000) {
      final m = this / 1000000;
      return '${m % 1 == 0 ? m.toInt() : m.toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      final k = this / 1000;
      return '${k % 1 == 0 ? k.toInt() : k.toStringAsFixed(1)}K';
    }
    return toString();
  }
}
