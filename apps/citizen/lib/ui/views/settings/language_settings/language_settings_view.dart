import 'package:citizen/ui/views/settings/language_settings/language_settings_viewmodel.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class LanguageSettingsView extends StackedView<LanguageSettingsViewModel> {
  const LanguageSettingsView({super.key});

  @override
  Widget builder(BuildContext context, LanguageSettingsViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.featureSettingsLanguage),
        shape: Border(bottom: BorderSide(color: context.neutralLowest)),
      ),
      body: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: AppEdgeInsets.verticalPadding16,
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final language in LanguageType.values.where(
                (l) => appSupportedLocales.map((e) => e.languageCode).contains(l.locale),
              ))
                AppLanguageListTile(
                  value: language,
                  groupValue: viewModel.selectedLanguage,
                  onChanged: viewModel.onLanguageChanged,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LanguageSettingsViewModel viewModelBuilder(BuildContext context) => LanguageSettingsViewModel();
}
