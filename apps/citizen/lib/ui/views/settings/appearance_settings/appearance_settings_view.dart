import 'package:citizen/ui/views/settings/appearance_settings/appearance_settings_viewmodel.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class AppearanceSettingsView extends StackedView<AppearanceSettingsViewModel> {
  const AppearanceSettingsView({super.key});

  @override
  Widget builder(BuildContext context, AppearanceSettingsViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.featureSettingsAppearance),
        shape: Border(bottom: BorderSide(color: context.neutralLowest)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacing.normal,
            for (final mode in AppearanceMode.values)
              AppAppearanceListTile(
                mode: mode,
                groupMode: viewModel.selectedMode,
                onChanged: viewModel.onAppearanceChanged,
              ),
          ],
        ),
      ),
    );
  }

  @override
  AppearanceSettingsViewModel viewModelBuilder(BuildContext context) => AppearanceSettingsViewModel();
}
