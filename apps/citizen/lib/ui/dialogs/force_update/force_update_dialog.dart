import 'dart:ui';

import 'package:citizen/ui/dialogs/force_update/force_update_dialog_model.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class ForceUpdateDialog extends StackedView<ForceUpdateDialogModel> {
  const ForceUpdateDialog({required this.request, required this.completer, super.key});
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  Widget builder(BuildContext context, ForceUpdateDialogModel viewModel, Widget? child) {
    return BackdropFilter(
      filter: isTest ? ImageFilter.blur() : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          title: Center(
            child: Text(
              l10n.featureForceUpdateTitle,
              softWrap: true,
              style: context.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.medium,
              Text(
                l10n.featureForceUpdateDescription,
                style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              AppSpacing.large,
              PrimaryButton(
                title: l10n.featureForceUpdateButton,
                backgroundColor: context.primary,
                onTap: () async {
                  completer(DialogResponse<DialogActionType>(confirmed: true));
                },
              ),
              AppSpacing.medium,
              Align(
                child: TextButton(
                  style: TextButton.styleFrom(textStyle: context.bodyLarge, foregroundColor: context.onSurface),
                  onPressed: () async {
                    completer(DialogResponse<DialogActionType>());
                  },
                  child: Text(l10n.featureForceUpdateButtonLater),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  @override
  ForceUpdateDialogModel viewModelBuilder(BuildContext context) => ForceUpdateDialogModel();
}
