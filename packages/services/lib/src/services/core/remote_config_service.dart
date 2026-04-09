import 'dart:async';

import 'package:constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:utils/utils.dart';

/// Wraps [FirebaseRemoteConfig] to provide typed access to
/// server-controlled feature flags and configuration values.
class RemoteConfigService {
  final _log = getLogger('RemoteConfigService');
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  StreamSubscription<RemoteConfigUpdate>? _configUpdateSubscription;
  final ObserverList<VoidCallback> _listeners = ObserverList<VoidCallback>();

  /// Sets defaults, fetches & activates the latest config and
  /// subscribes to real-time updates.
  Future<void> initialize({Duration minimumFetchInterval = const Duration(minutes: 1)}) async {
    try {
      _log.i('Initializing Remote Config...');
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(fetchTimeout: const Duration(seconds: 10), minimumFetchInterval: minimumFetchInterval),
      );

      await _remoteConfig.setDefaults(RemoteConfigKeys.defaults);
      await _remoteConfig.fetchAndActivate();
      _subscribeToRealTimeUpdates();
      _log.i('Remote Config initialized successfully');
    } on FirebaseException catch (e, st) {
      _log.e('Unable to Initialize Firebase Remote Config', error: e, stackTrace: st);
    } catch (e, stack) {
      _log.e('Failed to initialize Remote Config — using defaults', error: e, stackTrace: stack);
    }
  }

  void _subscribeToRealTimeUpdates() {
    _configUpdateSubscription = _remoteConfig.onConfigUpdated.listen(
      (event) async {
        _log.i('Remote Config updated — keys: ${event.updatedKeys}');

        try {
          await _remoteConfig.activate();
          _notifyListeners();
        } catch (e) {
          _log.e('Failed to activate updated config', error: e);
        }
      },
      onError: (Object error) {
        _log.e('Remote Config real-time listener error', error: error);
      },
    );
  }

  /// Registers a [callback] invoked when config values change.
  void addListener(VoidCallback callback) {
    _listeners.add(callback);
  }

  /// Removes a previously registered [callback].
  void removeListener(VoidCallback callback) {
    _listeners.remove(callback);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Maximum images a citizen can attach to a single report.
  int get maxReportImages => _remoteConfig.getInt(RemoteConfigKeys.maxReportImages);

  /// URL for the product's Terms of Service.
  String get termsOfServiceUrl => _remoteConfig.getString(RemoteConfigKeys.productTermsUrl);

  /// URL for the product's Privacy Policy.
  String get privacyPolicyUrl => _remoteConfig.getString(RemoteConfigKeys.productPrivacyUrl);

  // TODO(Civic24): Implement feature to check if user is on latest app version and force update prompt
  /// Minimum allowed app version for forced-update prompts.
  String get minAppVersion => _remoteConfig.getString(RemoteConfigKeys.minAppVersion);

  /// Minimum like count required for a report to appear in the trending feed.
  int get trendingLikeThreshold => _remoteConfig.getInt(RemoteConfigKeys.trendingLikeThreshold);

  /// Number of days after which a user session is considered expired.
  int get sessionDurationDays => _remoteConfig.getInt(RemoteConfigKeys.sessionDurationDays);

  /// Cancels the real-time subscription and clears listeners.
  Future<void> dispose() async {
    await _configUpdateSubscription?.cancel();
    _configUpdateSubscription = null;
    _listeners.clear();
  }
}
