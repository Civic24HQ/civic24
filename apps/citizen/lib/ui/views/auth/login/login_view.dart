import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/auth/login/login_view.form.dart';
import 'package:citizen/ui/views/auth/login/login_viewmodel.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

@FormView(
  autoTextFieldValidation: false,
  fields: [
    FormTextField(name: 'email', validator: Validator.validateEmail),
    FormTextField(name: 'password', validator: Validator.validatePassword),
  ],
)
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({super.key});

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing: viewModel.anyObjectsBusy,
        child: Scaffold(
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
                          IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.png.adaptiveIcon.image(
                                  width: AppDimensions.size56,
                                  height: AppDimensions.size56,
                                ),
                                Assets.png.civic24Logo2.image(color: context.onSurface, width: AppDimensions.size150),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              l10n.featureLoginWelcome,
                              style: context.headlineSmall?.copyWith(
                                color: context.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          AppSpacing.tiny,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              l10n.featureLoginWelcomeHint,
                              style: context.titleMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: context.onSurfaceVariant,
                              ),
                            ),
                          ),
                          AppSpacing.xLarge,
                          AutoCompleteField(
                            label: l10n.generalEmail,
                            hintText: l10n.generalEnterEmail,
                            suggestions: kPopularEmailDomains,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            prefixIcon: SolarIconsOutline.letter,
                            validationMessage: viewModel.emailValidationMessage,
                            onChanged: viewModel.updateEmail,
                            inputFormatters: [noSpacesFormatter],
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          AppSpacing.normal,
                          AppTextField(
                            key: const ValueKey('password'),
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            errorText: viewModel.passwordValidationMessage,
                            label: l10n.generalPassword,
                            hintText: l10n.generalEnterPassword,
                            suffixIcon: passwordController.text.isNotEmpty
                                ? PasswordButton(onTap: viewModel.toggleShowPassword, show: viewModel.showPassword)
                                : null,
                            prefixIcon: const Icon(SolarIconsOutline.lockPassword),
                            obscureText: !viewModel.showPassword,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              viewModel.loginWithEmail();
                            },
                            keyboardType: viewModel.showPassword ? TextInputType.visiblePassword : TextInputType.text,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                          ),
                          AppSpacing.standard,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: viewModel.navigateToForgetPassword,
                              child: Text(
                                l10n.featureForgotPassword,
                                style: context.bodyMedium?.copyWith(color: context.primary),
                              ),
                            ),
                          ),
                          AppSpacing.large,
                          const Spacer(),
                          PrimaryButton(
                            title: l10n.generalLogin,
                            isBusy: viewModel.isEmailButtonBusy,
                            onTap: viewModel.loginWithEmail,
                          ),
                          AppSpacing.normal,
                          AuthButton(
                            isAppleButtonBusy: viewModel.isAppleButtonBusy,
                            isGoogleButtonBusy: viewModel.isGoogleButtonBusy,
                            onAppleTap: viewModel.isAppleSignInAvailable ? viewModel.handleApple : null,
                            onGoogleTap: viewModel.handleGoogle,
                          ),
                          AppSpacing.normal,
                          BottomSection(
                            title: l10n.featureDontHaveAccount,
                            subTitle: l10n.generalSignUp,
                            onTapped: viewModel.navigateToSignUp,
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
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    super.onViewModelReady(viewModel);
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(LoginViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
