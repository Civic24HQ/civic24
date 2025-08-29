part of '../home_view.dart';

class AllReports extends ViewModelWidget<HomeViewModel> {
  const AllReports({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.allReportList.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(onTapComment: () => viewModel.viewComment(), reportData: viewModel.allReportList[index]);
          }, childCount: viewModel.allReportList.length),
        ),
      ],
    );
  }
}
