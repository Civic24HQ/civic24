// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Civic24`
  String get title {
    return Intl.message('Civic24', name: 'title', desc: 'Civic24', args: []);
  }

  /// `Home`
  String get pageHome {
    return Intl.message(
      'Home',
      name: 'pageHome',
      desc: 'Home page title',
      args: [],
    );
  }

  /// `Reports`
  String get pageReports {
    return Intl.message(
      'Reports',
      name: 'pageReports',
      desc: 'Reports page title',
      args: [],
    );
  }

  /// `Notifications`
  String get pageNotifications {
    return Intl.message(
      'Notifications',
      name: 'pageNotifications',
      desc: 'Notifications page title',
      args: [],
    );
  }

  /// `Settings`
  String get pageSettings {
    return Intl.message(
      'Settings',
      name: 'pageSettings',
      desc: 'Settings page title',
      args: [],
    );
  }

  /// `Click to Upload`
  String get generalClickToUpload {
    return Intl.message(
      'Click to Upload',
      name: 'generalClickToUpload',
      desc: 'Text for the upload button',
      args: [],
    );
  }

  /// `Supported: jpg, png, mp4 (max. 800x400px)`
  String get generalSupportedFormats {
    return Intl.message(
      'Supported: jpg, png, mp4 (max. 800x400px)',
      name: 'generalSupportedFormats',
      desc: 'Text for the supported file formats',
      args: [],
    );
  }

  /// `Continue with Google`
  String get generalContinueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'generalContinueWithGoogle',
      desc: 'Text for the Google sign-in button',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get generalContinueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'generalContinueWithApple',
      desc: 'Text for the Apple sign-in button',
      args: [],
    );
  }

  /// `Login`
  String get generalLogin {
    return Intl.message(
      'Login',
      name: 'generalLogin',
      desc: 'Text for the login button',
      args: [],
    );
  }

  /// `Register`
  String get generalRegister {
    return Intl.message(
      'Register',
      name: 'generalRegister',
      desc: 'Text for the register button',
      args: [],
    );
  }

  /// `Email`
  String get generalEmail {
    return Intl.message(
      'Email',
      name: 'generalEmail',
      desc: 'Label for the email input field',
      args: [],
    );
  }

  /// `Password`
  String get generalPassword {
    return Intl.message(
      'Password',
      name: 'generalPassword',
      desc: 'Label for the password input field',
      args: [],
    );
  }

  /// `Confirm Password`
  String get generalConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'generalConfirmPassword',
      desc: 'Label for the confirm password input field',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get generalForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'generalForgotPassword',
      desc: 'Text for the forgot password link',
      args: [],
    );
  }

  /// `Enter your email`
  String get generalEmailHint {
    return Intl.message(
      'Enter your email',
      name: 'generalEmailHint',
      desc: 'Hint text for the email input field',
      args: [],
    );
  }

  /// `Get Started`
  String get featureonboardingGetStarted {
    return Intl.message(
      'Get Started',
      name: 'featureonboardingGetStarted',
      desc: 'Text for Onboarding Get Started Button',
      args: [],
    );
  }

  /// `Voice Your Report`
  String get featureonboardingVoiceReport {
    return Intl.message(
      'Voice Your Report',
      name: 'featureonboardingVoiceReport',
      desc: 'Title 1 for Onboarding Sets',
      args: [],
    );
  }

  /// `Civic24 allows you to speak up about pressing problems in your community and make your voice heard`
  String get featureonboardingVoiceReportDesc {
    return Intl.message(
      'Civic24 allows you to speak up about pressing problems in your community and make your voice heard',
      name: 'featureonboardingVoiceReportDesc',
      desc: 'Title Description 1 for Onboarding Sets',
      args: [],
    );
  }

  /// `Make Your Voice Count`
  String get featureonboardingVoiceCount {
    return Intl.message(
      'Make Your Voice Count',
      name: 'featureonboardingVoiceCount',
      desc: 'Title 2 for Onboarding Sets',
      args: [],
    );
  }

  /// `With Civic24, your thumbs up or down helps prioritize civic problems that matter most to the people around you`
  String get featureonboardingVoiceCountDesc {
    return Intl.message(
      'With Civic24, your thumbs up or down helps prioritize civic problems that matter most to the people around you',
      name: 'featureonboardingVoiceCountDesc',
      desc: 'Title Description 2 for Onboarding Sets',
      args: [],
    );
  }

  /// `Connect with Other Voices`
  String get featureonboardingConnectVoice {
    return Intl.message(
      'Connect with Other Voices',
      name: 'featureonboardingConnectVoice',
      desc: 'Title 2 for Onboarding Sets',
      args: [],
    );
  }

  /// `Civic24 provides a platform for you to engage with fellow citizens by expressing your opinion on civic issues`
  String get featureonboardingConnectVoiceDesc {
    return Intl.message(
      'Civic24 provides a platform for you to engage with fellow citizens by expressing your opinion on civic issues',
      name: 'featureonboardingConnectVoiceDesc',
      desc: 'Title Description 3 for Onboarding Sets',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
