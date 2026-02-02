import 'package:assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

enum SecurityAlertType { google, apple, other }

class SecurityListTile extends StatelessWidget {
  const SecurityListTile({
    this.title = '',
    this.isEnabled = false,
    this.alert = SecurityAlertType.other,
    this.titleStyle,
    this.subtitle,
    this.onTap,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final bool isEnabled;
  final SecurityAlertType alert;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final leadingWidget = switch (alert) {
      SecurityAlertType.google => Assets.svg.googleLogo.svg(width: AppDimensions.size24, height: AppDimensions.size24),
      SecurityAlertType.apple => const Icon(FontAwesomeIcons.apple, size: AppDimensions.size24),
      SecurityAlertType.other => Icon(
        SolarIconsOutline.lockPassword,
        color: context.onPrimaryContainer,
        size: AppDimensions.size24,
      ),
    };
    return Semantics(
      container: true,
      child: Tooltip(
        message: l10n.featureSettingsTooltip(title.isEmpty ? '' : title),
        child: InkWell(
          onTap: onTap,
          child: Ink(
            color: Colors.transparent,
            padding: AppEdgeInsets.padding16,
            child: Row(
              children: [
                leadingWidget,
                AppSpacing.normal,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle ?? context.bodyLarge),
                      if (subtitle != null) ...[
                        AppSpacing.small,
                        Padding(
                          padding: const EdgeInsets.only(top: AppDimensions.size2),
                          child: Text(subtitle!, style: context.labelMedium?.copyWith(color: context.neutralHigh)),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isEnabled)
                  Container(
                    height: AppDimensions.size32,
                    width: AppDimensions.size32,
                    padding: AppEdgeInsets.padding8,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.inversePrimary),
                    child: Icon(Icons.check, size: AppDimensions.size16, color: context.primary.withAlpha(200)),
                  )
                else
                  Icon(SolarIconsOutline.altArrowRight, size: AppDimensions.size20, color: context.outlineVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
