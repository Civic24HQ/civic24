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

  /// `Continue`
  String get generalContinue {
    return Intl.message(
      'Continue',
      name: 'generalContinue',
      desc: 'Text for Continue button',
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

  /// `Upload File`
  String get generalUploadFile {
    return Intl.message(
      'Upload File',
      name: 'generalUploadFile',
      desc: 'Upload File Label for Button',
      args: [],
    );
  }

  /// `Take a picture`
  String get generalTakePicture {
    return Intl.message(
      'Take a picture',
      name: 'generalTakePicture',
      desc: 'Take picture Label for Button',
      args: [],
    );
  }

  /// `Save`
  String get generalSave {
    return Intl.message(
      'Save',
      name: 'generalSave',
      desc: 'Text for Save button',
      args: [],
    );
  }

  /// `Edit`
  String get generalEdit {
    return Intl.message(
      'Edit',
      name: 'generalEdit',
      desc: 'Text for Edit button',
      args: [],
    );
  }

  /// `Cancel`
  String get generalCancel {
    return Intl.message(
      'Cancel',
      name: 'generalCancel',
      desc: 'Text for Cancel button',
      args: [],
    );
  }

  /// `Delete Account`
  String get generalDeleteAccountButton {
    return Intl.message(
      'Delete Account',
      name: 'generalDeleteAccountButton',
      desc: 'Text for Delete Account button',
      args: [],
    );
  }

  /// `Proceed`
  String get generalProceed {
    return Intl.message(
      'Proceed',
      name: 'generalProceed',
      desc: 'General Label for Button',
      args: [],
    );
  }

  /// `Submit`
  String get generalSubmit {
    return Intl.message(
      'Submit',
      name: 'generalSubmit',
      desc: 'Submit Label for Button',
      args: [],
    );
  }

  /// `Previous`
  String get generalPrevious {
    return Intl.message(
      'Previous',
      name: 'generalPrevious',
      desc: 'Previous Label for Button',
      args: [],
    );
  }

  /// `Close`
  String get generalClose {
    return Intl.message(
      'Close',
      name: 'generalClose',
      desc: 'Text for the close button',
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

  /// `Reset password`
  String get generalResetPassword {
    return Intl.message(
      'Reset password',
      name: 'generalResetPassword',
      desc: 'Text for the reset password',
      args: [],
    );
  }

  /// `A password reset email has been sent to {emailValue}. Please check your inbox and follow the instructions to reset your password.`
  String generalResetPasswordDesc(Object emailValue) {
    return Intl.message(
      'A password reset email has been sent to $emailValue. Please check your inbox and follow the instructions to reset your password.',
      name: 'generalResetPasswordDesc',
      desc: 'Reset Password Description',
      args: [emailValue],
    );
  }

  /// `Open email app`
  String get generalResetPasswordButtonText {
    return Intl.message(
      'Open email app',
      name: 'generalResetPasswordButtonText',
      desc: 'Text for the reset password button',
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

  /// `Comments`
  String get generalComment {
    return Intl.message(
      'Comments',
      name: 'generalComment',
      desc: 'Text for Comment Label',
      args: [],
    );
  }

  /// `Add a comment`
  String get generalAddComment {
    return Intl.message(
      'Add a comment',
      name: 'generalAddComment',
      desc: 'Text for AddComment TextField',
      args: [],
    );
  }

  /// `All Issues`
  String get generalAllIssues {
    return Intl.message(
      'All Issues',
      name: 'generalAllIssues',
      desc: 'Text for All Issues TextField',
      args: [],
    );
  }

  /// `Trending`
  String get generalTrending {
    return Intl.message(
      'Trending',
      name: 'generalTrending',
      desc: 'Text for Trending TextField',
      args: [],
    );
  }

  /// `Category`
  String get generalCategory {
    return Intl.message(
      'Category',
      name: 'generalCategory',
      desc: 'Text for Category TextField',
      args: [],
    );
  }

  /// `Logout`
  String get generalLogout {
    return Intl.message(
      'Logout',
      name: 'generalLogout',
      desc: 'Text for Logout Label',
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

  /// `Begin a reset process by filling your Email Address`
  String get featureForgotPasswordHint {
    return Intl.message(
      'Begin a reset process by filling your Email Address',
      name: 'featureForgotPasswordHint',
      desc: 'Forgot Password Hint Description',
      args: [],
    );
  }

  /// `Go back to`
  String get featureForgotPasswordGoTo {
    return Intl.message(
      'Go back to',
      name: 'featureForgotPasswordGoTo',
      desc: 'Go back to description',
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

  /// `Road & Transport`
  String get featureCategoryTypeRoad {
    return Intl.message(
      'Road & Transport',
      name: 'featureCategoryTypeRoad',
      desc: 'Road & Transport Description',
      args: [],
    );
  }

  /// `Light & Electricity`
  String get featureCategoryTypeLight {
    return Intl.message(
      'Light & Electricity',
      name: 'featureCategoryTypeLight',
      desc: 'Light & Electricity Description',
      args: [],
    );
  }

  /// `Waste`
  String get featureCategoryTypeWaste {
    return Intl.message(
      'Waste',
      name: 'featureCategoryTypeWaste',
      desc: 'Environmental Hazards Description',
      args: [],
    );
  }

  /// `Abandoned Projects`
  String get featureCategoryTypeAbandoned {
    return Intl.message(
      'Abandoned Projects',
      name: 'featureCategoryTypeAbandoned',
      desc: 'Abandoned Projects Description',
      args: [],
    );
  }

  /// `Health & Sanitation`
  String get featureCategoryTypeHealth {
    return Intl.message(
      'Health & Sanitation',
      name: 'featureCategoryTypeHealth',
      desc: 'Health & Sanitation Description',
      args: [],
    );
  }

  /// `Security`
  String get featureCategoryTypeSecurity {
    return Intl.message(
      'Security',
      name: 'featureCategoryTypeSecurity',
      desc: 'Security Description',
      args: [],
    );
  }

  /// `Education`
  String get featureCategoryTypeEducation {
    return Intl.message(
      'Education',
      name: 'featureCategoryTypeEducation',
      desc: 'Education Description',
      args: [],
    );
  }

  /// `Governance`
  String get featureCategoryTypeGovernance {
    return Intl.message(
      'Governance',
      name: 'featureCategoryTypeGovernance',
      desc: 'Governance Description',
      args: [],
    );
  }

  /// `Zoning Violations`
  String get featureCategoryTypeUrban {
    return Intl.message(
      'Zoning Violations',
      name: 'featureCategoryTypeUrban',
      desc: 'Zoning Violations Description',
      args: [],
    );
  }

  /// `Road & Transport Issues`
  String get featureCategoryTypeDetailedRoad {
    return Intl.message(
      'Road & Transport Issues',
      name: 'featureCategoryTypeDetailedRoad',
      desc: 'Road & Transport Issues Description',
      args: [],
    );
  }

  /// `Light & Electricity Issues`
  String get featureCategoryTypeDetailedLight {
    return Intl.message(
      'Light & Electricity Issues',
      name: 'featureCategoryTypeDetailedLight',
      desc: 'Light & Electricity Issues Description',
      args: [],
    );
  }

  /// `Waste & Environmental Hazards`
  String get featureCategoryTypeDetailedWaste {
    return Intl.message(
      'Waste & Environmental Hazards',
      name: 'featureCategoryTypeDetailedWaste',
      desc: 'Environmental Hazards Description',
      args: [],
    );
  }

  /// `Abandoned & Incomplete Projects`
  String get featureCategoryTypeDetailedAbandoned {
    return Intl.message(
      'Abandoned & Incomplete Projects',
      name: 'featureCategoryTypeDetailedAbandoned',
      desc: 'Abandoned & Incomplete Projects Description',
      args: [],
    );
  }

  /// `Health & Sanitation`
  String get featureCategoryTypeDetailedHealth {
    return Intl.message(
      'Health & Sanitation',
      name: 'featureCategoryTypeDetailedHealth',
      desc: 'Health & Sanitation Description',
      args: [],
    );
  }

  /// `Security Issues`
  String get featureCategoryTypeDetailedSecurity {
    return Intl.message(
      'Security Issues',
      name: 'featureCategoryTypeDetailedSecurity',
      desc: 'Security Issues Description',
      args: [],
    );
  }

  /// `Education & Public Facilities`
  String get featureCategoryTypeDetailedEducation {
    return Intl.message(
      'Education & Public Facilities',
      name: 'featureCategoryTypeDetailedEducation',
      desc: 'Education & Public Facilities Description',
      args: [],
    );
  }

  /// `Governance`
  String get featureCategoryTypeDetailedGovernance {
    return Intl.message(
      'Governance',
      name: 'featureCategoryTypeDetailedGovernance',
      desc: 'Governance Description',
      args: [],
    );
  }

  /// `Urban Planning & Zoning Violations`
  String get featureCategoryTypeDetailedUrban {
    return Intl.message(
      'Urban Planning & Zoning Violations',
      name: 'featureCategoryTypeDetailedUrban',
      desc: 'Urban Planning & Zoning Violations Description',
      args: [],
    );
  }

  /// `Report potholes, bad roads, broken pedestrian paths, faulty traffic lights, or reckless driving in your area.`
  String get featureCategoryTypeRoadDescription {
    return Intl.message(
      'Report potholes, bad roads, broken pedestrian paths, faulty traffic lights, or reckless driving in your area.',
      name: 'featureCategoryTypeRoadDescription',
      desc: 'Road & Transport Description',
      args: [],
    );
  }

  /// `Report broken streetlights, exposed wires, or power outages affecting public spaces and safety.`
  String get featureCategoryTypeLightDescription {
    return Intl.message(
      'Report broken streetlights, exposed wires, or power outages affecting public spaces and safety.',
      name: 'featureCategoryTypeLightDescription',
      desc: 'Light & Electricity Description',
      args: [],
    );
  }

  /// `Report uncollected garbage, blocked drains, illegal dumping, or other environmental concerns.`
  String get featureCategoryTypeWasteDescription {
    return Intl.message(
      'Report uncollected garbage, blocked drains, illegal dumping, or other environmental concerns.',
      name: 'featureCategoryTypeWasteDescription',
      desc: 'Environmental Hazards Description',
      args: [],
    );
  }

  /// `Report incomplete or abandoned government/community projects left unattended in your locality. `
  String get featureCategoryTypeAbandonedDescription {
    return Intl.message(
      'Report incomplete or abandoned government/community projects left unattended in your locality. ',
      name: 'featureCategoryTypeAbandonedDescription',
      desc: 'Abandoned Projects Description',
      args: [],
    );
  }

  /// `Report filthy public toilets, poor sanitation at clinics, open sewage, or unsafe health conditions.`
  String get featureCategoryTypeHealthDescription {
    return Intl.message(
      'Report filthy public toilets, poor sanitation at clinics, open sewage, or unsafe health conditions.',
      name: 'featureCategoryTypeHealthDescription',
      desc: 'Health & Sanitation Description',
      args: [],
    );
  }

  /// `Report unsafe areas, broken security infrastructure, street harassment, or loitering zones.`
  String get featureCategoryTypeSecurityDescription {
    return Intl.message(
      'Report unsafe areas, broken security infrastructure, street harassment, or loitering zones.',
      name: 'featureCategoryTypeSecurityDescription',
      desc: 'Security Description',
      args: [],
    );
  }

  /// `Report rundown school buildings, locked community halls, or neglected libraries.`
  String get featureCategoryTypeEducationDescription {
    return Intl.message(
      'Report rundown school buildings, locked community halls, or neglected libraries.',
      name: 'featureCategoryTypeEducationDescription',
      desc: 'Education Description',
      args: [],
    );
  }

  /// `Raise issues like government delays, poor service delivery, corrupt practices, or misuse of public funds.`
  String get featureCategoryTypeGovernanceDescription {
    return Intl.message(
      'Raise issues like government delays, poor service delivery, corrupt practices, or misuse of public funds.',
      name: 'featureCategoryTypeGovernanceDescription',
      desc: 'Governance Description',
      args: [],
    );
  }

  /// `Report unapproved structures, noise pollution, land misuse, or zoning violations in your area.`
  String get featureCategoryTypeUrbanDescription {
    return Intl.message(
      'Report unapproved structures, noise pollution, land misuse, or zoning violations in your area.',
      name: 'featureCategoryTypeUrbanDescription',
      desc: 'Zoning Violations Description',
      args: [],
    );
  }

  /// `Select the category of the report`
  String get featureAddReportCategory {
    return Intl.message(
      'Select the category of the report',
      name: 'featureAddReportCategory',
      desc: 'Category Description',
      args: [],
    );
  }

  /// `Share the details of the civic issue`
  String get featureAddReportContent {
    return Intl.message(
      'Share the details of the civic issue',
      name: 'featureAddReportContent',
      desc: 'Content Description',
      args: [],
    );
  }

  /// `Share your thoughts`
  String get featureAddReportContentHint {
    return Intl.message(
      'Share your thoughts',
      name: 'featureAddReportContentHint',
      desc: 'Content Hint Description',
      args: [],
    );
  }

  /// `Kindly upload a clear image of your report`
  String get featureAddReportMedia {
    return Intl.message(
      'Kindly upload a clear image of your report',
      name: 'featureAddReportMedia',
      desc: 'Media Description',
      args: [],
    );
  }

  /// `Add a Report`
  String get featureAddReport {
    return Intl.message(
      'Add a Report',
      name: 'featureAddReport',
      desc: 'Add a Report Description',
      args: [],
    );
  }

  /// `Notifications`
  String get featureNotifications {
    return Intl.message(
      'Notifications',
      name: 'featureNotifications',
      desc: 'Notifications Description',
      args: [],
    );
  }

  /// `Mark all as read`
  String get featureNotificationInstruction {
    return Intl.message(
      'Mark all as read',
      name: 'featureNotificationInstruction',
      desc: 'Notification Instruction Description',
      args: [],
    );
  }

  /// `You do not have any notifications`
  String get featureNotificationEmpty {
    return Intl.message(
      'You do not have any notifications',
      name: 'featureNotificationEmpty',
      desc: 'Notification Empty Description',
      args: [],
    );
  }

  /// `Reports`
  String get featureReports {
    return Intl.message(
      'Reports',
      name: 'featureReports',
      desc: 'Reports Description',
      args: [],
    );
  }

  /// `My Reports`
  String get featureMyReports {
    return Intl.message(
      'My Reports',
      name: 'featureMyReports',
      desc: 'My Reports Description',
      args: [],
    );
  }

  /// `Bookmarked`
  String get featureBookmarkedReports {
    return Intl.message(
      'Bookmarked',
      name: 'featureBookmarkedReports',
      desc: 'Bookmarked Description',
      args: [],
    );
  }

  /// `Tap to {action}`
  String featureSettingsTooltip(Object action) {
    return Intl.message(
      'Tap to $action',
      name: 'featureSettingsTooltip',
      desc: 'Settings Tooltip Description',
      args: [action],
    );
  }

  /// `(v{version})`
  String featureSettingsVersion(Object version) {
    return Intl.message(
      '(v$version)',
      name: 'featureSettingsVersion',
      desc: 'Settings Version Description',
      args: [version],
    );
  }

  /// `Profile`
  String get featureSettingsProfile {
    return Intl.message(
      'Profile',
      name: 'featureSettingsProfile',
      desc: 'Profile Description',
      args: [],
    );
  }

  /// `Edit Profile`
  String get featureSettingsEditProfile {
    return Intl.message(
      'Edit Profile',
      name: 'featureSettingsEditProfile',
      desc: 'Edit Profile Description',
      args: [],
    );
  }

  /// `Your account email can’t be changed.`
  String get featureProfileAccountEmail {
    return Intl.message(
      'Your account email can’t be changed.',
      name: 'featureProfileAccountEmail',
      desc: 'Profile Account Email Description',
      args: [],
    );
  }

  /// `Language`
  String get featureSettingsLanguage {
    return Intl.message(
      'Language',
      name: 'featureSettingsLanguage',
      desc: 'Language Description',
      args: [],
    );
  }

  /// `Default Language`
  String get featureSettingsLanguageDefault {
    return Intl.message(
      'Default Language',
      name: 'featureSettingsLanguageDefault',
      desc: 'Default Language Description',
      args: [],
    );
  }

  /// `Appearance`
  String get featureSettingsAppearance {
    return Intl.message(
      'Appearance',
      name: 'featureSettingsAppearance',
      desc: 'Appearance Description',
      args: [],
    );
  }

  /// `Sign In & Security`
  String get featureSettingsSignInSecurity {
    return Intl.message(
      'Sign In & Security',
      name: 'featureSettingsSignInSecurity',
      desc: 'Sign In & Security Description',
      args: [],
    );
  }

  /// `System Settings`
  String get featureSettingsAppearanceSystem {
    return Intl.message(
      'System Settings',
      name: 'featureSettingsAppearanceSystem',
      desc: 'System Settings Description',
      args: [],
    );
  }

  /// `Light Mode`
  String get featureSettingsAppearanceLight {
    return Intl.message(
      'Light Mode',
      name: 'featureSettingsAppearanceLight',
      desc: 'Light Mode Description',
      args: [],
    );
  }

  /// `Dark Mode`
  String get featureSettingsAppearanceDark {
    return Intl.message(
      'Dark Mode',
      name: 'featureSettingsAppearanceDark',
      desc: 'Dark Mode Description',
      args: [],
    );
  }

  /// `Automatically adjust to your device appearance settings`
  String get featureSettingsAppearanceSystemDesc {
    return Intl.message(
      'Automatically adjust to your device appearance settings',
      name: 'featureSettingsAppearanceSystemDesc',
      desc: 'System Settings Description',
      args: [],
    );
  }

  /// `Keep the app in light mode`
  String get featureSettingsAppearanceLightDesc {
    return Intl.message(
      'Keep the app in light mode',
      name: 'featureSettingsAppearanceLightDesc',
      desc: 'Light Mode Description',
      args: [],
    );
  }

  /// `Keep the app in dark mode`
  String get featureSettingsAppearanceDarkDesc {
    return Intl.message(
      'Keep the app in dark mode',
      name: 'featureSettingsAppearanceDarkDesc',
      desc: 'Dark Mode Description',
      args: [],
    );
  }

  /// `Google`
  String get featureSettingsSecurityGoogle {
    return Intl.message(
      'Google',
      name: 'featureSettingsSecurityGoogle',
      desc: 'Google Sign-In Description',
      args: [],
    );
  }

  /// `Link your Google account for secure sign-in`
  String get featureSettingsSecurityGoogleUnlinkDesc {
    return Intl.message(
      'Link your Google account for secure sign-in',
      name: 'featureSettingsSecurityGoogleUnlinkDesc',
      desc: 'Google Sign-In Unlinked Description',
      args: [],
    );
  }

  /// `Your Google account is available for sign-in`
  String get featureSettingsSecurityGoogleLinkedDesc {
    return Intl.message(
      'Your Google account is available for sign-in',
      name: 'featureSettingsSecurityGoogleLinkedDesc',
      desc: 'Google Sign-In Linked Description',
      args: [],
    );
  }

  /// `Apple`
  String get featureSettingsSecurityApple {
    return Intl.message(
      'Apple',
      name: 'featureSettingsSecurityApple',
      desc: 'Apple Sign-In Description',
      args: [],
    );
  }

  /// `Link your Apple ID for secure sign-in`
  String get featureSettingsSecurityAppleUnlinkDesc {
    return Intl.message(
      'Link your Apple ID for secure sign-in',
      name: 'featureSettingsSecurityAppleUnlinkDesc',
      desc: 'Apple Sign-In Unlinked Description',
      args: [],
    );
  }

  /// `Your Apple ID is available for sign-in`
  String get featureSettingsSecurityAppleLinkedDesc {
    return Intl.message(
      'Your Apple ID is available for sign-in',
      name: 'featureSettingsSecurityAppleLinkedDesc',
      desc: 'Apple ID Linked Description',
      args: [],
    );
  }

  /// `Set Password`
  String get featureSettingsSecuritySetPassword {
    return Intl.message(
      'Set Password',
      name: 'featureSettingsSecuritySetPassword',
      desc: 'Set Password Description',
      args: [],
    );
  }

  /// `Enable email and password sign-in`
  String get featureSettingsSecuritySetPasswordDesc {
    return Intl.message(
      'Enable email and password sign-in',
      name: 'featureSettingsSecuritySetPasswordDesc',
      desc: 'Set Password Description',
      args: [],
    );
  }

  /// `Enter the email associated with your account`
  String get featureSettingsSecuritySetPasswordLabel {
    return Intl.message(
      'Enter the email associated with your account',
      name: 'featureSettingsSecuritySetPasswordLabel',
      desc: 'Set Password Label Description',
      args: [],
    );
  }

  /// `Change Password`
  String get featureSettingsSecurityResetPassword {
    return Intl.message(
      'Change Password',
      name: 'featureSettingsSecurityResetPassword',
      desc: 'Reset Password Description',
      args: [],
    );
  }

  /// `Update your existing password`
  String get featureSettingsSecurityResetPasswordDesc {
    return Intl.message(
      'Update your existing password',
      name: 'featureSettingsSecurityResetPasswordDesc',
      desc: 'Reset Password Description',
      args: [],
    );
  }

  /// `About`
  String get featureSettingsAbout {
    return Intl.message(
      'About',
      name: 'featureSettingsAbout',
      desc: 'About Description',
      args: [],
    );
  }

  /// `Loading`
  String get featureSettingsLoading {
    return Intl.message(
      'Loading',
      name: 'featureSettingsLoading',
      desc: 'Loading Description',
      args: [],
    );
  }

  /// `Logging out?`
  String get featureSettingsLoggingOut {
    return Intl.message(
      'Logging out?',
      name: 'featureSettingsLoggingOut',
      desc: 'Logging out Description',
      args: [],
    );
  }

  /// `Are you sure you want to log out from your account on this device?`
  String get featureSettingsLoggingOutHint {
    return Intl.message(
      'Are you sure you want to log out from your account on this device?',
      name: 'featureSettingsLoggingOutHint',
      desc: 'Logging out Hint Description',
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
