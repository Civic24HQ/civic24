import 'dart:async';

import 'package:constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:services/src/services/firebase/firestore_collection_service.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

class UserService extends FirestoreCollectionService<UserModel> with ListenableServiceMixin, AuthObserver {
  UserService() {
    initialize();
  }

  @override
  @protected
  final log = getLogger('UserService');

  final _authService = serviceLocator<AuthenticationService>();
  final _reportService = serviceLocator<ReportService>();
  final _settingsStorage = serviceLocator<SettingsStorageService>();

  @override
  String get collectionPath => FirestoreCollections.users;

  @override
  UserModel convertFromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  @protected
  final ReactiveValue<UserModel?> _currentUser = ReactiveValue(null);
  Stream<UserModel?> get currentUserStream => _currentUser.values;

  final ReactiveValue<bool> _userInitialized = ReactiveValue(false);
  Stream<bool> get userInitializedStream => _userInitialized.values.distinct();

  final ReactiveValue<DisplayPreferences> _displayPreferences = ReactiveValue(const DisplayPreferences());
  DisplayPreferences get displayPreferences => _displayPreferences.value;

  UserModel? get user => _currentUser.value;
  bool get hasUser => _currentUser.value != null;

  StreamSubscription<UserModel?>? _userSubscription;

  Future<void> initialize() async {
    log.i('Initializing user service');
    _authService.addObserver(this);

    // Load persisted display preferences from local storage
    try {
      _displayPreferences.value = _settingsStorage.displayPreferences;
      log.d(
        'Loaded display preferences from storage: ${_displayPreferences.value.themeModeIndex}, ${_displayPreferences.value.language}',
      );
    } catch (e, st) {
      log.w('Failed to load display preferences from storage', error: e, stackTrace: st);
    }

    listenToReactiveValues([_currentUser, _displayPreferences]);
  }

  /// Persist and apply [displayPreferences] globally.
  Future<void> setDisplayPreferences(DisplayPreferences displayPreferences) async {
    _displayPreferences.value = displayPreferences;

    try {
      _settingsStorage.setDisplayPreferences(displayPreferences);
      log.d('Saved display preferences to storage');
    } catch (e, st) {
      log.w('Failed to persist display preferences', error: e, stackTrace: st);
    }
  }

  /// Convenience helper to change language.
  Future<void> setLanguage(LanguageType language) async {
    await setDisplayPreferences(displayPreferences.copyWith(language: language.locale));
  }

  /// Convenience helper to change appearance mode.
  Future<void> setAppearance(AppearanceMode mode) async {
    await setDisplayPreferences(displayPreferences.copyWith(themeModeIndex: mode.themeIndex,));
  }

  @override
  void onAuthenticated(User user) {
    syncUser();
  }

  @override
  void onUnauthenticated() {
    dispose();
  }

  Future<void> waitUntilUserIsReady() async {
    log.d('Waiting until user is ready');
    await _currentUser.values.firstWhere((user) => user != null);
    log.d('User is ready');
  }

  Future<void> syncUser() async {
    final firebaseUser = _authService.firebaseUser;
    if (firebaseUser == null) return;

    final userDoc = await get(firebaseUser.uid);
    if (userDoc != null) {
      log.i('User //${firebaseUser.uid}// document found');
      _currentUser.value = userDoc;
      unawaited(_subscribeToUserStream());
      unawaited(syncExternalServices());
    } else {
      log.w('User //${firebaseUser.uid}// document not found');
      _currentUser.value = null;
    }
    _userInitialized.value = true;
    log.d('User //${firebaseUser.uid}// sync completed');
  }

  @visibleForTesting
  Future<void> syncExternalServices() async {
    if (!hasUser) {
      log.i('Cannot update other services as user is null');
      return;
    }
    unawaited(_reportService.syncReportList());
    log.i('External services synced successfully');
  }

  Future<void> _subscribeToUserStream() async {
    log.d('Subscribing to user stream');
    await _userSubscription?.cancel();

    // Check if user exist before subscribing to user stream
    if (!hasUser) {
      log.w('Cannot subscribe to user stream as user is null');
      return;
    }

    _userSubscription = subscribe(documentId: user!.id).listen((UserModel? update) {
      log.d('Update in user streaming');

      if (update == null) {
        log.w('User document does not exist');
        return;
      }

      if (update.account.mustAuthenticate) {
        log.w('User must authenticate');
        // TODO(Civic24): Handle user must authenticate
        return;
      }

      if (update.account.isDisabled) {
        log.w('User account is disabled');
        // TODO(Civic24): Handle user account disabled
        return;
      }

      log.d('Updating current user');
      _currentUser.value = update;
    });
  }

  Future<void> createUser({
    required String firstName,
    required String lastName,
    required String country,
    required String state,
    required String city,
    required String appSource,
  }) async {
    final currentTimestamp = DateTime.now().toUtc();

    final firebaseUser = _authService.firebaseUser;
    if (firebaseUser == null) {
      log.w('Cannot create user as firebase user is null');
      throw Exception('Firebase user is null');
    }
    await _authService.updateDisplayName('$firstName $lastName');

    log.w('Creating user document for //${firebaseUser.displayName}//');

    final userAccount = UserAccount(
      email: firebaseUser.email!,
      firstName: firstName,
      lastName: lastName,
      registrationDate: currentTimestamp,
      profilePicture: firebaseUser.photoURL,
      phoneNumber: '',
      country: country,
      state: state,
      city: city,
      address: '',
      postalCode: '',
      hasCompletedOnboarding: true,
    );

    final parsedUser = UserModel(
      id: firebaseUser.uid,
      provider: _authService.currentUserAuthProvider,
      email: firebaseUser.email!,
      devices: {},
      account: userAccount,
    );

    await create(documentId: firebaseUser.uid, payload: parsedUser);
    _currentUser.value = parsedUser;
    unawaited(_subscribeToUserStream());
    log.i('User //${firebaseUser.uid}// created successfully');
  }

  Future<void> updateUser(UserModel user) async {
    log.d('Updating user document');
    if (user.id.isEmpty) {
      throw Exception('User ID is empty');
    }

    _currentUser.value = user;
    await update(documentId: user.id, payload: user);
  }

  Future<void> clearUserSessionData() async {
    log.d('Clearing user session data');
    if (!hasUser) {
      log.w('Cannot clear user data as user is null');
      return;
    }
    log.i('User session data cleared successfully');
  }

  @visibleForTesting
  Future<void> dispose() async {
    log.d('Disposing user and all related services');
    await _userSubscription?.cancel();
    _currentUser.value = null;
    _userInitialized.value = false;
  }
}
