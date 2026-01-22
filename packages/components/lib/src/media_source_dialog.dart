import 'dart:ui';

import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class MediaSourceDialog extends StatelessWidget {
  const MediaSourceDialog({required this.onAssetSourceTapped, super.key});
  final ValueChanged<AssetSource> onAssetSourceTapped;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: isTest ? ImageFilter.blur() : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpacing.normal,
              // Take Picture
              PrimaryButton(
                leadingIcon: SolarIconsBold.cameraMinimalistic,
                iconColor: context.surface,
                title: AssetSource.camera.label,
                onTap: () => onAssetSourceTapped.call(AssetSource.camera),
              ),
              AppSpacing.normal,
              // Pick Image
              SecondaryButton(
                leadingIcon: SolarIconsBold.cloudUpload,
                iconColor: context.primary,
                title: AssetSource.gallery.label,
                onTap: () => onAssetSourceTapped.call(AssetSource.gallery),
              ),
              AppSpacing.normal,
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
