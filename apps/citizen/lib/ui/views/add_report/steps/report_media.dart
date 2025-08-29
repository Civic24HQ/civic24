part of '../add_report_view.dart';

class ReportMedia extends ViewModelWidget<AddReportViewModel> {
  const ReportMedia({super.key});

  @override
  Widget build(BuildContext context, AddReportViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.featureAddReportMedia, style: context.titleMedium),
        AppSpacing.large,
        SizedBox(
          height: AppDimensions.size300,
          child: FileUpload(onUpload: () {}),
        ),
        AppSpacing.large,
      ],
    );
  }
}
