part of '../reports_view.dart';

class BookmarkedReports extends StatefulWidget {
  const BookmarkedReports({super.key});

  @override
  State<BookmarkedReports> createState() => _BookmarkedReportsState();
}

class _BookmarkedReportsState extends State<BookmarkedReports> {
  final _controller = ScrollController();
  static const int _bookmarkedReportsPageLimit = 7;

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
      await _viewModel.initUserBookmarksFeed(limit: _bookmarkedReportsPageLimit);
      await _viewModel.startRealTimeFeed(ReportFeedType.userBookmarks);
    });
  }

  void _onScroll() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent - 300) {
      _viewModel.loadMoreUserBookmarks(limit: _bookmarkedReportsPageLimit);
    }
  }

  @override
  void dispose() {
    _viewModel.stopRealTimeFeed(ReportFeedType.userBookmarks);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getParentViewModel<ReportsViewModel>(context);

    if (viewModel.isUserBookmarksInitialLoading()) {
      return CustomScrollView(
        slivers: [SliverList(delegate: SliverChildBuilderDelegate((_, __) => const AppReportShimmer(), childCount: 6))],
      );
    }

    final bookmarkedReports = viewModel.getUserBookmarkedReports();

    return CustomScrollView(
      controller: _controller,
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => viewModel.refreshUserBookmarks(limit: _bookmarkedReportsPageLimit),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return AppReport(
              onTapLike: () => viewModel.likeReport(bookmarkedReports[index]),
              onTapDislike: () => viewModel.dislikeReport(bookmarkedReports[index]),
              onTapBookmark: () => viewModel.bookmarkReport(bookmarkedReports[index]),
              onTapComment: viewModel.viewComment,
              report: bookmarkedReports[index],
            );
          }, childCount: bookmarkedReports.length),
        ),

        if (viewModel.isUserBookmarksPaginationLoading())
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
