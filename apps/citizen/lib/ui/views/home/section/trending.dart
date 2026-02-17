part of '../home_view.dart';

class TrendingReports extends StatefulWidget {
  const TrendingReports({super.key});

  @override
  State<TrendingReports> createState() => _TrendingReportsState();
}

class _TrendingReportsState extends State<TrendingReports> {
  final _controller = ScrollController();
  static const int _trendingReportsPageLimit = 12;

  late HomeViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = getParentViewModel<HomeViewModel>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.initTrendingFeed();
      await _viewModel.startRealTimeFeed(ReportFeedType.trending);
    });
  }

  void _onScroll() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent - 300) {
      _viewModel.loadMoreTrending(limit: _trendingReportsPageLimit);
    }
  }

  @override
  void dispose() {
    _viewModel.stopRealTimeFeed(ReportFeedType.trending);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getParentViewModel<HomeViewModel>(context);

    if (viewModel.isTrendingInitialLoading()) {
      return CustomScrollView(
        slivers: [SliverList(delegate: SliverChildBuilderDelegate((_, __) => const AppReportShimmer(), childCount: 6))],
      );
    }

    final trendingReports = viewModel.getTrendingReports();

    return CustomScrollView(
      controller: _controller,
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: viewModel.refreshTrending),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(
              onTapLike: () => viewModel.likeReport(trendingReports[index]),
              onTapDislike: () => viewModel.dislikeReport(trendingReports[index]),
              onTapBookmark: () => viewModel.bookmarkReport(trendingReports[index]),
              onTapComment: viewModel.viewComment,
              report: trendingReports[index],
            );
          }, childCount: trendingReports.length),
        ),

        if (viewModel.isTrendingPaginationLoading())
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
