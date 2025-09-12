import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.dart';
import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
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
  setupBottomSheetUi();
  setupDialogUi();
  runApp(const App());
}
