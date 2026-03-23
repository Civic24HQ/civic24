import 'package:citizen/ui/bottom_sheets/delete_feedback/delete_feedback_sheet_model.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';

class DeleteFeedbackSheet extends StackedView<DeleteFeedbackSheetModel> {
  const DeleteFeedbackSheet({required this.completer, required this.request, super.key});
  final Function(SheetResponse<dynamic> response)? completer;
  final SheetRequest<dynamic> request;

  @override
  Widget builder(BuildContext context, DeleteFeedbackSheetModel viewModel, Widget? child) {
    return _DeleteFeedback(
      viewModel.feedbacks,
      selectedFeedbacks: viewModel.selectedFeedbacks,
      onFeedbackSelected: viewModel.onSelectFeedback,
      onOtherFeedbackChanged: viewModel.onOtherFeedbackChanged,
      onSubmitFeedback: viewModel.canSubmitFeedback ? viewModel.onSubmitFeedback : null,
      onSkipFeedback: viewModel.onSkipFeedback,
    );
  }

  @override
  DeleteFeedbackSheetModel viewModelBuilder(BuildContext context) => DeleteFeedbackSheetModel();
}

class _DeleteFeedback extends StatelessWidget {
  const _DeleteFeedback(
    this.feedbacks, {
    required this.selectedFeedbacks,
    required this.onFeedbackSelected,
    required this.onSkipFeedback,
    required this.onSubmitFeedback,
    required this.onOtherFeedbackChanged,
  });
  final List<DeleteFeedbackReason> feedbacks;
  final List<DeleteFeedbackReason> selectedFeedbacks;
  final ValueChanged<DeleteFeedbackReason?>? onFeedbackSelected;
  final VoidCallback? onSubmitFeedback;
  final VoidCallback onSkipFeedback;
  final ValueChanged<String?>? onOtherFeedbackChanged;

  @override
  Widget build(BuildContext context) {
    final isOtherSelected = selectedFeedbacks.contains(DeleteFeedbackReason.other);

    return Container(
      height: context.screenHeight * 0.85,
      decoration: BoxDecoration(color: context.surface, borderRadius: AppBorderRadius.topRadius16),
      padding: AppEdgeInsets.padding16,
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 5,
                decoration: BoxDecoration(color: context.neutralLow, borderRadius: AppBorderRadius.radius12),
              ),
            ),
            AppSpacing.normal,
            Center(
              child: Text(l10n.featureDeleteFeedbackTitle, style: context.headlineSmall, textAlign: TextAlign.center),
            ),
            AppSpacing.small,
            Text(l10n.featureDeleteFeedbackHint, style: context.bodyLarge),
            AppSpacing.normal,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final feedback in feedbacks)
                      CheckboxListTile(
                        value: selectedFeedbacks.contains(feedback),
                        onChanged: (value) {
                          onFeedbackSelected?.call(feedback);
                        },
                        title: Text(feedback.label, style: context.bodyMedium),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.symmetric(vertical: AppDimensions.padding4),
                        dense: true,
                        visualDensity: VisualDensity.compact,
                      ),
                    if (isOtherSelected)
                      Padding(
                        padding: AppEdgeInsets.horizontalPadding16,
                        child: AppTextField(
                          onChanged: onOtherFeedbackChanged,
                          hintText: l10n.featureDeleteFeedbackOtherHint,
                          maxLines: 3,
                        ),
                      ),
                    AppSpacing.large,
                  ],
                ),
              ),
            ),
            AppSpacing.medium,
            SecondaryButton(title: l10n.featureDeleteFeedbackButtonSkip, onTap: onSkipFeedback),
            AppSpacing.normal,
            PrimaryButton(title: l10n.featureDeleteFeedbackButtonSubmit, onTap: onSubmitFeedback),
            AppSpacing.normal,
          ],
        ),
      ),
    );
  }
}
