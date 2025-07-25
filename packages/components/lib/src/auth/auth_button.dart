import 'package:assets/assets.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:styles/styles.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    this.onGoogleTap,
    this.onAppleTap,
    this.isGoogleButtonBusy = false,
    this.isAppleButtonBusy = false,
    super.key,
  });

  final bool isGoogleButtonBusy;
  final bool isAppleButtonBusy;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onGoogleTap != null)
          PrimaryButton(
            borderColor: context.neutralHigh,
            leading: Assets.svg.googleLogo.svg(width: AppDimensions.size20, height: AppDimensions.size20),
            isBusy: isGoogleButtonBusy,
            title: l10n.generalContinueWithGoogle,
            titleColor: context.neutralHigh,
            backgroundColor: context.surface,
            onTap: onGoogleTap,
          ),
        AppSpacing.normal,
        if (onAppleTap != null)
          PrimaryButton(
            backgroundColor: context.onSurface,
            leadingIcon: FontAwesomeIcons.apple,
            title: l10n.generalContinueWithApple,
            isBusy: isAppleButtonBusy,
            onTap: onAppleTap,
          ),
      ],
    );
  }
}
// 