import 'package:admin/app/app.dart';
import 'package:admin/app/app.locator.dart';
import 'package:admin/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

Future<void> main() async {
  await _preLocatorSetup();
  await setupLocator(stackedRouter: stackedRouter);
  await _postLocatorSetup();
}

Future<void> _preLocatorSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preloadFirstLocale();
}

Future<void> _postLocatorSetup() async {
  runApp(const App());
}
