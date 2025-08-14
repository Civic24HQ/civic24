// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:stacked/stacked.dart' as _i10;
import 'package:stacked_services/stacked_services.dart' as _i9;

import '../ui/shared/src/success/success_view.dart' as _i6;
import '../ui/views/auth/forgot_password/forgot_password_view.dart' as _i7;
import '../ui/views/auth/login/login_view.dart' as _i4;
import '../ui/views/auth/signup/signup_view.dart' as _i5;
import '../ui/views/complete_profile/complete_profile_view.dart' as _i8;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/onboarding/onboarding_view.dart' as _i3;
import '../ui/views/startup/startup_view.dart' as _i2;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i9.StackedService.navigatorKey);

class StackedRouterWeb extends _i10.RootStackRouter {
  StackedRouterWeb({_i11.GlobalKey<_i11.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        opaque: true,
      );
    },
    StartupViewRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.StartupView(),
        opaque: true,
      );
    },
    OnboardingViewRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingViewArgs>(
          orElse: () => const OnboardingViewArgs());
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.OnboardingView(
          key: args.key,
          stopAnimation: args.stopAnimation,
        ),
        opaque: true,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginView(),
        opaque: true,
      );
    },
    SignupViewRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignupView(),
        opaque: true,
      );
    },
    SuccessViewRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessViewArgs>();
      return _i10.AdaptivePage<dynamic>(
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
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.ForgotPasswordView(
          args.email,
          key: args.key,
        ),
        opaque: true,
      );
    },
    CompleteProfileViewRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.CompleteProfileView(),
        opaque: true,
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i10.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          OnboardingViewRoute.name,
          path: '/onboarding-view',
        ),
        _i10.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i10.RouteConfig(
          SignupViewRoute.name,
          path: '/signup-view',
        ),
        _i10.RouteConfig(
          SuccessViewRoute.name,
          path: '/success-view',
        ),
        _i10.RouteConfig(
          ForgotPasswordViewRoute.name,
          path: '/forgot-password-view',
        ),
        _i10.RouteConfig(
          CompleteProfileViewRoute.name,
          path: '/complete-profile-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i10.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i10.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i3.OnboardingView]
class OnboardingViewRoute extends _i10.PageRouteInfo<OnboardingViewArgs> {
  OnboardingViewRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final bool stopAnimation;

  @override
  String toString() {
    return 'OnboardingViewArgs{key: $key, stopAnimation: $stopAnimation}';
  }
}

/// generated route for
/// [_i4.LoginView]
class LoginViewRoute extends _i10.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i5.SignupView]
class SignupViewRoute extends _i10.PageRouteInfo<void> {
  const SignupViewRoute()
      : super(
          SignupViewRoute.name,
          path: '/signup-view',
        );

  static const String name = 'SignupView';
}

/// generated route for
/// [_i6.SuccessView]
class SuccessViewRoute extends _i10.PageRouteInfo<SuccessViewArgs> {
  SuccessViewRoute({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i11.Key? key,
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

  final _i11.Key? key;

  @override
  String toString() {
    return 'SuccessViewArgs{onProceed: $onProceed, iconPath: $iconPath, title: $title, body: $body, buttonLabel: $buttonLabel, key: $key}';
  }
}

/// generated route for
/// [_i7.ForgotPasswordView]
class ForgotPasswordViewRoute
    extends _i10.PageRouteInfo<ForgotPasswordViewArgs> {
  ForgotPasswordViewRoute({
    required String email,
    _i11.Key? key,
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

  final _i11.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordViewArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [_i8.CompleteProfileView]
class CompleteProfileViewRoute extends _i10.PageRouteInfo<void> {
  const CompleteProfileViewRoute()
      : super(
          CompleteProfileViewRoute.name,
          path: '/complete-profile-view',
        );

  static const String name = 'CompleteProfileView';
}

extension RouterStateExtension on _i9.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToStartupView(
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingView({
    _i11.Key? key,
    bool stopAnimation = false,
    void Function(_i10.NavigationFailure)? onFailure,
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
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignupView(
      {void Function(_i10.NavigationFailure)? onFailure}) async {
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
    _i11.Key? key,
    void Function(_i10.NavigationFailure)? onFailure,
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
    _i11.Key? key,
    void Function(_i10.NavigationFailure)? onFailure,
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
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CompleteProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingView({
    _i11.Key? key,
    bool stopAnimation = false,
    void Function(_i10.NavigationFailure)? onFailure,
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
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignupView(
      {void Function(_i10.NavigationFailure)? onFailure}) async {
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
    _i11.Key? key,
    void Function(_i10.NavigationFailure)? onFailure,
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
    _i11.Key? key,
    void Function(_i10.NavigationFailure)? onFailure,
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
      {void Function(_i10.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CompleteProfileViewRoute(),
      onFailure: onFailure,
    );
  }
}
