import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = MaterialColor(0xFF9E0000, {
    50: Color(0xFFFCE6E6),
    100: Color(0xFFF6B3B3),
    200: Color(0xFFEA4D4D),
    400: Color(0xFFE10000),
    500: Color(0xFF9E0000),
    600: Color(0xFF710000),
    700: Color(0xFF430000),
    800: Color(0xFF300202),
  });

  static const secondary = MaterialColor(0xFF27292A, {
    50: Color(0xFFE9EAEA),
    100: Color(0xFFCBCBCC),
    200: Color(0xFF8B8B8B),
    400: Color(0xFF4E5050),
    500: Color(0xFF27292A),
    800: Color(0xFF1C1D1E),
    900: Color(0xFF2A2A2A),
  });

  static const errorAccent = MaterialAccentColor(0xFFEF233C, {
    100: Color(0xFFFDE9EC),
    200: Color(0xFFEF233C),
    400: Color(0xFFAA192B),
    700: Color(0xFF640F19),
  });

  static const successAccent = MaterialAccentColor(0xFF2ECC71, {
    100: Color(0xFFEAFAF1),
    200: Color(0xFF2ECC71),
    400: Color(0xFF219150),
    700: Color(0xFF155C33),
  });

  static const warningAccent = MaterialAccentColor(0xFFFFD700, {
    100: Color(0xFFFFF5C2),
    200: Color(0xFFFFD700),
    400: Color(0xFF917B00),
    700: Color(0xFF736100),
  });

  static const neutral = MaterialColor(0xFF797979, {
    50: Color(0xFFF0F0F0),
    100: Color(0xFFDBDBDB),
    300: Color(0xFF989898),
    500: Color(0xFF797979),
    600: Color(0xFF5B5B5B),
    700: Color(0xFF3D3D3D),
  });

  static const Color white = Color(0xFFFCFCFC);
  static const Color whiteAlt = Color(0xFFF9F9F9);

  static const Color black = Color(0xFF171A18);
  static const Color blackAlt = Color(0xFF101211);
}
