import 'package:citizen/ui/views/settings/update_password/update_password_view.form.dart';
import 'package:citizen/ui/views/settings/update_password/update_password_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

@FormView(
  autoTextFieldValidation: false,
  fields: [FormTextField(name: 'email', validator: Validator.validateEmail)],
)
class UpdatePasswordView extends StackedView<UpdatePasswordViewModel> with $UpdatePasswordView {
  const UpdatePasswordView(this.isPasswordSet, {super.key});
  final bool isPasswordSet;

  @override
  Widget builder(BuildContext context, UpdatePasswordViewModel viewModel, Widget? child) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing: viewModel.anyObjectsBusy,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              isPasswordSet ? l10n.featureSettingsSecurityResetPassword : l10n.featureSettingsSecuritySetPassword,
            ),
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
                        children: [
                          AppSpacing.normal,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isPasswordSet
                                  ? l10n.featureSettingsSecurityResetPasswordDesc
                                  : l10n.featureSettingsSecuritySetPasswordDesc,
                              style: context.titleMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: context.onSurfaceVariant,
                              ),
                            ),
                          ),
                          AppSpacing.normal,
                          AppTextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            errorText: viewModel.emailValidationMessage,
                            hintText: l10n.generalEmailHint,
                            prefixIcon: const Icon(SolarIconsOutline.letter),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.email],
                            inputFormatters: [noSpacesFormatter],
                          ),
                          AppSpacing.large,
                          const Spacer(),
                          PrimaryButton(
                            title: l10n.generalContinue,
                            isBusy: viewModel.isBusy,
                            onTap: viewModel.updatePassword,
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
      ),
    );
  }

  @override
  UpdatePasswordViewModel viewModelBuilder(BuildContext context) => UpdatePasswordViewModel();

  @override
  void onViewModelReady(UpdatePasswordViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      super.onViewModelReady(viewModel);
      syncFormWithViewModel(viewModel);
    });
  }

  @override
  void onDispose(UpdatePasswordViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
