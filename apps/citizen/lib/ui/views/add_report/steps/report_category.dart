part of '../add_report_view.dart';

class ReportCategory extends ViewModelWidget<AddReportViewModel> {
  const ReportCategory({super.key});

  @override
  Widget build(BuildContext context, AddReportViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.featureAddReportCategory, style: context.titleMedium),
        AppSpacing.normal,
        Wrap(
          spacing: AppDimensions.padding12,
          runSpacing: AppDimensions.padding12,
          children: [
            for (final categoryType in CategoryType.values)
              AppFilterChip(
                label: categoryType.label,
                isSelected: viewModel.isCategoryTypeSelected(categoryType),
                tooltip: categoryType.detailedLabel,
                trailingIcon: const Icon(SolarIconsOutline.infoCircle, size: AppDimensions.size16),
                onSelected: (isSelected) {
                  viewModel.toggleCategoryType(categoryType, isSelected: isSelected);
                },
              ),
          ],
        ),
        AppSpacing.large,
      ],
    );
  }
}
