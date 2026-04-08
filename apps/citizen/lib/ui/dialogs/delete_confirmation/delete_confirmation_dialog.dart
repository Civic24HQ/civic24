import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class DeleteConfirmationDialog extends StatefulWidget {
  const DeleteConfirmationDialog({required this.request, required this.completer, super.key});
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  State<DeleteConfirmationDialog> createState() => _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: isTest ? ImageFilter.blur() : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: AlertDialog(
          title: Center(
            child: Text(l10n.featureDeleteConfirmationTitle, style: context.titleLarge, textAlign: TextAlign.center),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  AppSpacing.normal,
                  Center(
                    child: Text(
                      l10n.featureDeleteConfirmationMessage,
                      style: context.bodyMedium?.copyWith(color: context.onSurface),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AppSpacing.normal,
                  CheckboxListTile(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    title: Text(
                      l10n.featureDeleteConfirmationHint,
                      style: context.labelMedium?.copyWith(color: context.onSurfaceVariant),
                    ),

                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                  ),
                  AppSpacing.large,
                  PrimaryButton(
                    title: l10n.featureDeleteConfirmationProceed,
                    onTap: _isChecked ? () => widget.completer(DialogResponse(confirmed: true)) : null,
                  ),
                  AppSpacing.normal,
                  TextButton(
                    onPressed: () => widget.completer(DialogResponse()),
                    child: Text(l10n.generalCancel, style: context.bodyLarge?.copyWith(color: context.error)),
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
