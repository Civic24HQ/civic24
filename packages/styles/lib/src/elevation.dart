import 'package:flutter/widgets.dart';

class AppElevation {
  AppElevation._();

  /// Low elevation shadow
  static const low = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.12), blurRadius: 3, offset: Offset(0, 1)),
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.02), blurRadius: 1, offset: Offset(0, 0.1)),
  ];

  /// Medium elevation shadow
  static const medium = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.12), blurRadius: 3, offset: Offset(0, 1)),
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.02), blurRadius: 1, offset: Offset(0, 0.1)),
  ];

  /// High elevation shadow
  static const high = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.19), blurRadius: 9, offset: Offset(0, 2.8)),
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.04), blurRadius: 1, offset: Offset(0, 0.3)),
  ];

  /// Very high elevation shadow
  static const veryHigh = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.19), blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.04), blurRadius: 5, offset: Offset(0, 0.5)),
  ];

  /// Ultra high elevation shadow
  static const ultraHigh = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.19), blurRadius: 16, offset: Offset(0, 6)),
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.04), blurRadius: 6, offset: Offset(0, 1)),
  ];
}
