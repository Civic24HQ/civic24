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
              subtitle: l10n.featureSettingsSecurityGoogleUnlinkDesc,
              onTap: viewModel.navigateToGoogleAuth,
            ),
            SecurityListTile(
              alert: SecurityAlertType.apple,
              title: l10n.featureSettingsSecurityApple,
              subtitle: l10n.featureSettingsSecurityAppleUnlinkDesc,
              onTap: viewModel.navigateToAppleAuth,
              isEnabled: true,
            ),
            SecurityListTile(
              title: l10n.featureSettingsSecuritySetPassword,
              subtitle: l10n.featureSettingsSecuritySetPasswordDesc,
              onTap: viewModel.navigateToSetPassword,
            ),
          ],
        ),
      ),
    );
  }

  @override
  SignInSecurityViewModel viewModelBuilder(BuildContext context) => SignInSecurityViewModel();
}
