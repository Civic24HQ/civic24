// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i15;
import 'package:stacked/stacked.dart' as _i14;
import 'package:stacked_services/stacked_services.dart' as _i13;

import '../ui/shared/src/success/success_view.dart' as _i6;
import '../ui/views/auth/forgot_password/forgot_password_view.dart' as _i7;
import '../ui/views/auth/login/login_view.dart' as _i4;
import '../ui/views/auth/signup/signup_view.dart' as _i5;
import '../ui/views/complete_profile/complete_profile_view.dart' as _i8;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/main/main_view.dart' as _i9;
import '../ui/views/notification/notification_view.dart' as _i11;
import '../ui/views/onboarding/onboarding_view.dart' as _i3;
import '../ui/views/reports/reports_view.dart' as _i10;
import '../ui/views/settings/settings_view.dart' as _i12;
import '../ui/views/startup/startup_view.dart' as _i2;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i13.StackedService.navigatorKey);

class StackedRouterWeb extends _i14.RootStackRouter {
  StackedRouterWeb({_i15.GlobalKey<_i15.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        opaque: true,
      );
    },
    StartupViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.StartupView(),
        opaque: true,
      );
    },
    OnboardingViewRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingViewArgs>(
          orElse: () => const OnboardingViewArgs());
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.OnboardingView(
          key: args.key,
          stopAnimation: args.stopAnimation,
        ),
        opaque: true,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginView(),
        opaque: true,
      );
    },
    SignupViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignupView(),
        opaque: true,
      );
    },
    SuccessViewRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessViewArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.SuccessView(
          onProceed: args.onProceed,
          iconPath: args.iconPath,
          title: args.title,
          body: args.body,
          buttonLabel: args.buttonLabel,
          key: args.key,
        ),
        opaque: true,
      );
    },
    ForgotPasswordViewRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordViewArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.ForgotPasswordView(
          args.email,
          key: args.key,
        ),
        opaque: true,
      );
    },
    CompleteProfileViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.CompleteProfileView(),
        opaque: true,
      );
    },
    MainViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<MainViewArgs>(orElse: () => const MainViewArgs());
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.MainView(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
        opaque: true,
      );
    },
    ReportsViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.ReportsView(),
        opaque: true,
      );
    },
    NotificationViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.NotificationView(),
        opaque: true,
      );
    },
    SettingsViewRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.SettingsView(),
        opaque: true,
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i14.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i14.RouteConfig(
          OnboardingViewRoute.name,
          path: '/onboarding-view',
        ),
        _i14.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i14.RouteConfig(
          SignupViewRoute.name,
          path: '/signup-view',
        ),
        _i14.RouteConfig(
          SuccessViewRoute.name,
          path: '/success-view',
        ),
        _i14.RouteConfig(
          ForgotPasswordViewRoute.name,
          path: '/forgot-password-view',
        ),
        _i14.RouteConfig(
          CompleteProfileViewRoute.name,
          path: '/complete-profile-view',
        ),
        _i14.RouteConfig(
          MainViewRoute.name,
          path: '/main-view',
        ),
        _i14.RouteConfig(
          ReportsViewRoute.name,
          path: '/reports-view',
        ),
        _i14.RouteConfig(
          NotificationViewRoute.name,
          path: '/notification-view',
        ),
        _i14.RouteConfig(
          SettingsViewRoute.name,
          path: '/settings-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i14.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i14.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i3.OnboardingView]
class OnboardingViewRoute extends _i14.PageRouteInfo<OnboardingViewArgs> {
  OnboardingViewRoute({
    _i15.Key? key,
    bool stopAnimation = false,
  }) : super(
          OnboardingViewRoute.name,
          path: '/onboarding-view',
          args: OnboardingViewArgs(
            key: key,
            stopAnimation: stopAnimation,
          ),
        );

  static const String name = 'OnboardingView';
}

class OnboardingViewArgs {
  const OnboardingViewArgs({
    this.key,
    this.stopAnimation = false,
  });

  final _i15.Key? key;

  final bool stopAnimation;

  @override
  String toString() {
    return 'OnboardingViewArgs{key: $key, stopAnimation: $stopAnimation}';
  }
}

/// generated route for
/// [_i4.LoginView]
class LoginViewRoute extends _i14.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i5.SignupView]
class SignupViewRoute extends _i14.PageRouteInfo<void> {
  const SignupViewRoute()
      : super(
          SignupViewRoute.name,
          path: '/signup-view',
        );

  static const String name = 'SignupView';
}

/// generated route for
/// [_i6.SuccessView]
class SuccessViewRoute extends _i14.PageRouteInfo<SuccessViewArgs> {
  SuccessViewRoute({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i15.Key? key,
  }) : super(
          SuccessViewRoute.name,
          path: '/success-view',
          args: SuccessViewArgs(
            onProceed: onProceed,
            iconPath: iconPath,
            title: title,
            body: body,
            buttonLabel: buttonLabel,
            key: key,
          ),
        );

