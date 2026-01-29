import 'package:citizen/ui/views/add_report/add_report_view.form.dart';
import 'package:citizen/ui/views/add_report/add_report_viewmodel.dart';
import 'package:components/components.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

part 'steps/report_category.dart';
part 'steps/report_content.dart';
part 'steps/report_media.dart';

@FormView(
  autoTextFieldValidation: false,
  fields: [FormTextField(name: 'content', validator: Validator.validateEmpty)],
)
class AddReportView extends StackedView<AddReportViewModel>
    with $AddReportView {
  const AddReportView({this.currentStep = 1, super.key});
  final int currentStep;

  @override
  Widget builder(
    BuildContext context,
    AddReportViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing: viewModel.anyObjectsBusy,
        child: Scaffold(
          appBar: AppBar(
            shape: Border(bottom: BorderSide(color: context.neutralLowest)),
            centerTitle: true,
            title: Text(l10n.featureAddReport),
          ),
          body: SafeArea(
            child: Padding(
              padding: AppEdgeInsets.adaptiveHorizontalPadding(context),
              child: Column(
                children: [
                  AppSpacing.large,
                  Padding(
                    padding: AppEdgeInsets.horizontalPadding4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Step ${viewModel.currentStep} of ${viewModel.totalSteps}',
                        style: context.titleMedium,
                      ),
                    ),
                  ),
                  AppSpacing.standard,
                  PageProgressBar(
                    currentPage: viewModel.currentStep,
                    totalPages: viewModel.totalSteps,
                  ),
                  AppSpacing.large,
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Offstage(
                          offstage: viewModel.currentStep != 1,
                          child: const ReportCategory(),
                        ),
                        Offstage(
                          offstage: viewModel.currentStep != 2,
                          child: ReportContent(
                            contentController: contentController,
                            contentFocusNode: contentFocusNode,
                            errorText: viewModel.contentValidationMessage,
                          ),
                        ),
                        Offstage(
                          offstage: viewModel.currentStep != 3,
                          child: const ReportMedia(),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.medium,
                  Row(
                    children: [
                      if (viewModel.currentStep > 1) ...[
                        Expanded(
                          child: SecondaryButton(
                            title: l10n.generalPrevious,
                            onTap: viewModel.previousStep,
                          ),
                        ),
                        AppSpacing.normal,
                      ],
                      Expanded(
                        child: PrimaryButton(
                          title: viewModel.isLastStep
                              ? l10n.generalSubmit
                              : l10n.generalContinue,
                          disabled: viewModel.canContinue,
                          isBusy: viewModel.isSaveBusy,
                          onTap: viewModel.isLastStep
                              ? viewModel.saveReportData
                              : viewModel.nextStep,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.large,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(AddReportViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.init(currentStep);
  }

  @override
  void onDispose(AddReportViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  AddReportViewModel viewModelBuilder(BuildContext context) =>
      AddReportViewModel();
}
