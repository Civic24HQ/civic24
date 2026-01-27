import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:android_intent_plus/android_intent.dart';
import 'package:constants/constants.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:services/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:utils/utils.dart';

enum AuthState {
  /// Waiting for authentication
  idle,

  /// User is authenticated
  authenticated,

  /// User is not authenticated
  unauthenticated,
}

/// An observer to track authentication state changes.
/// Implement this class to listen for user authentication events.
///
/// Example:
/// ```dart
/// class AuthObserverImpl with AuthObserver {
///   @override
///   void onAuthenticated(User user) {
///     print('User authenticated: \\${user.displayName}');
///   }
///
///   @override
///   void onUnauthenticated() {
///     print('User unauthenticated');
///   }
/// }
/// ```
mixin AuthObserver {
  @protected
  void onAuthenticated(User user) {}

  @protected
  void onUnauthenticated() {}
}

/// Handles user authentication using Firebase.
/// Provides methods for signing in, signing up, and managing user sessions.
class AuthenticationService {
  AuthenticationService() {
    initialize();
  }
  final _log = getLogger('AuthenticationService');
  final _googleSignIn = GoogleSignIn.instance;
  final _alertService = serviceLocator<AlertService>();
  final _firebaseAuth = FirebaseAuth.instance;
  final _settingsStorageService = serviceLocator<SettingsStorageService>();
  final _analyticsService = serviceLocator<AnalyticsService>();
  final _crashlyticsService = serviceLocator<CrashlyticsService>();

  final Random _randomSecure = Random.secure();

  /// Returns the current authenticated user.
  User? get firebaseUser => _firebaseAuth.currentUser;

  /// Returns the user's display name.
  ///
  /// If the user is not authenticated, this will return `null`.
  ({String? firstName, String? lastName}) get userName {
    final displayName = firebaseUser?.displayName;
    _log.d('Retrieving user name: $displayName');
    if (displayName == null || displayName.isEmpty) {
      _log.w('Display name is empty or null');
      return (firstName: '', lastName: '');
    }

    if (displayName == 'null null') {
      _log.w('Display name is "null null"');
      return (firstName: '', lastName: '');
    }

    // Split the display name into first and last names.
    final names = displayName.split(' ');
    if (names.length < 2) {
      _log.w('Display name does not contain both first and last names');
      return (firstName: names.first, lastName: '');
    }
    return (firstName: names.first, lastName: names.length > 1 ? names.last : '');
  }

  // Returns the google sign in initialization status.
  bool _isGoogleSignInInitialized = false;

  /// Returns whether a user is currently authenticated.
  bool get hasFirebaseUser => _firebaseAuth.currentUser != null;

  bool _isAppleSignInAvailable = true;
  bool get isAppleSignInAvailable => _isAppleSignInAvailable;

  final BehaviorSubject<AuthState> _authenticatedSubject = BehaviorSubject<AuthState>.seeded(AuthState.idle);
  Stream<AuthState> get authenticatedStream => _authenticatedSubject.stream.distinct();

  final List<AuthObserver> _observers = [];

  final List<String> _scopes = ['email', 'profile', 'https://www.googleapis.com/auth/drive.file'];

  String get currentUserAuthProvider {
    final providerInfo = _firebaseAuth.currentUser?.providerData;
    if (providerInfo != null) {
      for (final provider in providerInfo) {
        switch (provider.providerId) {
          case 'google.com':
            return 'Google';
          case 'apple.com':
            return 'Apple';
          case 'password':
            return 'Email/Password';
        }
      }
    }
    return 'Unknown';
  }

  bool get isProviderGoogle => currentUserAuthProvider == 'Google';
  bool get isProviderApple => currentUserAuthProvider == 'Apple';
  bool get isProviderEmail => currentUserAuthProvider == 'Email/Password';

  void setAuthStateToIdle() {
    _log.d('Setting authentication state to idle');
    _authenticatedSubject.add(AuthState.idle);
  }

