// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i20;
import 'package:stacked/stacked.dart' as _i19;
import 'package:stacked_services/stacked_services.dart' as _i18;

import '../ui/shared/src/success/success_view.dart' as _i6;
import '../ui/views/add_report/add_report_view.dart' as _i13;
import '../ui/views/auth/forgot_password/forgot_password_view.dart' as _i7;
import '../ui/views/auth/login/login_view.dart' as _i4;
import '../ui/views/auth/signup/signup_view.dart' as _i5;
import '../ui/views/complete_profile/complete_profile_view.dart' as _i8;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/main/main_view.dart' as _i9;
import '../ui/views/notification/notification_view.dart' as _i11;
import '../ui/views/onboarding/onboarding_view.dart' as _i3;
import '../ui/views/reports/reports_view.dart' as _i10;
import '../ui/views/settings/appearance_settings/appearance_settings_view.dart'
    as _i15;
import '../ui/views/settings/language_settings/language_settings_view.dart'
    as _i16;
import '../ui/views/settings/profile/profile_view.dart' as _i14;
import '../ui/views/settings/settings_view.dart' as _i12;
import '../ui/views/settings/signin_security/signin_security_view.dart' as _i17;
import '../ui/views/startup/startup_view.dart' as _i2;

final stackedRouter = StackedRouterWeb(
  navigatorKey: _i18.StackedService.navigatorKey,
);

