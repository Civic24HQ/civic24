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
  Widget builder(BuildContext context, ReportsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: context.surface,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: context.primary,
        onPressed: viewModel.onAddReport,
        child: Icon(Icons.add, color: context.onPrimary, size: AppDimensions.size28),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.transparent)),
        automaticallyImplyLeading: false,
        title: Text(l10n.featureReports),
      ),
      body: AppTabs.underlined(
        tabs: [
          AppTab(label: l10n.featureMyReports, view: const MyReports()),
          AppTab(label: l10n.featureBookmarkedReports, view: const BookmarkedReports()),
        ],
      ),
    );
  }

  @override
  ReportsViewModel viewModelBuilder(BuildContext context) => ReportsViewModel();
}
