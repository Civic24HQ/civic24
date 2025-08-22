import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/auth/signup/signup_view.form.dart';
import 'package:citizen/ui/views/auth/signup/signup_viewmodel.dart';
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
    FormTextField(name: 'email', validator: validateEmail),
    FormTextField(name: 'password', validator: validatePassword),
  ],
)
class SignupView extends StackedView<SignupViewModel> with $SignupView {
  const SignupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
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
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.png.iosDark.image(
                                  width: AppDimensions.size56,
                                  height: AppDimensions.size56,
                                ),
                                Assets.png.civic24Logo2.image(
                                  color: context.onSurface,
                                  width: AppDimensions.size150,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              l10n.featureSignUpCreateAccount,
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
                              l10n.featureSignUpCreateAccountHint,
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
                                ? PasswordButton(
                                    onTap: viewModel.toggleShowPassword,
                                    show: viewModel.showPassword,
                                  )
                                : null,
                            prefixIcon: const Icon(
                              SolarIconsOutline.lockPassword,
                            ),
                            obscureText: !viewModel.showPassword,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              viewModel.signUpWithEmail();
                            },
                            keyboardType: viewModel.showPassword
                                ? TextInputType.visiblePassword
                                : TextInputType.text,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                          ),
                          AppSpacing.large,
                          const Spacer(),
                          PrimaryButton(
                            title: l10n.generalSignUp,
                            isBusy: viewModel.isEmailButtonBusy,
                            onTap: viewModel.signUpWithEmail,
                          ),
                          AppSpacing.normal,
                          AuthButton(
                            isAppleButtonBusy: viewModel.isAppleButtonBusy,
                            isGoogleButtonBusy: viewModel.isGoogleButtonBusy,
                            onAppleTap: viewModel.isAppleSignInAvailable
                                ? viewModel.handleApple
                                : null,
                            onGoogleTap: viewModel.handleGoogle,
                          ),
                          AppSpacing.normal,
                          BottomSection(
                            title: l10n.featureAlreadyHaveAnAccount,
                            subTitle: l10n.generalLogin,
                            onTapped: viewModel.navigateToLogin,
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
  SignupViewModel viewModelBuilder(BuildContext context) => SignupViewModel();

  @override
  void onViewModelReady(SignupViewModel viewModel) {
    super.onViewModelReady(viewModel);
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(SignupViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
