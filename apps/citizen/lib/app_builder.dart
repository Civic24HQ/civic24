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
      viewModelBuilder: AppBuilderViewModel.new,
      builder: (context, model, child) {
        return OverlaySupport.global(child: builder(model.displayPreferences));
      },
      disposeViewModel: false,
      createNewViewModelOnInsert: true,
    );
  }

  @override
  void onAlert(AlertModel notification) =>
      AppAlert.onNotification(notification);

  @override
  void onToast(String message) => AppAlert.onToast(message);
}

class AppBuilderViewModel extends ReactiveViewModel {
  final userService = locator<UserService>();
  final alertService = locator<AlertService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [
    userService,
    alertService,
  ];

  DisplayPreferences get displayPreferences => userService.displayPreferences;

  void registerListener(AlertMixin listener) =>
      alertService.addAlertListener(listener);
}
