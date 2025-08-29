part of '../home_view.dart';

class CategoryReports extends ViewModelWidget<HomeViewModel> {
  const CategoryReports({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel vm) {
    return AppTabs.buttoned(
      onTabChanged: (i) => vm.onCategoryChanged(CategoryType.values[i]),
      tabs: CategoryType.values.map((type) {
        return AppTab(
          label: type.label,
          view: _CategoryListView(category: type),
        );
      }).toList(),
    );
  }
}

class _CategoryListView extends ViewModelWidget<HomeViewModel> {
  const _CategoryListView({required this.category});
  final CategoryType category;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final fakeReportCategoryList = viewModel.fakeReportCategoryList;

    if (fakeReportCategoryList.isEmpty) {
      return const CustomScrollView(
        slivers: [SliverFillRemaining(hasScrollBody: false, child: SizedBox())],
      );
    }

    return CustomScrollView(
      // It keeps each tab’s scroll state separate
      key: ValueKey(category),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index >= fakeReportCategoryList.length) {
              return const SizedBox.shrink();
            }
            final report = fakeReportCategoryList[index];
            return AppReport(
              onTapComment: () => viewModel.viewComment(),
              reportData: report,
            );
          }, childCount: fakeReportCategoryList.length),
        ),
      ],
    );
  }
}
