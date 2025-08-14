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

  /// `Proceed`
  String get generalProceed {
    return Intl.message(
      'Proceed',
      name: 'generalProceed',
      desc: 'General Label for Primary Button',
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

  /// `SignUp`
  String get generalSignUp {
    return Intl.message(
      'SignUp',
      name: 'generalSignUp',
      desc: 'Text for the SignUp button',
      args: [],
    );
  }

  /// `Email Address`
  String get generalEmail {
    return Intl.message(
      'Email Address',
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

  /// `Required`
  String get generalRequired {
    return Intl.message(
      'Required',
      name: 'generalRequired',
      desc: 'Text for Required Label',
      args: [],
    );
  }

  /// `Enter your email address`
  String get generalEnterEmail {
    return Intl.message(
      'Enter your email address',
      name: 'generalEnterEmail',
      desc: 'Text for Enter your Email address Label',
      args: [],
    );
  }

  /// `A valid email address is required`
  String get generalValidEmail {
    return Intl.message(
      'A valid email address is required',
      name: 'generalValidEmail',
      desc: 'Text for Valid email address Label',
      args: [],
    );
  }

  /// `Enter your password`
  String get generalEnterPassword {
    return Intl.message(
      'Enter your password',
      name: 'generalEnterPassword',
      desc: 'Text for Enter your Password Label',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get generalValidPassword {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'generalValidPassword',
      desc: 'Text for Valid Password Label',
      args: [],
    );
  }

  /// `Use accurate location`
  String get generalUseAccurateLocation {
    return Intl.message(
      'Use accurate location',
      name: 'generalUseAccurateLocation',
      desc: 'Text for Use accurate location Label',
      args: [],
    );
  }

  /// `First name`
  String get generalFirstname {
    return Intl.message(
      'First name',
      name: 'generalFirstname',
      desc: 'Text for First name Label',
      args: [],
    );
  }

  /// `Last name`
  String get generalLastname {
    return Intl.message(
      'Last name',
      name: 'generalLastname',
      desc: 'Text for Last name Label',
      args: [],
    );
  }

  /// `Enter your first name`
  String get generalEnterFirstname {
    return Intl.message(
      'Enter your first name',
      name: 'generalEnterFirstname',
      desc: 'Text for Enter your last name',
      args: [],
    );
  }

  /// `Enter your last name`
  String get generalEnterLastname {
    return Intl.message(
      'Enter your last name',
      name: 'generalEnterLastname',
      desc: 'Text for Enter your last name',
      args: [],
    );
  }

  /// `Country`
  String get generalCountry {
    return Intl.message(
      'Country',
      name: 'generalCountry',
      desc: 'Text for Country Label',
      args: [],
    );
  }

  /// `State`
  String get generalState {
    return Intl.message(
      'State',
      name: 'generalState',
      desc: 'Text for State Label',
      args: [],
    );
  }

  /// `Select a country`
  String get generalSelectCountry {
    return Intl.message(
      'Select a country',
      name: 'generalSelectCountry',
      desc: 'Hint Text for Select a country',
      args: [],
    );
  }

  /// `Select a state`
  String get generalSelectState {
    return Intl.message(
      'Select a state',
      name: 'generalSelectState',
      desc: 'Hint Text for Select a state',
      args: [],
    );
  }

  /// `No results`
  String get generalNoResults {
    return Intl.message(
      'No results',
      name: 'generalNoResults',
      desc: 'Text for No results Label',
      args: [],
    );
  }

  /// `Search here`
  String get generalSearch {
    return Intl.message(
      'Search here',
      name: 'generalSearch',
      desc: 'Text for Search Label',
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
  String get featureOnboardingVoiceReport {
    return Intl.message(
      'Voice Your Report',
      name: 'featureOnboardingVoiceReport',
      desc: 'Title 1 for Onboarding Sets',
      args: [],
    );
  }

  /// `Civic24 allows you to speak up about pressing problems in your community and make your voice heard`
  String get featureOnboardingVoiceReportDesc {
    return Intl.message(
      'Civic24 allows you to speak up about pressing problems in your community and make your voice heard',
      name: 'featureOnboardingVoiceReportDesc',
      desc: 'Title Description 1 for Onboarding Sets',
      args: [],
    );
  }

  /// `Make Your Voice Count`
  String get featureOnboardingVoiceCount {
    return Intl.message(
      'Make Your Voice Count',
      name: 'featureOnboardingVoiceCount',
      desc: 'Title 2 for Onboarding Sets',
      args: [],
    );
  }

  /// `With Civic24, your thumbs up or down helps prioritize civic problems that matter most to the people around you`
  String get featureOnboardingVoiceCountDesc {
    return Intl.message(
      'With Civic24, your thumbs up or down helps prioritize civic problems that matter most to the people around you',
      name: 'featureOnboardingVoiceCountDesc',
      desc: 'Title Description 2 for Onboarding Sets',
      args: [],
    );
  }

  /// `Connect with Other Voices`
  String get featureOnboardingConnectVoice {
    return Intl.message(
      'Connect with Other Voices',
      name: 'featureOnboardingConnectVoice',
      desc: 'Title 2 for Onboarding Sets',
      args: [],
    );
  }

  /// `Civic24 provides a platform for you to engage with fellow citizens by expressing your opinion on civic issues`
  String get featureOnboardingConnectVoiceDesc {
    return Intl.message(
      'Civic24 provides a platform for you to engage with fellow citizens by expressing your opinion on civic issues',
      name: 'featureOnboardingConnectVoiceDesc',
      desc: 'Title Description 3 for Onboarding Sets',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get featureDontHaveAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'featureDontHaveAccount',
      desc: 'Don\'t have an account Description',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get featureLoginWelcome {
    return Intl.message(
      'Welcome Back!',
      name: 'featureLoginWelcome',
      desc: 'Login Welcome Description',
      args: [],
    );
  }

  /// `Log in to your account`
  String get featureLoginWelcomeHint {
    return Intl.message(
      'Log in to your account',
      name: 'featureLoginWelcomeHint',
      desc: 'Login Welcome Hint Description',
      args: [],
    );
  }

  /// `Already have an account?`
  String get featureAlreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'featureAlreadyHaveAnAccount',
      desc: 'Already Have An Account Description',
      args: [],
    );
  }

  /// `Create Account`
  String get featureSignUpCreateAccount {
    return Intl.message(
      'Create Account',
      name: 'featureSignUpCreateAccount',
      desc: 'SignUp Create Account Description',
      args: [],
    );
  }

  /// `Sign up to get started!`
  String get featureSignUpCreateAccountHint {
    return Intl.message(
      'Sign up to get started!',
      name: 'featureSignUpCreateAccountHint',
      desc: 'SignUp Create Account Hint Description',
      args: [],
    );
  }

  /// `Account Created`
  String get featureSignUpSuccess {
    return Intl.message(
      'Account Created',
      name: 'featureSignUpSuccess',
      desc: 'SignUp Success Description',
      args: [],
    );
  }

  /// `Get ready to explore the amazing features Civic24 has to offer.`
  String get featureSignUpSuccessHint {
    return Intl.message(
      'Get ready to explore the amazing features Civic24 has to offer.',
      name: 'featureSignUpSuccessHint',
      desc: 'SignUp Success Hint Description',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get featureForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'featureForgotPassword',
      desc: 'Forgot Password Description',
      args: [],
    );
  }

  /// `Complete Profile`
  String get featureCompleteProfile {
    return Intl.message(
      'Complete Profile',
      name: 'featureCompleteProfile',
      desc: 'Complete Profile Description',
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
