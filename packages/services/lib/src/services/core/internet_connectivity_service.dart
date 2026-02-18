import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

/// Service to monitor internet connectivity status in real-time and provide reactive updates to the app.
class InternetConnectivityService with ListenableServiceMixin {
  InternetConnectivityService() {
    listenToReactiveValues([_isConnected]);
  }
  final log = getLogger('InternetConnectivityService');

  final InternetConnection _checker = InternetConnection();

  final _alertService = serviceLocator<AlertService>();

  StreamSubscription<InternetStatus>? _subscription;

  final ReactiveValue<bool> _isConnected = ReactiveValue(true);

  bool get isConnected => _isConnected.value;

  bool _initialized = false;

  bool _offlineDialogVisible = false;

  /// Initialize connectivity monitoring and checks initial status
  Future<void> initialize() async {
    if (_initialized) return;

    log.i('Initializing Internet Connectivity Service');

    _initialized = true;

    final initialStatus = await _checker.hasInternetAccess;

    _updateConnectionState(initialStatus, showDialog: false);

    _subscription = _checker.onStatusChange.listen(
      (InternetStatus status) {
        final connected = status == InternetStatus.connected;

        log.i('Internet status changed: $connected');

        _updateConnectionState(connected, showDialog: true);
      },
      onError: (error, stackTrace) {
        log.e('Connectivity listener error', error: error);
      },
    );
  }

  /// Updates internal state and optionally shows dialogs
  @protected
  void _updateConnectionState(bool connected, {required bool showDialog}) {
    final wasConnected = _isConnected.value;

    _isConnected.value = connected;

    notifyListeners();

    if (!showDialog) return;

    /// Lost connection
    if (!connected && wasConnected) {
      _showOfflineDialog();
    }

    /// Connection restored
    if (connected && !wasConnected) {
      _showOnlineDialog();
    }
  }

  @protected
  void _showOfflineDialog() {
    if (_offlineDialogVisible) return;

    log.w('Showing offline dialog');

    _offlineDialogVisible = true;

    _alertService.showWarningAlert(
      title: 'No Internet Connection',
      message: 'You are currently offline. Some features may not work.',
    );
  }

  @protected
  void _showOnlineDialog() {
    if (!_offlineDialogVisible) return;

    log.i('Showing online dialog');

    _offlineDialogVisible = false;

    _alertService.showSuccessAlert(title: 'Connection Restored', message: 'You are back online.');
  }

  Future<void> dispose() async {
    log.i('Disposing InternetConnectivityService');

    await _subscription?.cancel();

    _subscription = null;
  }
}
