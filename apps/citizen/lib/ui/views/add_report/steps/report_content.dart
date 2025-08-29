part of '../add_report_view.dart';

class ReportContent extends ViewModelWidget<AddReportViewModel> {
  const ReportContent({required this.contentController, required this.contentFocusNode, this.errorText, super.key});

  final TextEditingController contentController;
  final FocusNode contentFocusNode;
  final String? errorText;

  @override
  Widget build(BuildContext context, AddReportViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.featureAddReportContent, style: context.titleMedium),
        AppSpacing.normal,
        AppTextField(
          hintText: l10n.featureAddReportContentHint,
          filled: true,
          maxLines: 6,
          key: const ValueKey('content'),
          controller: contentController,
          focusNode: contentFocusNode,
          errorText: errorText,
          fillColor: context.backgroundColor,
          enabledBorder: context.surface,
        ),
        AppSpacing.large,
      ],
    );
  }
}
