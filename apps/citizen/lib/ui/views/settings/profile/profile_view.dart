import 'package:citizen/ui/views/settings/profile/profile_view.form.dart';
import 'package:citizen/ui/views/settings/profile/profile_viewmodel.dart';
import 'package:components/components.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

@FormView(
  autoTextFieldValidation: false,
  fields: [
    FormTextField(name: 'firstName', validator: validateFirstName),
    FormTextField(name: 'lastName', validator: validateLastName),
  ],
)
class ProfileView extends StackedView<ProfileViewModel> with $ProfileView {
  const ProfileView({super.key});

  @override
  Widget builder(BuildContext context, ProfileViewModel viewModel, Widget? child) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final navigator = Navigator.of(context);
        if (viewModel.isEditing) {
          if (viewModel.isSaveButtonDisabled) {
            navigator.pop();
            return;
          }
          final shouldPop = viewModel.showCancelDialog();
          if (shouldPop) {
            navigator.pop();
          }
        } else {
          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.featureSettingsEditProfile),
          shape: Border(bottom: BorderSide(color: context.neutralLowest)),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: AppEdgeInsets.adaptiveHorizontalPadding(context),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.large,
                        Center(
                          child: AppAvatar(
                            initials: viewModel.currentUser.initials,
                            radius: AppDimensions.size96,
                            // badgeIcon: viewModel.isEditing ? SolarIconsOutline.pen : null,
                            onTapIcon: viewModel.changeAvatar,
                          ),
                        ),
                        AppSpacing.medium,
                        AppTextField(
                          controller: firstNameController,
                          errorText: viewModel.firstNameValidationMessage,
                          label: l10n.generalFirstname,
                          hintText: viewModel.currentUser.firstName,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          enabled: viewModel.isEditing,
                          inputFormatters: [alphabetsWithSpaceFormatter, maxLengthFormatter(40)],
                          autofillHints: const [AutofillHints.familyName],
                        ),
                        AppSpacing.normal,
                        AppTextField(
                          controller: lastNameController,
                          errorText: viewModel.lastNameValidationMessage,
                          label: l10n.generalLastname,
                          hintText: viewModel.currentUser.lastName,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          enabled: viewModel.isEditing,
                          inputFormatters: [alphabetsWithSpaceFormatter, maxLengthFormatter(40)],
                          autofillHints: const [AutofillHints.givenName],
                        ),
                        AppSpacing.normal,
                        AppSearchableDropdownTextField<CountryOption>(
                          label: l10n.generalCountry,
                          hintText: viewModel.currentUser.country.isEmpty ? l10n.generalSelectCountry : '',
                          value: viewModel.countryOptions
                              .where((c) => c.name == viewModel.countryValue)
                              .cast<CountryOption?>()
                              .firstOrNull,
                          items: viewModel.countryOptions,
                          itemLabel: (c) => c.name,
                          leading: (c) => CountryFlag.fromCountryCode(
                            c.iso2,
                            height: AppDimensions.size16,
                            width: AppDimensions.size24,
                          ),
                          isEnabled: viewModel.isEditing,
                          onChanged: (selected) => viewModel.onCountryChanged(selected?.name),
                        ),
                        AppSpacing.normal,
                        AppSearchableDropdownTextField<StateOption>(
                          label: l10n.generalState,
                          hintText: viewModel.currentUser.state.isEmpty ? l10n.generalSelectState : '',
                          value: viewModel.stateOptions.any((s) => s.name == viewModel.stateValue)
                              ? viewModel.stateOptions.firstWhere((s) => s.name == viewModel.stateValue)
                              : null,
                          isEnabled: viewModel.isEditing,
                          items: viewModel.stateOptions,
                          itemLabel: (s) => s.name,
                          onChanged: (selected) => viewModel.onStateChanged(selected?.name),
                        ),
                        AppSpacing.normal,
                        AppTextField(
                          initialValue: viewModel.currentUser.email,
                          label: l10n.generalEmail,
                          enabled: false,
                          fillColor: context.neutralLowest,
                          filled: true,
                        ),
                        Text(
                          l10n.featureProfileAccountEmail,
                          style: context.bodySmall?.copyWith(color: context.neutralHighest),
                        ),
                        AppSpacing.small,
                        const Spacer(),
                        AppSpacing.large,
                        if (viewModel.isEditing)
                          PrimaryButton(
                            title: l10n.generalSave,
                            isBusy: viewModel.isBusy,
                            onTap: viewModel.onSave,
                            disabled: viewModel.isSaveButtonDisabled,
                          )
                        else
                          SecondaryButton(
                            title: l10n.generalEdit,
                            onTap: viewModel.onEdit,
                            backgroundColor: context.inversePrimary,
                          ),
                        AppSpacing.normal,
                        if (viewModel.isEditing)
                          SecondaryButton(
                            title: l10n.generalCancel,
                            onTap: viewModel.onCancel,
                            backgroundColor: context.inversePrimary,
                          )
                        else
                          PrimaryButton(
                            title: l10n.generalDeleteAccountButton,
                            onTap: viewModel.deleteAccount,
                            backgroundColor: context.error,
                          ),
                        AppSpacing.large,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    super.onViewModelReady(viewModel);
    syncFormWithViewModel(viewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init();
    });
  }

  @override
  void onDispose(ProfileViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
