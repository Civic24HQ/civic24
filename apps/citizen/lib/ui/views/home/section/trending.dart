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
              onTapLike: () =>
                  viewModel.likeReport(viewModel.trendingReportList[index]),
              onTapDislike: () =>
                  viewModel.dislikeReport(viewModel.trendingReportList[index]),
              onTapBookmark: () =>
                  viewModel.bookmarkReport(viewModel.trendingReportList[index]),
              onTapComment: () => viewModel.viewComment(),
              report: viewModel.trendingReportList[index],
            );
          }, childCount: viewModel.trendingReportList.length),
        ),
      ],
    );
  }
}
