import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:styles/styles.dart';

/// The [testableWidget] is a custom widget to wrap a widget in a MaterialApp with localization and theme.
/// This is useful for testing components in isolation with the correct context.
///
/// Usage:
/// ```dart
/// final widget = testableWidget(
///   const MyWidget(),
///   dark: true, // Set to true for dark mode
/// );
/// final builder = GoldenBuilder.column()
///   ..addScenario('MyWidget', widget);
/// ```
///
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
    home: Scaffold(body: Center(child: child)),
  );
}

/// The [customMaterialAppWrapper] is a custom version of `materialAppWrapper` compatible with GoldenToolkit.
/// Wraps a widget in your styled MaterialApp with localization and theme.
///
/// Usage:
/// ```dart
/// await tester.pumpDeviceBuilder(
///   builder,
///   wrapper: customMaterialAppWrapper(
///     dark: true, // Set to true for dark mode
///   ),
/// );
/// ```
Widget Function(Widget) customMaterialAppWrapper({bool dark = false}) {
  return (Widget child) => MaterialApp(
    title: 'Components Preview',
    theme: AppTheme.lightThemeData,
    darkTheme: AppTheme.darkThemeData,
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    locale: const Locale('en'),
    debugShowCheckedModeBanner: false,
    supportedLocales: appSupportedLocales,
    localizationsDelegates: appLocalizationsDelegates,
    home: Scaffold(body: child),
  );
}
