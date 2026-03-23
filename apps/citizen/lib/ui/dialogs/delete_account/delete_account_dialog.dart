import 'dart:ui';

import 'package:citizen/ui/dialogs/delete_account/delete_account_dialog_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class DeleteAccountDialog extends StackedView<DeleteAccountDialogModel> {
  const DeleteAccountDialog({required this.request, required this.completer, super.key});
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  Widget builder(BuildContext context, DeleteAccountDialogModel viewModel, Widget? child) {
    return BackdropFilter(
      filter: isTest ? ImageFilter.blur() : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          iconColor: context.primary,
          icon: const Icon(SolarIconsOutline.checkCircle, size: AppDimensions.size80),
          title: Text(
            l10n.featureDeleteFeedbackGoodbye,
            style: context.titleLarge,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.featureDialogDeleteConfirmationDesc,
                style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            PrimaryButton(
              title: l10n.generalGotIt,
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
  DeleteAccountDialogModel viewModelBuilder(BuildContext context) => DeleteAccountDialogModel();
}
