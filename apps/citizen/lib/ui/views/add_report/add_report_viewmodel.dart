import 'package:citizen/app/app.locator.dart';
import 'package:citizen/ui/views/add_report/add_report_view.form.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddReportViewModel extends FormViewModel {
  final _routerService = locator<RouterService>();

  int get totalSteps => 3;

  int _currentStep = 1;
  int get currentStep => _currentStep;

  bool get isLastStep => _currentStep == totalSteps;

  bool get isSaveBusy => isBusy && _currentStep == totalSteps;

  ReportData _reportData = ReportData.empty();
  ReportData get reportData => _reportData;

  bool isCategoryTypeSelected(CategoryType categoryType) => _reportData.categoryTypes.contains(categoryType);

  List<CategoryType> get categoryTypes => _reportData.categoryTypes;

  bool get notValidCategory => categoryTypes.isEmpty;
  bool get notValidContent => contentValue == null;
  bool get notValidMedia => false;

  bool get canContinue {
    return switch (_currentStep) {
      1 => notValidCategory,
      2 => notValidContent,
      3 => notValidMedia,
      _ => false,
    };
  }

  Future<void> init(int currentStep) async {
    _currentStep = currentStep;

    final categoryTypes = <String>[];
    if (categoryTypes.isEmpty) {
      // If the selected category types are empty, means the user has not
      // selected any category types yet. So we need to use the default values.
      return;
    }
    rebuildUi();
  }

  void toggleCategoryType(CategoryType categoryType, {bool isSelected = false}) {
    final categoryTypes = List<CategoryType>.from(_reportData.categoryTypes);
    if (isSelected) {
      categoryTypes.add(categoryType);
    } else {
      categoryTypes.remove(categoryType);
    }
    _reportData = _reportData.copyWith(categoryTypes: categoryTypes);
    rebuildUi();
  }

  void previousStep() {
    if (currentStep == 1) {
      _routerService.back();
      return;
    }

    if (_currentStep > 1) {
      _currentStep--;
      rebuildUi();
    }
  }

  void nextStep() {
    if (_currentStep == 2) {
      if (!isFormValid) {
        return;
      }
    }

    if (_currentStep < totalSteps) {
      _currentStep++;
      rebuildUi();
    }
  }

  Future<void> saveReportData() async {}
}
