import 'package:components/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class AppAlert {
  const AppAlert._();

  static void onNotification(AlertModel alert) =>
      showOverlayNotification((context) => AppAlertToastCard(alert: alert), duration: alert.duration);

  static void onToast(String message) => showOverlay(
    (context, value) => AlertToast(value: value, message: message),
    key: const ValueKey('toast'),
    curve: Curves.decelerate,
    duration: const Duration(seconds: 3),
  );
}

class AppAlertToastCard extends StatelessWidget {
  const AppAlertToastCard({required this.alert, super.key});
  final AlertModel alert;

  @override
  Widget build(BuildContext context) {
    final iconData = switch (alert) {
      InfoAlert _ => SolarIconsOutline.infoCircle,
      WarningAlert _ => SolarIconsOutline.dangerCircle,
      SuccessAlert _ => SolarIconsOutline.checkCircle,
      ErrorAlert _ => SolarIconsOutline.closeCircle,
    };
    final iconColor = switch (alert) {
      InfoAlert _ => context.onPrimaryContainer,
      WarningAlert _ => context.onWarningContainer,
      SuccessAlert _ => context.onSuccessContainer,
      ErrorAlert _ => context.onErrorContainer,
    };
    final iconBackgroundColor = switch (alert) {
      InfoAlert _ => context.primaryContainer,
      WarningAlert _ => context.warningContainer,
      SuccessAlert _ => context.successContainer,
      ErrorAlert _ => context.errorContainer,
    };
    final borderColor = switch (alert) {
      InfoAlert _ => context.primary,
      WarningAlert _ => context.warning,
      SuccessAlert _ => context.success,
      ErrorAlert _ => context.error,
    };

    final hasActionButton = alert.onActionButtonPressed != null;
    final hasDismissButton = alert.onDismissed != null;

    return SafeArea(
      child: Container(
        margin: alert.canDismiss
            ? const EdgeInsets.symmetric(horizontal: AppDimensions.padding12).copyWith(top: AppDimensions.size64)
            : null,
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.padding12, vertical: AppDimensions.padding16),
        decoration: BoxDecoration(
          boxShadow: alert.overlay ? AppElevation.high : null,
          gradient: LinearGradient(colors: [borderColor, context.surface], stops: const [0.015, 0.015]),
          border: Border.all(color: context.outline),
          borderRadius: AppBorderRadius.radius12,
        ),
        child: Material(
          color: Colors.transparent,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.standard,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: AppDimensions.size20,
                            height: AppDimensions.size20,
                            decoration: BoxDecoration(
                              color: iconBackgroundColor,
                              borderRadius: AppBorderRadius.radius4,
                            ),
                            child: Icon(iconData, color: iconColor, size: AppDimensions.size16),
                          ),
                          AppSpacing.medium,
                          Text(alert.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.titleMedium),
                        ],
                      ),
                      AppSpacing.small,
                      Text.rich(
                        TextSpan(
                          text: alert.message + (alert.onTextActionPressed != null ? ' ' : ''),
                          style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
                          children: [
                            if (alert.onTextActionPressed != null)
                              TextSpan(
                                text: alert.textActionText,
                                style: context.bodyMedium?.copyWith(
                                  color: context.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: context.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    alert.onTextActionPressed?.call();
                                    if (alert.canDismiss) {
                                      OverlaySupportEntry.of(context)?.dismiss();
                                    }
                                  },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasActionButton && hasDismissButton) ...[
                  AppSpacing.standard,
                  Center(
                    child: VerticalDivider(
                      width: 1,
                      indent: AppDimensions.size4,
                      endIndent: AppDimensions.size4,
                      color: context.outline,
                    ),
                  ),
                  AppSpacing.standard,
                ],
                if (hasDismissButton)
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.close, color: context.neutralHighest),
                      onPressed: () {
                        alert.onDismissed?.call();
                        if (alert.canDismiss) {
                          OverlaySupportEntry.of(context)?.dismiss();
                        }
                      },
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                if (hasActionButton)
                  PrimaryButton.small(
                    title: alert.actionButtonText ?? l10n.generalClose,
                    onTap: alert.onActionButtonPressed,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertToast extends StatelessWidget {
  const AlertToast({required this.value, required this.message, super.key});
  final double value;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero).transform(value),
      child: Opacity(
        opacity: Tween<double>(begin: 0, end: 1).transform(value),
        child: SafeArea(
          child: Align(
            alignment: const Alignment(0, 0.8),
            child: Card(
              margin: AppEdgeInsets.padding16,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius8),
              color: context.primaryContainer,
              child: Padding(
                padding: AppEdgeInsets.padding8,
                child: Text(
                  message,
                  style: context.bodyMedium?.copyWith(color: context.onPrimaryContainer),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ).animate().shake(),
          ),
        ),
      ),
    );
  }
}
