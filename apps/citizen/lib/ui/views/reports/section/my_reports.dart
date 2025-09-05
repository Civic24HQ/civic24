part of '../reports_view.dart';

class MyReports extends ViewModelWidget<ReportsViewModel> {
  const MyReports({super.key});

  @override
  Widget build(BuildContext context, ReportsViewModel viewModel) {
    if (viewModel.myReportList.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(
              onTapLike: () => viewModel.likeReport(viewModel.myReportList[index]),
              onTapDislike: () => viewModel.dislikeReport(viewModel.myReportList[index]),
              onTapBookmark: () => viewModel.bookmarkReport(viewModel.myReportList[index]),
              onTapComment: () => viewModel.viewComment(),
              reportData: viewModel.myReportList[index],
            );
          }, childCount: viewModel.myReportList.length),
        ),
      ],
    );
  }
}