  static const String name = 'SuccessView';
}

class SuccessViewArgs {
  const SuccessViewArgs({
    required this.onProceed,
    required this.iconPath,
    required this.title,
    required this.body,
    required this.buttonLabel,
    this.key,
  });

  final void Function() onProceed;

  final String iconPath;

  final String title;

  final String body;

  final String buttonLabel;

  final _i15.Key? key;

  @override
  String toString() {
    return 'SuccessViewArgs{onProceed: $onProceed, iconPath: $iconPath, title: $title, body: $body, buttonLabel: $buttonLabel, key: $key}';
  }
}

/// generated route for
/// [_i7.ForgotPasswordView]
class ForgotPasswordViewRoute
    extends _i14.PageRouteInfo<ForgotPasswordViewArgs> {
  ForgotPasswordViewRoute({
    required String email,
    _i15.Key? key,
  }) : super(
          ForgotPasswordViewRoute.name,
          path: '/forgot-password-view',
          args: ForgotPasswordViewArgs(
            email: email,
            key: key,
          ),
        );

  static const String name = 'ForgotPasswordView';
}

class ForgotPasswordViewArgs {
  const ForgotPasswordViewArgs({
    required this.email,
    this.key,
  });

  final String email;

  final _i15.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordViewArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [_i8.CompleteProfileView]
class CompleteProfileViewRoute extends _i14.PageRouteInfo<void> {
  const CompleteProfileViewRoute()
      : super(
          CompleteProfileViewRoute.name,
          path: '/complete-profile-view',
        );

  static const String name = 'CompleteProfileView';
}

/// generated route for
/// [_i9.MainView]
class MainViewRoute extends _i14.PageRouteInfo<MainViewArgs> {
  MainViewRoute({
    _i15.Key? key,
    int initialIndex = 0,
  }) : super(
          MainViewRoute.name,
          path: '/main-view',
          args: MainViewArgs(
            key: key,
            initialIndex: initialIndex,
          ),
        );

  static const String name = 'MainView';
}

class MainViewArgs {
  const MainViewArgs({
    this.key,
    this.initialIndex = 0,
  });

  final _i15.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'MainViewArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i10.ReportsView]
class ReportsViewRoute extends _i14.PageRouteInfo<void> {
  const ReportsViewRoute()
      : super(
          ReportsViewRoute.name,
          path: '/reports-view',
        );

  static const String name = 'ReportsView';
}

/// generated route for
/// [_i11.NotificationView]
class NotificationViewRoute extends _i14.PageRouteInfo<void> {
  const NotificationViewRoute()
      : super(
          NotificationViewRoute.name,
          path: '/notification-view',
        );

  static const String name = 'NotificationView';
}

/// generated route for
/// [_i12.SettingsView]
class SettingsViewRoute extends _i14.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(
          SettingsViewRoute.name,
          path: '/settings-view',
        );

  static const String name = 'SettingsView';
}

extension RouterStateExtension on _i13.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToStartupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingView({
    _i15.Key? key,
    bool stopAnimation = false,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      OnboardingViewRoute(
        key: key,
        stopAnimation: stopAnimation,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SignupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSuccessView({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i15.Key? key,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      SuccessViewRoute(
        onProceed: onProceed,
        iconPath: iconPath,
        title: title,
        body: body,
        buttonLabel: buttonLabel,
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToForgotPasswordView({
    required String email,
    _i15.Key? key,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      ForgotPasswordViewRoute(
        email: email,
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCompleteProfileView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CompleteProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMainView({
    _i15.Key? key,
    int initialIndex = 0,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      MainViewRoute(
        key: key,
        initialIndex: initialIndex,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToReportsView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ReportsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToNotificationView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const NotificationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSettingsView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SettingsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingView({
    _i15.Key? key,
    bool stopAnimation = false,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      OnboardingViewRoute(
        key: key,
        stopAnimation: stopAnimation,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SignupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSuccessView({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i15.Key? key,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      SuccessViewRoute(
        onProceed: onProceed,
        iconPath: iconPath,
        title: title,
        body: body,
        buttonLabel: buttonLabel,
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithForgotPasswordView({
    required String email,
    _i15.Key? key,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      ForgotPasswordViewRoute(
        email: email,
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCompleteProfileView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CompleteProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMainView({
    _i15.Key? key,
    int initialIndex = 0,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      MainViewRoute(
        key: key,
        initialIndex: initialIndex,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithReportsView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ReportsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithNotificationView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const NotificationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSettingsView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SettingsViewRoute(),
      onFailure: onFailure,
    );
  }
}
