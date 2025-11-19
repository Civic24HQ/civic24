import 'package:citizen/ui/views/complete_profile/complete_profile_view.form.dart';
import 'package:citizen/ui/views/complete_profile/complete_profile_viewmodel.dart';
import 'package:components/components.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:solar_icons/solar_icons.dart';
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
class CompleteProfileView extends StackedView<CompleteProfileViewModel>
    with $CompleteProfileView {
  const CompleteProfileView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CompleteProfileViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.featureCompleteProfile),
          automaticallyImplyLeading: false,
          shape: Border(bottom: BorderSide(color: context.neutralLowest)),
        ),
        body: SafeArea(
          child: Padding(
            padding: AppEdgeInsets.adaptiveHorizontalPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.large,
                        AppTextField(
                          controller: firstNameController,
                          errorText: viewModel.firstNameValidationMessage,
                          label: l10n.generalFirstname,
                          hintText: l10n.generalEnterFirstname,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            alphabetsWithSpaceFormatter,
                            maxLengthFormatter(40),
                          ],
                          autofillHints: const [AutofillHints.givenName],
                        ),
                        AppSpacing.normal,
                        AppTextField(
                          controller: lastNameController,
                          errorText: viewModel.lastNameValidationMessage,
                          label: l10n.generalLastname,
                          hintText: l10n.generalEnterLastname,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            alphabetsWithSpaceFormatter,
                            maxLengthFormatter(40),
                          ],
                          autofillHints: const [AutofillHints.givenName],
                        ),
                        AppSpacing.normal,
                        // AppDropdownButtonTextField(
                        //   label: l10n.generalCountry,
                        //   hintText: l10n.generalSelectCountry,
                        //   value: viewModel.countryValue,
                        //   items: viewModel.countryOptions.map<DropdownMenuItem<String>>((c) {
                        //     return DropdownMenuItem<String>(
                        //       value: c.name,
                        //       child: Row(
                        //         children: [
                        //           CountryFlag.fromCountryCode(
                        //             c.iso2,
                        //             height: AppDimensions.size16,
                        //             width: AppDimensions.size24,
                        //           ),
                        //           AppSpacing.standard,
                        //           Text(
                        //             c.name,
                        //             style: context.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   }).toList(),
                        //   onChanged: viewModel.onCountryChanged,
                        // ),
                        // AppSpacing.normal,
                        AppSearchableDropdownTextField<CountryOption>(
                          label: l10n.generalCountry,
                          hintText: l10n.generalSelectCountry,
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
                          onChanged: (selected) =>
                              viewModel.onCountryChanged(selected?.name),
                        ),
                        AppSpacing.normal,
                        AppSearchableDropdownTextField<StateOption>(
                          label: l10n.generalState,
                          hintText: l10n.generalSelectState,
                          value:
                              viewModel.stateOptions.any(
                                (s) => s.name == viewModel.stateValue,
                              )
                              ? viewModel.stateOptions.firstWhere(
                                  (s) => s.name == viewModel.stateValue,
                                )
                              : null,
                          items: viewModel.stateOptions,
                          itemLabel: (s) => s.name,
                          onChanged: (selected) =>
                              viewModel.onStateChanged(selected?.name),
                        ),
                        // AppSpacing.normal,
                        // AppDropdownButtonTextField(
                        //   label: l10n.generalState,
                        //   hintText: l10n.generalSelectState,
                        //   value: viewModel.stateValue,
                        //   items: viewModel.stateOptions.map<DropdownMenuItem<String>>((s) {
                        //     return DropdownMenuItem<String>(value: s.name, child: Text(s.name));
                        //   }).toList(),
                        //   onChanged: viewModel.onStateChanged,
                        // ),
                        AppSpacing.standard,
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: viewModel.getAccurateLocationData,
                          iconAlignment: IconAlignment.end,
                          icon: Icon(
                            SolarIconsOutline.gps,
                            color: context.primary,
                            size: AppDimensions.size20,
                          ),
                          label: Text(
                            l10n.generalUseAccurateLocation,
                            style: context.bodyMedium!.copyWith(
                              color: context.primary,
                            ),
                          ),
                        ),
                        AppSpacing.large,
                      ],
                    ),
                  ),
                ),
                AppSpacing.large,
                PrimaryButton(
                  title: l10n.generalProceed,
                  onTap: viewModel.onSaveData,
                  isBusy: viewModel.isBusy,
                  disabled: viewModel.isProceedButtonDisabled,
                ),
                AppSpacing.large,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  CompleteProfileViewModel viewModelBuilder(BuildContext context) =>
      CompleteProfileViewModel();

  @override
  void onViewModelReady(CompleteProfileViewModel viewModel) {
    super.onViewModelReady(viewModel);
    syncFormWithViewModel(viewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init();
    });
  }

  @override
  void onDispose(CompleteProfileViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
