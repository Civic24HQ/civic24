import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/home/home_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: context.surface,
      appBar: AppBar(
        toolbarHeight: AppDimensions.size64,
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.surface,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        shape: const Border(bottom: BorderSide(color: Colors.transparent)),
        title: Assets.png.civic24SplashScreenIOS.image(width: AppDimensions.size72, height: AppDimensions.size48),
      ),
      body: AppTabs(
        tabs: [
          AppTab(
            label: l10n.generalAllIssues,
            view: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AppPost(onTapComment: () => viewModel.viewComment(), postData: viewModel.postList[index]);
                  }, childCount: viewModel.postList.length),
                ),
              ],
            ),
          ),
          AppTab(
            label: l10n.generalTrending,
            view: Center(child: Text(l10n.generalTrending)),
          ),
          AppTab(
            label: l10n.generalCategory,
            view: Center(child: Text(l10n.generalCategory)),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
