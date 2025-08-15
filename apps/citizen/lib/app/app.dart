import 'dart:ui';

import 'package:citizen/app/app.router.dart';
import 'package:citizen/app_builder.dart';
import 'package:citizen/ui/shared/src/success/success_view.dart';
import 'package:citizen/ui/views/auth/forgot_password/forgot_password_view.dart';
import 'package:citizen/ui/views/auth/login/login_view.dart';
import 'package:citizen/ui/views/auth/signup/signup_view.dart';
import 'package:citizen/ui/views/complete_profile/complete_profile_view.dart';
import 'package:citizen/ui/views/home/home_view.dart';
import 'package:citizen/ui/views/main/main_view.dart';
import 'package:citizen/ui/views/notification/notification_view.dart';
import 'package:citizen/ui/views/onboarding/onboarding_view.dart';
import 'package:citizen/ui/views/reports/reports_view.dart';
import 'package:citizen/ui/views/settings/settings_view.dart';
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
    AdaptiveRoute(page: OnboardingView),
    AdaptiveRoute(page: LoginView),
    AdaptiveRoute(page: SignupView),
    AdaptiveRoute(page: SuccessView),
    AdaptiveRoute(page: ForgotPasswordView),
    AdaptiveRoute(page: CompleteProfileView),
    AdaptiveRoute(page: MainView),
    AdaptiveRoute(page: ReportsView),
    AdaptiveRoute(page: NotificationView),
    AdaptiveRoute(page: SettingsView),
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
