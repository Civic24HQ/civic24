import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';

mixin AlertMixin {
  void onAlert(AlertModel notification);
  void onToast(String message);
}

class AlertService with ListenableServiceMixin {
  AlertService() {
    listenToReactiveValues([alertListeners]);
  }

  @protected
  final alertListeners = ReactiveList<AlertMixin>();

  void addAlertListener(AlertMixin listener) => alertListeners.add(listener);

  @protected
  void notifyAlertListeners(AlertModel alertmodel) {
    for (final listener in alertListeners) {
      listener.onAlert(alertmodel);
    }
  }

  void showSuccessAlert({required String title, required String message}) =>
      notifyAlertListeners(SuccessAlert(title: title, message: message));

  void showInfoAlert({required String title, required String message}) =>
      notifyAlertListeners(InfoAlert(title: title, message: message));

  void showWarningAlert({required String title, required String message}) =>
      notifyAlertListeners(WarningAlert(title: title, message: message));

  void showErrorAlert({required String title, required String message}) =>
      notifyAlertListeners(ErrorAlert(title: title, message: message));

  void showAlert(AlertModel alert) => notifyAlertListeners(alert);

  void showToast(String message) {
    for (final listener in alertListeners) {
      listener.onToast(message);
    }
  }
}