class StackedRouterWeb extends _i19.RootStackRouter {
  StackedRouterWeb({_i20.GlobalKey<_i20.NavigatorState>? navigatorKey})
    : super(navigatorKey);

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      final args = routeData.argsAs<HomeViewArgs>(
        orElse: () => const HomeViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(key: args.key),
        opaque: true,
      );
    },
    StartupViewRoute.name: (routeData) {
      final args = routeData.argsAs<StartupViewArgs>(
        orElse: () => const StartupViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.StartupView(key: args.key),
        opaque: true,
      );
    },
    OnboardingViewRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingViewArgs>(
        orElse: () => const OnboardingViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.OnboardingView(
          key: args.key,
          stopAnimation: args.stopAnimation,
        ),
        opaque: true,
      );
    },
    LoginViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginViewArgs>(
        orElse: () => const LoginViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginView(key: args.key),
        opaque: true,
      );
    },
    SignupViewRoute.name: (routeData) {
      final args = routeData.argsAs<SignupViewArgs>(
        orElse: () => const SignupViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i5.SignupView(key: args.key),
        opaque: true,
      );
    },
    SuccessViewRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessViewArgs>();
      return _i19.AdaptivePage<dynamic>(
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
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.ForgotPasswordView(args.email, key: args.key),
        opaque: true,
      );
    },
    CompleteProfileViewRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteProfileViewArgs>(
        orElse: () => const CompleteProfileViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.CompleteProfileView(key: args.key),
        opaque: true,
      );
    },
    MainViewRoute.name: (routeData) {
      final args = routeData.argsAs<MainViewArgs>(
        orElse: () => const MainViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.MainView(key: args.key, initialIndex: args.initialIndex),
        opaque: true,
      );
    },
    ReportsViewRoute.name: (routeData) {
      final args = routeData.argsAs<ReportsViewArgs>(
        orElse: () => const ReportsViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i10.ReportsView(key: args.key),
        opaque: true,
      );
    },
    NotificationViewRoute.name: (routeData) {
      final args = routeData.argsAs<NotificationViewArgs>(
        orElse: () => const NotificationViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i11.NotificationView(key: args.key),
        opaque: true,
      );
    },
    SettingsViewRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsViewArgs>(
        orElse: () => const SettingsViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i12.SettingsView(key: args.key),
        opaque: true,
      );
    },
    AddReportViewRoute.name: (routeData) {
      final args = routeData.argsAs<AddReportViewArgs>(
        orElse: () => const AddReportViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i13.AddReportView(currentStep: args.currentStep, key: args.key),
        opaque: true,
      );
    },
    ProfileViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileViewArgs>(
        orElse: () => const ProfileViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i14.ProfileView(key: args.key),
        opaque: true,
      );
    },
    AppearanceSettingsViewRoute.name: (routeData) {
      final args = routeData.argsAs<AppearanceSettingsViewArgs>(
        orElse: () => const AppearanceSettingsViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i15.AppearanceSettingsView(key: args.key),
        opaque: true,
      );
    },
    LanguageSettingsViewRoute.name: (routeData) {
      final args = routeData.argsAs<LanguageSettingsViewArgs>(
        orElse: () => const LanguageSettingsViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i16.LanguageSettingsView(key: args.key),
        opaque: true,
      );
    },
    SignInSecurityViewRoute.name: (routeData) {
      final args = routeData.argsAs<SignInSecurityViewArgs>(
        orElse: () => const SignInSecurityViewArgs(),
      );
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i17.SignInSecurityView(key: args.key),
        opaque: true,
      );
    },
  };

  @override
  List<_i19.RouteConfig> get routes => [
    _i19.RouteConfig(HomeViewRoute.name, path: '/home-view'),
    _i19.RouteConfig(StartupViewRoute.name, path: '/'),
    _i19.RouteConfig(OnboardingViewRoute.name, path: '/onboarding-view'),
    _i19.RouteConfig(LoginViewRoute.name, path: '/login-view'),
    _i19.RouteConfig(SignupViewRoute.name, path: '/signup-view'),
    _i19.RouteConfig(SuccessViewRoute.name, path: '/success-view'),
    _i19.RouteConfig(
      ForgotPasswordViewRoute.name,
      path: '/forgot-password-view',
    ),
    _i19.RouteConfig(
      CompleteProfileViewRoute.name,
      path: '/complete-profile-view',
    ),
    _i19.RouteConfig(MainViewRoute.name, path: '/main-view'),
    _i19.RouteConfig(ReportsViewRoute.name, path: '/reports-view'),
    _i19.RouteConfig(NotificationViewRoute.name, path: '/notification-view'),
    _i19.RouteConfig(SettingsViewRoute.name, path: '/settings-view'),
    _i19.RouteConfig(AddReportViewRoute.name, path: '/add-report-view'),
    _i19.RouteConfig(ProfileViewRoute.name, path: '/profile-view'),
    _i19.RouteConfig(
      AppearanceSettingsViewRoute.name,
      path: '/appearance-settings-view',
    ),
    _i19.RouteConfig(
      LanguageSettingsViewRoute.name,
      path: '/language-settings-view',
    ),
    _i19.RouteConfig(
      SignInSecurityViewRoute.name,
      path: '/sign-in-security-view',
    ),
  ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i19.PageRouteInfo<HomeViewArgs> {
  HomeViewRoute({_i20.Key? key})
    : super(
        HomeViewRoute.name,
        path: '/home-view',
        args: HomeViewArgs(key: key),
      );

  static const String name = 'HomeView';
}

class HomeViewArgs {
  const HomeViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i19.PageRouteInfo<StartupViewArgs> {
  StartupViewRoute({_i20.Key? key})
    : super(
        StartupViewRoute.name,
        path: '/',
        args: StartupViewArgs(key: key),
      );

  static const String name = 'StartupView';
}

class StartupViewArgs {
  const StartupViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'StartupViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.OnboardingView]
class OnboardingViewRoute extends _i19.PageRouteInfo<OnboardingViewArgs> {
  OnboardingViewRoute({_i20.Key? key, bool stopAnimation = false})
    : super(
        OnboardingViewRoute.name,
        path: '/onboarding-view',
        args: OnboardingViewArgs(key: key, stopAnimation: stopAnimation),
      );

  static const String name = 'OnboardingView';
}

class OnboardingViewArgs {
  const OnboardingViewArgs({this.key, this.stopAnimation = false});

  final _i20.Key? key;

  final bool stopAnimation;

  @override
  String toString() {
    return 'OnboardingViewArgs{key: $key, stopAnimation: $stopAnimation}';
  }
}

/// generated route for
/// [_i4.LoginView]
class LoginViewRoute extends _i19.PageRouteInfo<LoginViewArgs> {
  LoginViewRoute({_i20.Key? key})
    : super(
        LoginViewRoute.name,
        path: '/login-view',
        args: LoginViewArgs(key: key),
      );

  static const String name = 'LoginView';
}

class LoginViewArgs {
  const LoginViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'LoginViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.SignupView]
class SignupViewRoute extends _i19.PageRouteInfo<SignupViewArgs> {
  SignupViewRoute({_i20.Key? key})
    : super(
        SignupViewRoute.name,
        path: '/signup-view',
        args: SignupViewArgs(key: key),
      );

  static const String name = 'SignupView';
}

class SignupViewArgs {
  const SignupViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'SignupViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.SuccessView]
class SuccessViewRoute extends _i19.PageRouteInfo<SuccessViewArgs> {
  SuccessViewRoute({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i20.Key? key,
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

  final _i20.Key? key;

  @override
  String toString() {
    return 'SuccessViewArgs{onProceed: $onProceed, iconPath: $iconPath, title: $title, body: $body, buttonLabel: $buttonLabel, key: $key}';
  }
}

/// generated route for
/// [_i7.ForgotPasswordView]
class ForgotPasswordViewRoute
    extends _i19.PageRouteInfo<ForgotPasswordViewArgs> {
  ForgotPasswordViewRoute({required String email, _i20.Key? key})
    : super(
        ForgotPasswordViewRoute.name,
        path: '/forgot-password-view',
        args: ForgotPasswordViewArgs(email: email, key: key),
      );

  static const String name = 'ForgotPasswordView';
}

class ForgotPasswordViewArgs {
  const ForgotPasswordViewArgs({required this.email, this.key});

  final String email;

  final _i20.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordViewArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [_i8.CompleteProfileView]
class CompleteProfileViewRoute
    extends _i19.PageRouteInfo<CompleteProfileViewArgs> {
  CompleteProfileViewRoute({_i20.Key? key})
    : super(
        CompleteProfileViewRoute.name,
        path: '/complete-profile-view',
        args: CompleteProfileViewArgs(key: key),
      );

  static const String name = 'CompleteProfileView';
}

class CompleteProfileViewArgs {
  const CompleteProfileViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'CompleteProfileViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.MainView]
class MainViewRoute extends _i19.PageRouteInfo<MainViewArgs> {
  MainViewRoute({_i20.Key? key, int initialIndex = 0})
    : super(
        MainViewRoute.name,
        path: '/main-view',
        args: MainViewArgs(key: key, initialIndex: initialIndex),
      );

  static const String name = 'MainView';
}

class MainViewArgs {
  const MainViewArgs({this.key, this.initialIndex = 0});

  final _i20.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'MainViewArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i10.ReportsView]
class ReportsViewRoute extends _i19.PageRouteInfo<ReportsViewArgs> {
  ReportsViewRoute({_i20.Key? key})
    : super(
        ReportsViewRoute.name,
        path: '/reports-view',
        args: ReportsViewArgs(key: key),
      );

  static const String name = 'ReportsView';
}

class ReportsViewArgs {
  const ReportsViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'ReportsViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.NotificationView]
class NotificationViewRoute extends _i19.PageRouteInfo<NotificationViewArgs> {
  NotificationViewRoute({_i20.Key? key})
    : super(
        NotificationViewRoute.name,
        path: '/notification-view',
        args: NotificationViewArgs(key: key),
      );

  static const String name = 'NotificationView';
}

class NotificationViewArgs {
  const NotificationViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'NotificationViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.SettingsView]
class SettingsViewRoute extends _i19.PageRouteInfo<SettingsViewArgs> {
  SettingsViewRoute({_i20.Key? key})
    : super(
        SettingsViewRoute.name,
        path: '/settings-view',
        args: SettingsViewArgs(key: key),
      );

  static const String name = 'SettingsView';
}

class SettingsViewArgs {
  const SettingsViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'SettingsViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.AddReportView]
class AddReportViewRoute extends _i19.PageRouteInfo<AddReportViewArgs> {
  AddReportViewRoute({int currentStep = 1, _i20.Key? key})
    : super(
        AddReportViewRoute.name,
        path: '/add-report-view',
        args: AddReportViewArgs(currentStep: currentStep, key: key),
      );

  static const String name = 'AddReportView';
}

class AddReportViewArgs {
  const AddReportViewArgs({this.currentStep = 1, this.key});

  final int currentStep;

  final _i20.Key? key;

  @override
  String toString() {
    return 'AddReportViewArgs{currentStep: $currentStep, key: $key}';
  }
}

/// generated route for
/// [_i14.ProfileView]
class ProfileViewRoute extends _i19.PageRouteInfo<ProfileViewArgs> {
  ProfileViewRoute({_i20.Key? key})
    : super(
        ProfileViewRoute.name,
        path: '/profile-view',
        args: ProfileViewArgs(key: key),
      );

  static const String name = 'ProfileView';
}

class ProfileViewArgs {
  const ProfileViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'ProfileViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.AppearanceSettingsView]
class AppearanceSettingsViewRoute
    extends _i19.PageRouteInfo<AppearanceSettingsViewArgs> {
  AppearanceSettingsViewRoute({_i20.Key? key})
    : super(
        AppearanceSettingsViewRoute.name,
        path: '/appearance-settings-view',
        args: AppearanceSettingsViewArgs(key: key),
      );

  static const String name = 'AppearanceSettingsView';
}

class AppearanceSettingsViewArgs {
  const AppearanceSettingsViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'AppearanceSettingsViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.LanguageSettingsView]
class LanguageSettingsViewRoute
    extends _i19.PageRouteInfo<LanguageSettingsViewArgs> {
  LanguageSettingsViewRoute({_i20.Key? key})
    : super(
        LanguageSettingsViewRoute.name,
        path: '/language-settings-view',
        args: LanguageSettingsViewArgs(key: key),
      );

  static const String name = 'LanguageSettingsView';
}

class LanguageSettingsViewArgs {
  const LanguageSettingsViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'LanguageSettingsViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.SignInSecurityView]
class SignInSecurityViewRoute
    extends _i19.PageRouteInfo<SignInSecurityViewArgs> {
  SignInSecurityViewRoute({_i20.Key? key})
    : super(
        SignInSecurityViewRoute.name,
        path: '/sign-in-security-view',
        args: SignInSecurityViewArgs(key: key),
      );

  static const String name = 'SignInSecurityView';
}

class SignInSecurityViewArgs {
  const SignInSecurityViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'SignInSecurityViewArgs{key: $key}';
  }
}

extension RouterStateExtension on _i18.RouterService {
  Future<dynamic> navigateToHomeView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(HomeViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToStartupView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(StartupViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToOnboardingView({
    _i20.Key? key,
    bool stopAnimation = false,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      OnboardingViewRoute(key: key, stopAnimation: stopAnimation),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(LoginViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToSignupView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(SignupViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToSuccessView({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
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
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      ForgotPasswordViewRoute(email: email, key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCompleteProfileView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(CompleteProfileViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToMainView({
    _i20.Key? key,
    int initialIndex = 0,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      MainViewRoute(key: key, initialIndex: initialIndex),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToReportsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(ReportsViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToNotificationView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(NotificationViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToSettingsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(SettingsViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToAddReportView({
    int currentStep = 1,
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      AddReportViewRoute(currentStep: currentStep, key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(ProfileViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToAppearanceSettingsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      AppearanceSettingsViewRoute(key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLanguageSettingsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      LanguageSettingsViewRoute(key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignInSecurityView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(SignInSecurityViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithHomeView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(HomeViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithStartupView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(StartupViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithOnboardingView({
    _i20.Key? key,
    bool stopAnimation = false,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      OnboardingViewRoute(key: key, stopAnimation: stopAnimation),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(LoginViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithSignupView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(SignupViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithSuccessView({
    required void Function() onProceed,
    required String iconPath,
    required String title,
    required String body,
    required String buttonLabel,
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
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
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      ForgotPasswordViewRoute(email: email, key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCompleteProfileView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      CompleteProfileViewRoute(key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMainView({
    _i20.Key? key,
    int initialIndex = 0,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      MainViewRoute(key: key, initialIndex: initialIndex),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithReportsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(ReportsViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithNotificationView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(NotificationViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithSettingsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(SettingsViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithAddReportView({
    int currentStep = 1,
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      AddReportViewRoute(currentStep: currentStep, key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(ProfileViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithAppearanceSettingsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      AppearanceSettingsViewRoute(key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLanguageSettingsView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      LanguageSettingsViewRoute(key: key),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignInSecurityView({
    _i20.Key? key,
    void Function(_i19.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(SignInSecurityViewRoute(key: key), onFailure: onFailure);
  }
}
