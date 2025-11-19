import 'dart:ui';
import 'package:citizen/ui/dialogs/send_password_reset_email/send_password_reset_email_dialog_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class SendPasswordResetEmailDialog extends StackedView<SendPasswordResetEmailDialogModel> {
  const SendPasswordResetEmailDialog({required this.request, required this.completer, super.key});
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  Widget builder(BuildContext context, SendPasswordResetEmailDialogModel viewModel, Widget? child) {
    final emailValue = request.data as String?;
    return BackdropFilter(
      filter: isTest ? ImageFilter.blur() : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          iconColor: context.primary,
          icon: const Icon(SolarIconsOutline.lockPassword, size: AppDimensions.size80),
          title: Text(l10n.generalResetPassword, style: context.titleLarge, textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.generalResetPasswordDesc(emailValue!),
                style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            PrimaryButton(
              title: l10n.generalResetPasswordButtonText,
              onTap: () async {
                completer(DialogResponse(confirmed: true));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  SendPasswordResetEmailDialogModel viewModelBuilder(BuildContext context) => SendPasswordResetEmailDialogModel();
}
