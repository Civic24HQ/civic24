part of '../home_view.dart';

class TrendingReports extends ViewModelWidget<HomeViewModel> {
  const TrendingReports({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.trendingReportList.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(
              onTapComment: () => viewModel.viewComment(),
              reportData: viewModel.trendingReportList[index],
            );
          }, childCount: viewModel.trendingReportList.length),
        ),
      ],
    );
  }
}
