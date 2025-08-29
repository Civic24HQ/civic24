import 'package:citizen/ui/views/reports/reports_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class ReportsView extends StackedView<ReportsViewModel> {
  const ReportsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ReportsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius12),
        backgroundColor: context.primary,
        onPressed: viewModel.onAddReport,
        child: Icon(Icons.add, color: context.onPrimary, size: AppDimensions.size28),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: const Center(child: Text('Reports View')),
      ),
    );
  }

  @override
  ReportsViewModel viewModelBuilder(BuildContext context) => ReportsViewModel();
}
