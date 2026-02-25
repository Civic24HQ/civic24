part of '../reports_view.dart';

class MyReports extends StatefulWidget {
  const MyReports({super.key});

  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  final _controller = ScrollController();
  static const int _myReportsPageLimit = 7;

  late ReportsViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = getParentViewModel<ReportsViewModel>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.initUserReportsFeed(limit: _myReportsPageLimit);
      await _viewModel.startRealTimeFeed(ReportFeedType.userReports);
    });
  }

  void _onScroll() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent - 300) {
      _viewModel.loadMoreUserReports(limit: _myReportsPageLimit);
    }
  }

  @override
  void dispose() {
    _viewModel.stopRealTimeFeed(ReportFeedType.userReports);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getParentViewModel<ReportsViewModel>(context);

    if (viewModel.isUserReportsInitialLoading()) {
      return CustomScrollView(
        slivers: [SliverList(delegate: SliverChildBuilderDelegate((_, __) => const AppReportShimmer(), childCount: 6))],
      );
    }

    final userReports = viewModel.getUserReports();

    return CustomScrollView(
      controller: _controller,
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: () => viewModel.refreshUserReports(limit: _myReportsPageLimit)),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(
              onTapLike: () => viewModel.likeReport(userReports[index]),
              onTapDislike: () => viewModel.dislikeReport(userReports[index]),
              onTapBookmark: () => viewModel.bookmarkReport(userReports[index]),
              onTapComment: viewModel.viewComment,
              report: userReports[index],
            );
          }, childCount: userReports.length),
        ),

        if (viewModel.isUserReportsPaginationLoading())
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.size12),
              child: Center(child: AppBusyIndicator(color: context.primary)),
            ),
          ),
      ],
    );
  }
}
