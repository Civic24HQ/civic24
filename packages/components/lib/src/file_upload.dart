import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class FileUpload extends StatelessWidget {
  const FileUpload({this.onUpload, super.key});
  final VoidCallback? onUpload;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: const EdgeInsets.all(0.5),
      strokeWidth: 1.5,
      color: context.primary,
      dashPattern: const [4, 2],
      borderType: BorderType.RRect,
      radius: const Radius.circular(AppDimensions.size16),
      child: InkWell(
        onTap: onUpload,
        child: Container(
          padding: AppEdgeInsets.padding24,
          width: double.infinity,
          decoration: BoxDecoration(color: context.surface, borderRadius: AppBorderRadius.radius16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSpacing.large,
              Container(
                width: AppDimensions.size64,
                height: AppDimensions.size64,
                decoration: BoxDecoration(shape: BoxShape.circle, color: context.primaryContainer),
                padding: AppEdgeInsets.padding4,
                child: Icon(
                  SolarIconsOutline.cloudUpload,
                  color: context.onPrimaryContainer,
                  size: AppDimensions.size36,
                ),
              ),
              AppSpacing.normal,
              Text(l10n.generalClickToUpload, style: context.labelLarge?.copyWith(color: context.onSurfaceVariant)),
              AppSpacing.medium,
              Text(
                l10n.generalSupportedFormats,
                style: context.labelSmall?.copyWith(color: context.outlineVariant, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              AppSpacing.large,
            ],
          ),
        ),
      ),
    );
  }
}
