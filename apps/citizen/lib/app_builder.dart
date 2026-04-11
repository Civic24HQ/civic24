import 'package:citizen/app/app.locator.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class AppBuilder extends StatelessWidget with AlertMixin {
  const AppBuilder({required this.builder, super.key});
  final Widget Function(DisplayPreferences) builder;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AppBuilderViewModel(alertListener: this),
      builder: (context, model, child) {
        return OverlaySupport.global(child: builder(model.displayPreferences));
      },
      disposeViewModel: false,
      createNewViewModelOnInsert: true,
    );
  }

  @override
  void onAlert(AlertModel notification) => AppAlert.onNotification(notification);

  @override
  void onToast(String message) => AppAlert.onToast(message);
}

class AppBuilderViewModel extends ReactiveViewModel {
  AppBuilderViewModel({AlertMixin? alertListener}) {
    _alertListener = alertListener ?? _defaultAlertListener;
    registerListener(_alertListener);
  }
  final userService = locator<UserService>();
  final alertService = locator<AlertService>();
  late final AlertMixin _alertListener;

  static const _defaultAlertListener = _NoOpAlertListener();

  @override
  List<ListenableServiceMixin> get listenableServices => [userService, alertService];

  DisplayPreferences get displayPreferences => userService.displayPreferences;

  void registerListener(AlertMixin listener) => alertService.addAlertListener(listener);
}

class _NoOpAlertListener with AlertMixin {
  const _NoOpAlertListener();

  @override
  void onAlert(AlertModel notification) {}
  @override
  void onToast(String message) {}
}
