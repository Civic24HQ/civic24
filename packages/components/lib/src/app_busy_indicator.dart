import 'package:flutter/material.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class AppBusyIndicator extends StatelessWidget {
  const AppBusyIndicator({super.key, this.color, this.size = AppDimensions.size24});
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator.adaptive(
        backgroundColor: isCupertino ? (color ?? context.neutralLow) : null,
        strokeWidth: AppDimensions.size2,
        valueColor: AlwaysStoppedAnimation(color ?? context.neutralLow),
      ),
    );
  }
}
