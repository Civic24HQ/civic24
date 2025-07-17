import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:styles/styles.dart';

Widget testableWidget(Widget child, {bool dark = false}) {
  return MaterialApp(
    title: 'Components Preview',
    theme: AppTheme.lightThemeData,
    darkTheme: AppTheme.darkThemeData,
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    locale: const Locale('en'),
    debugShowCheckedModeBanner: false,
    supportedLocales: appSupportedLocales,
    localizationsDelegates: appLocalizationsDelegates,
    home: child,
  );
}
