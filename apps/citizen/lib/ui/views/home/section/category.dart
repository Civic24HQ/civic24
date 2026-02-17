part of '../home_view.dart';

class CategoryReports extends ViewModelWidget<HomeViewModel> {
  const CategoryReports({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    CategoryType? currentCategory;

    return AppTabs.buttoned(
      onTabChanged: (i) async {
        viewModel.onCategoryChanged(CategoryType.values[i]);
        final newCategory = CategoryType.values[i];

        if (currentCategory != null) {
          viewModel.stopRealTimeFeed(ReportFeedType.category, category: currentCategory);
        }

        currentCategory = newCategory;

        await viewModel.initCategoryFeed(newCategory);

        await viewModel.startRealTimeFeed(ReportFeedType.category, category: newCategory);
      },
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

    // Delay init to after build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.initCategoryFeed(widget.category);
    });
  }

  void _onScroll() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent - 300) {
      _viewModel.loadMoreCategory(widget.category, limit: _categoryReportsPageLimit);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getParentViewModel<HomeViewModel>(context);
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
              onTapComment: viewModel.viewComment,
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
