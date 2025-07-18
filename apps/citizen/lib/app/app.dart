import 'dart:ui';

import 'package:citizen/app/app.router.dart';
import 'package:citizen/app_builder.dart';
import 'package:citizen/ui/views/home/home_view.dart';
import 'package:citizen/ui/views/startup/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';

// @stacked-import
@StackedApp(
  routes: [
    AdaptiveRoute(page: HomeView),
    AdaptiveRoute(page: StartupView, initial: true),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: RouterService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    // @stacked-service
  ],
  // dialogs: [
  //   // @stacked-dialog
  // ],
)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (displayPreferences) {
        return MaterialApp.router(
          title: l10n.title,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          themeMode: displayPreferences.themeMode,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          localizationsDelegates: appLocalizationsDelegates,
          locale: displayPreferences.locale,
          supportedLocales: appSupportedLocales,
          localeResolutionCallback: localeListResolutionCallback,
          routerDelegate: stackedRouter.delegate(),
          routeInformationParser: stackedRouter.defaultRouteParser(),
        );
      },
    );
  }
}
