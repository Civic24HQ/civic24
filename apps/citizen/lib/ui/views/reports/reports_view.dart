import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/reports/reports_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

part 'section/my_reports.dart';
part 'section/bookmarked_reports.dart';

class ReportsView extends StackedView<ReportsViewModel> {
  const ReportsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ReportsViewModel viewModel,
    Widget? child,
  ) {
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.surface,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Assets.png.civic24SplashScreenIOS.image(
          width: AppDimensions.size72,
          height: AppDimensions.size48,
        ),
        shape: const Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      body: AppTabs.underlined(
        tabs: [
          AppTab(label: l10n.featureMyReports, view: const MyReports()),
          AppTab(
            label: l10n.featureBookmarkedReports,
            view: const BookmarkedReports(),
          ),
        ],
        padding: const EdgeInsets.only(top: AppDimensions.padding8),
      ),
    );
  }

  @override
  ReportsViewModel viewModelBuilder(BuildContext context) => ReportsViewModel();
}
