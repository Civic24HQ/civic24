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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppDimensions.size16,
            mainAxisSpacing: AppDimensions.size16,
          ),
          itemCount:
              viewModel.mediaFiles.length + 1, // +1 for the "Add Media" button
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.neutralLow),
                  borderRadius: AppBorderRadius.radius8,
                ),
                child: IconButton(
                  onPressed: () => viewModel.pickImageWithSourceDialog(),
                  icon: const Icon(
                    SolarIconsOutline.cameraAdd,
                    size: AppDimensions.size24,
                  ),
                ),
              );
            }
            final mediaFile = viewModel.mediaFiles[index - 1];
            if (mediaFile == null) {
              return const SizedBox.shrink();
            }
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: AppBorderRadius.radius8,
                  child: Image.file(
                    mediaFile.imageFile,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -16,
                  right: -6,
                  child: Container(
                    width: AppDimensions.size28,
                    decoration: BoxDecoration(
                      color: context.neutralLowest,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: AppDimensions.size16,
                      icon: Icon(Icons.close, color: context.onSurface),
                      onPressed: () => viewModel.removeMediaFile(index - 1),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        AppSpacing.large,
      ],
    );
  }
}
