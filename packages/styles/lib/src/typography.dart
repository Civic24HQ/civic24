part of 'theme.dart';

TextTheme get _textTheme {
  const fontFamily = FontFamily.poppins;

  return const TextTheme(
    displayLarge: TextStyle(fontFamily: fontFamily, fontSize: 45, fontWeight: FontWeight.w600, letterSpacing: 0),
    displayMedium: TextStyle(fontFamily: fontFamily, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: 0),
    displaySmall: TextStyle(fontFamily: fontFamily, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 0),
    headlineLarge: TextStyle(fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 0),
    headlineMedium: TextStyle(fontFamily: fontFamily, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0),
    headlineSmall: TextStyle(fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0),
    titleLarge: TextStyle(fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0),
    titleMedium: TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0),
    titleSmall: TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0),
    bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0),
    bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0),
    bodySmall: TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0),
    labelLarge: TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0),
    labelMedium: TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0),
    labelSmall: TextStyle(fontFamily: fontFamily, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0),
  );
}
