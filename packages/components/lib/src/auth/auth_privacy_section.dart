import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:styles/styles.dart';

class AuthPrivacySection extends StatelessWidget {
  const AuthPrivacySection({this.onTapTerm, this.onTapPolicy, super.key});

  final VoidCallback? onTapTerm;
  final VoidCallback? onTapPolicy;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: context.bodySmall,
      textAlign: TextAlign.center,
      TextSpan(
        text: l10n.featureAuthTermDescription,
        children: [
          TextSpan(
            text: l10n.featureAuthTermDescriptionTerms,
            style: context.bodySmall?.copyWith(
              color: context.primary,
              decoration: TextDecoration.underline,
              decorationColor: context.primary,
              decorationThickness: 0.5,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTapTerm,
          ),
          TextSpan(text: l10n.featureAuthTermAnd),
          TextSpan(
            text: l10n.featureAuthTermDescriptionPrivacy,
            style: context.bodySmall?.copyWith(
              color: context.primary,
              decoration: TextDecoration.underline,
              decorationColor: context.primary,
              decorationThickness: 0.5,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTapPolicy,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
