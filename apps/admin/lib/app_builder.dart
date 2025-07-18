import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked/stacked.dart';

class AppBuilder extends StatelessWidget {
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
}

class AppBuilderViewModel extends BaseViewModel {
  // TODO(Civic24): Implement logic to use displayPreferences from UserService

  DisplayPreferences get displayPreferences => const DisplayPreferences();
}
