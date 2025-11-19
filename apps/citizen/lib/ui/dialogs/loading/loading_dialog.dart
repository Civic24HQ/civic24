import 'dart:ui';

import 'package:citizen/ui/dialogs/loading/loading_dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class LoadingDialog extends StackedView<LoadingDialogModel> {
  const LoadingDialog({
    required this.request,
    required this.completer,
    super.key,
  });
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  Widget builder(
    BuildContext context,
    LoadingDialogModel viewModel,
    Widget? child,
  ) {
    final title = request.title ?? l10n.featureSettingsLoading;

    return BackdropFilter(
      filter: isTest
          ? ImageFilter.blur()
          : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          title: Text(
            title,
            style: context.titleLarge,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpacing.medium,
              Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: context.primaryColor,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
              AppSpacing.medium,
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  @override
  LoadingDialogModel viewModelBuilder(BuildContext context) =>
      LoadingDialogModel();
}
