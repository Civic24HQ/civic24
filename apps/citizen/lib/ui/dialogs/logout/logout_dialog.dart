import 'dart:ui';

import 'package:citizen/ui/dialogs/logout/logout_dialog_model.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class LogoutDialog extends StackedView<LogoutDialogModel> {
  const LogoutDialog({required this.request, required this.completer, super.key});
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  Widget builder(BuildContext context, LogoutDialogModel viewModel, Widget? child) {
    return BackdropFilter(
      filter: isTest ? ImageFilter.blur() : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          title: Center(
            child: Text(
              l10n.featureSettingsLoggingOut,
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
                l10n.featureSettingsLoggingOutHint,
                style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              AppSpacing.large,
              PrimaryButton(
                title: l10n.generalLogout,
                backgroundColor: context.primary,
                onTap: () async {
                  completer(DialogResponse<DialogActionType>(data: DialogActionType.main, confirmed: true));
                },
              ),
              AppSpacing.medium,
              Align(
                child: TextButton(
                  style: TextButton.styleFrom(textStyle: context.bodyLarge, foregroundColor: context.onSurface),
                  onPressed: () async {
                    completer(DialogResponse<DialogActionType>(data: DialogActionType.secondary, confirmed: true));
                  },
                  child: Text(l10n.generalCancel),
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
  LogoutDialogModel viewModelBuilder(BuildContext context) => LogoutDialogModel();
}
