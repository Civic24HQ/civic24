import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    this.title = '',
    this.titleStyle,
    this.child,
    this.iconData,
    this.iconColor,
    this.iconBackgroundColor,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final Widget? child;
  final String? subtitle;
  final IconData? iconData;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Tooltip(
        message: l10n.featureSettingsTooltip(title.isEmpty ? '' : title),
        child: InkWell(
          onTap: onTap,
          child: Ink(
            color: context.surface,
            padding: AppEdgeInsets.padding16,
            child: Row(
              children: [
                Container(
                  height: AppDimensions.size36,
                  width: AppDimensions.size36,
                  padding: AppEdgeInsets.padding8,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor ?? context.inversePrimary,
                    borderRadius: AppBorderRadius.radius8,
                  ),
                  child: Icon(iconData, size: AppDimensions.size20, color: iconColor ?? context.primary.withAlpha(200)),
                ),
                AppSpacing.normal,
                Expanded(
                  child: Row(
                    children: [
                      child ?? Text(title, style: titleStyle ?? context.bodyLarge),
                      if (subtitle != null) ...[
                        AppSpacing.small,
                        Padding(
                          padding: const EdgeInsets.only(top: AppDimensions.size2),
                          child: Text(
                            subtitle!,
                            style: context.labelMedium?.copyWith(color: context.labelMedium?.color),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ??
                    Icon(
                      SolarIconsOutline.altArrowRight,
                      size: AppDimensions.size20,
                      color: iconColor ?? context.outlineVariant,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
