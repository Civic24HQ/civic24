part of '../home_view.dart';

class AllReports extends StatefulWidget {
  const AllReports({super.key});

  @override
  State<AllReports> createState() => _AllReportsState();
}

class _AllReportsState extends State<AllReports> {
  final _controller = ScrollController();
  static const int _allReportsPageLimit = 12;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent - 300) {
      getParentViewModel<HomeViewModel>(context, listen: false).loadMoreAll(limit: _allReportsPageLimit);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: HomeViewModel.new,
      onDispose: (viewModel) {
        viewModel.stopRealTimeFeed(ReportFeedType.all);
      },
      onViewModelReady: (viewModel) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel
            ..initAllFeed()
            ..startRealTimeFeed(ReportFeedType.all);
        });
      },
      builder: (context, viewModel, child) {
        if (viewModel.isAllInitialLoading()) {
          return CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildBuilderDelegate((_, __) => const AppReportShimmer(), childCount: 6)),
            ],
          );
        }

        final reports = viewModel.getAllReports();

        return CustomScrollView(
          controller: _controller,
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: () => viewModel.refreshAll()),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return AppReport(
                  onTapLike: () => viewModel.likeReport(reports[index]),
                  onTapDislike: () => viewModel.dislikeReport(reports[index]),
                  onTapBookmark: () => viewModel.bookmarkReport(reports[index]),
                  onTapComment: () => viewModel.viewComment(),
                  report: reports[index],
                );
              }, childCount: reports.length),
            ),

            if (viewModel.isAllPaginationLoading())
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.size12),
                  child: Center(child: AppBusyIndicator(color: context.primary)),
                ),
              ),
          ],
        );
      },
    );
  }
}
