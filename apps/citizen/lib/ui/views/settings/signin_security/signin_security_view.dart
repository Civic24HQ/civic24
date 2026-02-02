import 'package:citizen/ui/views/settings/signin_security/signin_security_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class SignInSecurityView extends StackedView<SignInSecurityViewModel> {
  const SignInSecurityView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SignInSecurityViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.featureSettingsSignInSecurity),
        shape: Border(bottom: BorderSide(color: context.neutralLowest)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacing.normal,
            SecurityListTile(
              alert: SecurityAlertType.google,
              title: l10n.featureSettingsSecurityGoogle,
              subtitle: viewModel.isGoogleAuthLinked()
                  ? l10n.featureSettingsSecurityGoogleLinkedDesc
                  : l10n.featureSettingsSecurityGoogleUnlinkDesc,
              onTap: viewModel.navigateToGoogleAuth,
              isEnabled: viewModel.isGoogleAuthLinked(),
            ),
            // TODO(Civic24): Implement Apple Sign-In functionality
            // SecurityListTile(
            //   alert: SecurityAlertType.apple,
            //   title: l10n.featureSettingsSecurityApple,
            //   subtitle: l10n.featureSettingsSecurityAppleUnlinkDesc,
            //   onTap: viewModel.navigateToAppleAuth,
            //   isEnabled: viewModel.isAppleAuthLinked(),
            // ),
            SecurityListTile(
              title: viewModel.isPasswordSet()
                  ? l10n.featureSettingsSecurityResetPassword
                  : l10n.featureSettingsSecuritySetPassword,
              subtitle: viewModel.isPasswordSet()
                  ? l10n.featureSettingsSecurityResetPasswordDesc
                  : l10n.featureSettingsSecuritySetPasswordDesc,
              onTap: viewModel.navigateToUpdatePassword,
            ),
          ],
        ),
      ),
    );
  }

  @override
  SignInSecurityViewModel viewModelBuilder(BuildContext context) => SignInSecurityViewModel();
}
