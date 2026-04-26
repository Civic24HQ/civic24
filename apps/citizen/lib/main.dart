import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.dart';
import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/bootstrap.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:services/services.dart';
import 'package:utils/utils.dart';

final _appInfoService = serviceLocator<AppInfoService>();
final _remoteConfigService = serviceLocator<RemoteConfigService>();
final _internetConnectivityService = serviceLocator<InternetConnectivityService>();

Future<void> main() async {
  await _preLocatorSetup();
  await setupLocator(stackedRouter: stackedRouter);
  await setupServiceLocator();
  registerServiceInterfaces();
  await _postLocatorSetup();
}

Future<void> _preLocatorSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await connectToFirebase();
  await setupLocalStorage();
  await PushNotificationService.initBackgroundMessage();
  setupLogOutputs([CrashlyticsOutput()]);
  await CrashlyticsService().setupFlutterErrorLogging();
  await preloadFirstLocale();
}

Future<void> _postLocatorSetup() async {
  setupBottomSheetUi();
  setupDialogUi();
  await _appInfoService.initialize();
  await _internetConnectivityService.initialize();
  await _remoteConfigService.initialize(
    minimumFetchInterval: EnvironmentConstants.isProduction ? const Duration(hours: 1) : const Duration(minutes: 1),
  );
  runApp(const App());
}