  /// Initializes authentication state listener.
  Future<void> initialize() async {
    _isAppleSignInAvailable = await canSignInWithApple;
    _log.d('Sign in with Apple available: $_isAppleSignInAvailable');

    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      _log.d('Authentication state changed: \\${firebaseUser?.uid}');

      if (firebaseUser == null) {
        _log.w('User is not authenticated');
        _authenticatedSubject.add(AuthState.unauthenticated);
        for (final observer in _observers) {
          observer.onUnauthenticated();
        }
        return;
      }

      _log.i('User is authenticated: \\${firebaseUser.uid}');
      _authenticatedSubject.add(AuthState.authenticated);
      for (final observer in _observers) {
        observer.onAuthenticated(firebaseUser);
      }
    });
    await initializeGoogleSignIn();
  }

  Future<void> initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize(serverClientId: EnvironmentConstants.webClientId);
      _isGoogleSignInInitialized = true;
      _log.i('Initialized Google Sign-In successfully');
    } catch (e) {
      _log.i('Failed to initialize Google Sign-In: $e');
    }
  }

  /// Always check Google sign in initialization before use
  Future<void> ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await initializeGoogleSignIn();
    }
  }

  /// Work around for user iOS/MacOS persistence issue i.e.
  /// A user is still logged in from previous session even after a reinstall.
  ///
  /// https://github.com/firebase/flutterfire/pull/4671
  Future<void> clearFirebaseUserOnFreshInstall() async {
    if (kIsWeb || isAndroid) return;

    final freshInstall = _settingsStorageService.freshInstall;
    _log.d('Is this a fresh install? $freshInstall');

    if (freshInstall) {
      _log.i('Signing out the user from the previous session');
      await signOut();
      // Immediately update local state as a fallback:
      _authenticatedSubject.add(AuthState.unauthenticated);
      for (final observer in _observers) {
        observer.onUnauthenticated();
      }

      _settingsStorageService.setFreshInstall();
    } else {
      _log.d('This is not a fresh install');
    }
  }

  /// Opens the add account settings on Android devices to allows users to add new accounts to their device.
  Future<void> openAddAccountSettings() async {
    if (!isAndroid) return;

    try {
      const intent = AndroidIntent(action: 'android.settings.ADD_ACCOUNT_SETTINGS');
      await intent.launch();
    } catch (e) {
      _log.w('Failed to open add account settings: $e');
    }
  }

  /// Checks if the Google Sign-In error is due to no credentials found.
  bool _isNoCredentialError(dynamic e) {
    final message = e.toString().toLowerCase();
    return message.contains('no credential') ||
        message.contains('no credentials') ||
        message.contains('no credentials found') ||
        message.contains('no credential found');
  }

  /// Adds an observer to track authentication changes.
  void addObserver(AuthObserver observer) {
    _log.d('Adding AuthObserver(${shortHash(observer)})');
    if (!_observers.contains(observer)) {
      _observers.add(observer);
    }
  }

  /// Removes an observer from tracking authentication changes.
  void removeObserver(AuthObserver observer) {
    _log.d('Removing AuthObserver(${shortHash(observer)})');
    _observers.remove(observer);
  }

  /// Updates the user's display name.
  Future<void> updateDisplayName(String displayName) async {
    _log.i('Updating display name to $displayName');

    if (firebaseUser == null) {
      _log.w('No authenticated user found');
      return;
    }
    await _firebaseAuth.currentUser?.updateDisplayName(displayName);
  }

  /// Registers a new user with email and password.
  ///
  /// Returns `true` if the user was successfully created.
  Future<bool> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      _log.d('Creating user account');
      final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _analyticsService.logSignUp(currentUserAuthProvider);
      _crashlyticsService.setupUserProfile(userId: result.user?.uid, email: result.user?.email);
      _log.i('User Details: ${result.user}');
      // _alertService.showSuccessAlert(title: l10n.featureSignUpSuccess, message: l10n.featureSignUpSuccessHint);
      return result.user != null;
    } catch (e) {
      _log.e('Sign up failed: $e');
      _alertService.showErrorAlert(title: 'Sign Up Failed', message: exceptionToMessage(e));
      return false;
    }
  }

  /// Signs in a user with email and password.
  ///
  /// Returns `true` if the user was successfully signed in.
  Future<bool> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      _log.d('Signing in with email and password');
      final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _analyticsService.logLogin(currentUserAuthProvider);
      _crashlyticsService.setupUserProfile(userId: result.user?.uid, email: result.user?.email);
      _log.i('User Details: ${result.user}');
      return result.user != null;
    } catch (e) {
      _log.e('Sign in failed: $e');
      _alertService.showErrorAlert(title: 'Login Failed', message: exceptionToMessage(e));
      return false;
    }
  }

  /// Authenticates a user with Google.
  /// If the user is not signed in, the user will be prompted to sign in.
  /// If the user is already signed in, the user will be silently signed in.
  ///
  /// Returns `true` if the user was successfully authenticated.
  Future<bool> continueWithGoogle() async {
    // Ensure Google Sign-In is initialized before the authentication process
    await ensureGoogleSignInInitialized();
    try {
      _log.i('Authenticating with Google');

      // Authenticate with Google to handle both sign-in and silent sign-in
      final restored = await _googleSignIn.attemptLightweightAuthentication();

      final googleUser = (restored is Future<GoogleSignInAccount?>)
          ? restored
          : await _googleSignIn.authenticate(
              scopeHint: _scopes, // Specify required scopes
            );

      _log.d('googleUser $googleUser');

      if (googleUser == null) {
        _log.d('Google authentication aborted');
        _alertService.showToast('Continue with Google aborted');
        return false;
      }

      // Get authorization for Firebase scopes if needed
      final authClient = _googleSignIn.authorizationClient;

      // Try to get existing authorization
      var authorization = await authClient.authorizationForScopes(_scopes);

      if (authorization == null) {
        // Request authorization if not already granted
        _log.d('Requesting additional authorization for scopes: $_scopes');
        authorization = await authClient.authorizeScopes(_scopes);
      }

      // Update Authentication Token Access
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
        idToken: googleAuth.idToken,
      );
      _log.d('Google authentication successful');
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      _log.d('Firebase authentication successful');

      final signUp = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (signUp) {
        _log.d('User signed up with Google');
        _analyticsService.logSignUp(currentUserAuthProvider);
      } else {
        _log.d('User logged in with Google');
        _analyticsService.logLogin(currentUserAuthProvider);
      }

      _crashlyticsService.setupUserProfile(userId: userCredential.user?.uid, email: userCredential.user?.email);

      return userCredential.user != null;
    } on GoogleSignInException catch (e) {
      if (isAndroid && _isNoCredentialError(e)) {
        _log.w('No Google credentials found on device. Opening add account settings.');
        await openAddAccountSettings();
        return false;
      }

      _alertService.showErrorAlert(title: 'Google Sign In Failed', message: googleSignInExceptionToMessage(e));
      _log
        ..i(googleSignInExceptionToMessage(e))
        ..i('Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}', error: e);
      rethrow;
    } catch (e) {
      if (isAndroid && _isNoCredentialError(e)) {
        _log.w('No Google credentials found on device. Opening add account settings.');
        await openAddAccountSettings();
        return false;
      }

      _log.e('Google Auth Failed: $e');
      _alertService.showErrorAlert(title: 'Google Sign In Failed', message: exceptionToMessage(e));
      rethrow;
    }

  }

  /// Checks if Sign in with Apple is available on the current platform.
  /// This method returns `true` if Sign in with Apple is available.
  @visibleForTesting
  Future<bool> get canSignInWithApple async {
    final result = await (kIsWeb || isTest ? Future.value(true) : SignInWithApple.isAvailable());
    return result;
  }

  @visibleForTesting
  String sha256HashNonce(String nonce) {
    final bytes = utf8.encode(nonce);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Auth0 Docs:
  /// https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
  @visibleForTesting
  String nonceString(int length, [Random? randomSecure]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final buffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      final index = (randomSecure ?? _randomSecure).nextInt(charset.length);
      buffer.write(charset[index]);
    }

    return buffer.toString();
  }

  /// Authenticates a user with Apple.
  /// If the user is not signed in, the user will be prompted to sign in.
  /// If the user is already signed in, the user will be silently signed in.
  ///
  /// Returns `true` if the user was successfully authenticated.
  Future<bool> continueWithApple() async {
    _log.d('Continue With Apple');
    return false;
  }

  /// Signs out the current user.
  ///
  /// This method will also disconnect the user from Google
  /// if they are authenticated with Google.
  Future<void> signOut() async {
    _log.d('Signing out user');
    try {
      // Try to check if user is currently signed In
      final isUserSignedIn = await _googleSignIn.attemptLightweightAuthentication();

      if (isUserSignedIn is Future<GoogleSignInAccount?>) {
        _log.d('Signing out Google user');
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }

      await Future.wait([
        _analyticsService.setUserId(null),
        _analyticsService.setUserProperty(name: 'guest'),
        _crashlyticsService.setUserIdToCrashlytics(''),
        _crashlyticsService.setUserEmailToCrashlytics(''),
      ]);
    } catch (e) {
      _log.e('Error signing out: $e');
    } finally {
      await _firebaseAuth.signOut();
      _log.d('User signed out from Firebase');
      clearLocalStorage();
      _log.d('Local storage cleared');
    }
  }

  /// Sends a password reset email.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      _log.d('Sending password reset email to $email');
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      _log.e('Password reset email failed: $e');
      _alertService.showErrorAlert(title: 'Password Reset Failed', message: exceptionToMessage(e));
    }
  }

  /// Reauthenticates the user with email and password before
  /// performing sensitive actions.
  Future<bool> reauthenticateUser({required String password}) async {
    try {
      _log.d('Attempting to reauthenticate with email and password');

      if (firebaseUser == null) {
        _log.w('No authenticated user found');
        return false;
      }

      final credential = EmailAuthProvider.credential(email: firebaseUser!.email!, password: password);
      final result = await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
      return result.user != null;
    } catch (e) {
      _log.e('Reauthentication failed: $e');
      _alertService.showErrorAlert(title: 'Reauthentication Failed', message: exceptionToMessage(e));
      return false;
    }
  }

  /// Reauthenticates the user with other providers before
  /// performing sensitive actions.
  Future<void> reauthenticateUserWithProvider() async {
    _log.i('Reauthenticate User With Provider');
  }

  /// Deletes the current user account and signs them out.
  Future<void> deleteAccount() async {
    _log.d('Deleting user account');
  }

  @protected
  String exceptionToMessage([dynamic exception]) {
    if (exception is FirebaseAuthException) {
      switch (exception.code) {
        case 'invalid-email':
          return 'The email you entered is invalid. Please check if you have '
              'entered it correctly.';
        case 'wrong-password':
          return 'The password you entered is incorrect.';
        case 'user-not-found':
        case 'EMAIL_EXISTS':
        case 'INVALID_LOGIN_CREDENTIALS':
          return 'Sorry, we could not find an account with this email address. '
              'Try signing up instead.';
        case 'weak-password':
          return 'Your password is too weak. It should be at least 8 character, '
              'however the strongest passwords have 12 or more characters.';
        case 'email-already-in-use':
          return 'This email belongs to another current user. If that is you, '
              'please sign in using that email instead.';
        case 'invalid-credential':
          return 'The credential used to authenticate this user is invalid. '
              'Please try again.';
        case 'user-disabled':
        case 'operation-not-allowed':
        case 'account-exists-with-different-credential':
        case 'invalid-verification-code':
        case 'invalid-verification-id':
          return 'Sorry, something went wrong there. Try again.';
      }
    } else if (exception is PlatformException) {
      switch (exception.code) {
        case 'popup_blocked_by_browser':
          return '''
      The popup was blocked by your browser. Please enable popups to continue.
      ''';
      }
    }
    return 'Something unexpected happened. Please try again.';
  }
}

@protected
String googleSignInExceptionToMessage([dynamic exception]) {
  if (exception is GoogleSignInException) {
    switch (exception.code.name) {
      case 'canceled':
        return 'Sign-in was cancelled. Please try again if you want to continue.';
      case 'interrupted':
        return 'Sign-in was interrupted. Please try again.';
      case 'clientConfigurationError':
        return 'There is a configuration issue with Google Sign-In. Please contact support.';
      case 'providerConfigurationError':
        return 'Google Sign-In is currently unavailable. Please try again later or contact support.';
      case 'uiUnavailable':
        return 'Google Sign-In is currently unavailable. Please try again later or contact support.';
      case 'userMismatch':
        return 'There was an issue with your account. Please sign out and try again.';
      case 'unknownError':
      default:
        return 'An unexpected error occurred during Google Sign-In. Please try again.';
    }
  }
  return 'Something unexpected happened. Please try again.';
}
