import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/home/home_viewmodel.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

part 'section/all_reports.dart';
part 'section/trending.dart';
part 'section/category.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: context.surface,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: context.primary,
        onPressed: viewModel.onAddReport,
        child: Icon(
          Icons.add,
          color: context.onPrimary,
          size: AppDimensions.size28,
        ),
      ),
      appBar: AppBar(
        toolbarHeight: AppDimensions.size64,
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.surface,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        shape: const Border(bottom: BorderSide(color: Colors.transparent)),
        title: Assets.png.civic24SplashScreenIOS.image(
          width: AppDimensions.size72,
          height: AppDimensions.size48,
        ),
      ),
      body: AppTabs.underlined(
        tabs: [
          AppTab(label: l10n.generalAllIssues, view: const AllReports()),
          AppTab(label: l10n.generalTrending, view: const TrendingReports()),
          AppTab(label: l10n.generalCategory, view: const CategoryReports()),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
