// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:stacked/stacked.dart' as _i8;
import 'package:stacked_services/stacked_services.dart' as _i7;

import '../ui/shared/src/success/success_view.dart' as _i6;
import '../ui/views/auth/login/login_view.dart' as _i4;
import '../ui/views/auth/signup/signup_view.dart' as _i5;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/onboarding/onboarding_view.dart' as _i3;
import '../ui/views/startup/startup_view.dart' as _i2;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i7.StackedService.navigatorKey);

class StackedRouterWeb extends _i8.RootStackRouter {
  StackedRouterWeb({_i9.GlobalKey<_i9.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        opaque: true,
      );
    },
    StartupViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.StartupView(),
        opaque: true,
      );
    },
    OnboardingViewRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingViewArgs>(
          orElse: () => const OnboardingViewArgs());
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.OnboardingView(
          key: args.key,
          stopAnimation: args.stopAnimation,
        ),
        opaque: true,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginView(),
        opaque: true,
      );
    },
    SignupViewRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignupView(),
        opaque: true,
      );
    },
    SuccessViewRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessViewArgs>();
      return _i8.AdaptivePage<dynamic>(
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
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i8.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          OnboardingViewRoute.name,
          path: '/onboarding-view',
        ),
        _i8.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i8.RouteConfig(
          SignupViewRoute.name,
          path: '/signup-view',
        ),
        _i8.RouteConfig(
          SuccessViewRoute.name,
          path: '/success-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i8.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i8.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i3.OnboardingView]
class OnboardingViewRoute extends _i8.PageRouteInfo<OnboardingViewArgs> {
  OnboardingViewRoute({
    _i9.Key? key,
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

  final _i9.Key? key;

  final bool stopAnimation;

  @override
  String toString() {
    return 'OnboardingViewArgs{key: $key, stopAnimation: $stopAnimation}';
  }
}

/// generated route for
/// [_i4.LoginView]
class LoginViewRoute extends _i8.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i5.SignupView]
class SignupViewRoute extends _i8.PageRouteInfo<void> {
  const SignupViewRoute()
      : super(
          SignupViewRoute.name,
          path: '/signup-view',
        );

  static const String name = 'SignupView';
}

/// generated route for
/// [_i6.SuccessView]
class SuccessViewRoute extends _i8.PageRouteInfo<SuccessViewArgs> {
  SuccessViewRoute({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i9.Key? key,
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

  final _i9.Key? key;

  @override
  String toString() {
    return 'SuccessViewArgs{onProceed: $onProceed, iconPath: $iconPath, title: $title, body: $body, buttonLabel: $buttonLabel, key: $key}';
  }
}

extension RouterStateExtension on _i7.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToStartupView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingView({
    _i9.Key? key,
    bool stopAnimation = false,
    void Function(_i8.NavigationFailure)? onFailure,
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
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignupView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
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
    _i9.Key? key,
    void Function(_i8.NavigationFailure)? onFailure,
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

  Future<dynamic> replaceWithHomeView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingView({
    _i9.Key? key,
    bool stopAnimation = false,
    void Function(_i8.NavigationFailure)? onFailure,
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
      {void Function(_i8.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignupView(
      {void Function(_i8.NavigationFailure)? onFailure}) async {
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
    _i9.Key? key,
    void Function(_i8.NavigationFailure)? onFailure,
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
}
