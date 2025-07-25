import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class ShowPasswordButton extends StatelessWidget {
  const ShowPasswordButton({required this.onTap, required this.show, super.key});
  final VoidCallback onTap;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      iconSize: AppDimensions.size16,
      splashRadius: AppDimensions.size24,
      icon: Icon(show ? SolarIconsOutline.eye : SolarIconsOutline.eyeClosed),
    );
  }
}
