import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

class AuthBottomSection extends StatelessWidget {
  const AuthBottomSection({
    required this.title,
    required this.onTapped,
    required this.subTitle,
    this.titleTextStyle,
    super.key,
  });

  final String title;
  final String subTitle;
  final VoidCallback onTapped;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: titleTextStyle ?? context.bodyLarge?.copyWith(color: context.neutralHigh),
      TextSpan(
        text: title,
        children: [
          TextSpan(
            text: subTitle,
            style: context.bodyLarge?.copyWith(color: context.primary),
            recognizer: TapGestureRecognizer()..onTap = onTapped,
          ),
        ],
      ),
    );
  }
}
