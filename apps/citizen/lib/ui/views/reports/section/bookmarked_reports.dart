part of '../reports_view.dart';

class BookmarkedReports extends ViewModelWidget<ReportsViewModel> {
  const BookmarkedReports({super.key});

  @override
  Widget build(BuildContext context, ReportsViewModel viewModel) {
    if (viewModel.bookmarkedReportList.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(
              onTapLike: () =>
                  viewModel.likeReport(viewModel.bookmarkedReportList[index]),
              onTapDislike: () => viewModel.dislikeReport(
                viewModel.bookmarkedReportList[index],
              ),
              onTapBookmark: () => viewModel.bookmarkReport(
                viewModel.bookmarkedReportList[index],
              ),
              onTapComment: () => viewModel.viewComment(),
              reportData: viewModel.bookmarkedReportList[index],
            );
          }, childCount: viewModel.bookmarkedReportList.length),
        ),
      ],
    );
  }
}
