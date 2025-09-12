import 'package:citizen/ui/views/settings/settings_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: context.surface,
      appBar: AppBar(
        title: Text(l10n.pageSettings),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.surface,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: context.neutralLowest)),
      ),
      body: SingleChildScrollView(
        key: const PageStorageKey('settings'),
        child: Column(
          children: [
            AppSpacing.normal,
            SettingsListTile(
              iconData: SolarIconsOutline.userRounded,
              title: l10n.featureSettingsProfile,
              onTap: viewModel.navigateToProfile,
            ),
            SettingsListTile(
              iconData: SolarIconsOutline.globus,
              title: l10n.featureSettingsLanguage,
              onTap: viewModel.navigateToLanguageSettings,
            ),
            SettingsListTile(
              iconData: SolarIconsOutline.sun,
              title: l10n.featureSettingsAppearance,
              onTap: viewModel.navigateToAppearanceSettings,
            ),
            SettingsListTile(
              iconData: SolarIconsOutline.infoCircle,
              title: l10n.featureSettingsAbout,
              subtitle: l10n.featureSettingsVersion(viewModel.appVersion),
              trailing: const SizedBox.shrink(),
            ),
            SettingsListTile(
              iconData: SolarIconsOutline.logout_2,
              iconColor: context.colorScheme.error,
              title: l10n.generalLogout,
              titleStyle: context.bodyLarge?.copyWith(
                color: context.colorScheme.error,
              ),
              onTap: viewModel.showLogoutConfirmationDialog,
            ),
            AppSpacing.xxLarge,
          ],
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) =>
      SettingsViewModel();
}
