import 'package:citizen/ui/views/auth/forgot_password/forgot_password_view.form.dart';
import 'package:citizen/ui/views/auth/forgot_password/forgot_password_viewmodel.dart';
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
class ForgotPasswordView extends StackedView<ForgotPasswordViewModel> with $ForgotPasswordView {
  const ForgotPasswordView(this.email, {super.key});
  final String email;

  @override
  Widget builder(BuildContext context, ForgotPasswordViewModel viewModel, Widget? child) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing: viewModel.anyObjectsBusy,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            shape: const Border(bottom: BorderSide(color: Colors.transparent)),
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
                              l10n.featureForgotPassword,
                              style: context.headlineSmall?.copyWith(
                                color: context.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          AppSpacing.medium,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              l10n.featureForgotPasswordHint,
                              style: context.titleMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: context.onSurfaceVariant,
                              ),
                            ),
                          ),
                          AppSpacing.xLarge,
                          AppTextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            errorText: viewModel.emailValidationMessage,
                            hintText: l10n.generalEmailHint,
                            label: l10n.generalEmail,
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
                            onTap: viewModel.resetPassword,
                          ),
                          AppSpacing.normal,
                          BottomSection(
                            title: l10n.featureForgotPasswordGoTo,
                            titleTextStyle: context.bodyLarge,
                            subTitle: l10n.generalLogin,
                            onTapped: viewModel.navigateToLoginUp,
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
  ForgotPasswordViewModel viewModelBuilder(BuildContext context) => ForgotPasswordViewModel();

  @override
  void onViewModelReady(ForgotPasswordViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      super.onViewModelReady(viewModel);
      emailController.text = email;
      syncFormWithViewModel(viewModel);
    });
  }

  @override
  void onDispose(ForgotPasswordViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
