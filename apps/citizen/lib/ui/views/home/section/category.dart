part of '../home_view.dart';

class CategoryReports extends ViewModelWidget<HomeViewModel> {
  const CategoryReports({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return AppTabs.buttoned(
      onTabChanged: (i) => viewModel.onCategoryChanged(CategoryType.values[i]),
      tabs: CategoryType.values.map((type) {
        return AppTab(
          label: type.label,
          view: _CategoryListView(category: type),
        );
      }).toList(),
    );
  }
}

class _CategoryListView extends StatefulWidget {
  const _CategoryListView({required this.category});
  final CategoryType category;

  @override
  State<_CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<_CategoryListView> {
  final _controller = ScrollController();
  static const int _categoryReportsPageLimit = 12;

  HomeViewModel get viewModel => getParentViewModel<HomeViewModel>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);

    // Delay init to after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel
        ..initCategoryFeed(widget.category)
        ..startRealTimeFeed(ReportFeedType.category, category: widget.category);
    });
  }

  void _onScroll() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent - 300) {
      viewModel.loadMoreCategory(widget.category, limit: _categoryReportsPageLimit);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    viewModel.stopRealTimeFeed(ReportFeedType.category, category: widget.category);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryReports = viewModel.getCategoryReports(widget.category);

    if (viewModel.isCategoryInitialLoading(widget.category)) {
      return CustomScrollView(
        key: ValueKey(widget.category),
        slivers: [SliverList(delegate: SliverChildBuilderDelegate((_, __) => const AppReportShimmer(), childCount: 6))],
      );
    }

    return CustomScrollView(
      key: ValueKey(widget.category),
      controller: _controller,
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: () => viewModel.refreshCategory(widget.category)),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final report = categoryReports[index];
            return AppReport(
              onTapLike: () => viewModel.likeReport(report),
              onTapDislike: () => viewModel.dislikeReport(report),
              onTapBookmark: () => viewModel.bookmarkReport(report),
              onTapComment: () => viewModel.viewComment(),
              report: report,
            );
          }, childCount: categoryReports.length),
        ),
        if (viewModel.isCategoryPaginationLoading(widget.category))
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
