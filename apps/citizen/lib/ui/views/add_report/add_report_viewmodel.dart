import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:citizen/ui/views/add_report/add_report_view.form.dart';
import 'package:constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class AddReportViewModel extends FormViewModel {
  final _log = getLogger('AddReportViewModel');
  final _routerService = locator<RouterService>();
  final _userService = locator<UserService>();
  final _alertService = locator<AlertService>();
  final _reportService = locator<ReportService>();
  final _dialogService = locator<DialogService>();
  final _mediaService = locator<MediaService>();
  final _analyticsService = locator<AnalyticsService>();
  final _cloudinaryStorageService = locator<CloudinaryStorageService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService, _reportService];

  String get user => _userService.user!.id;
  List<Report> get reportList => _reportService.reportList;

  int get totalSteps => 3;

  int _currentStep = 1;
  int get currentStep => _currentStep;

  bool get isLastStep => _currentStep == totalSteps;

  bool get isSaveBusy => isBusy && _currentStep == totalSteps;

  ReportData _reportData = ReportData.empty();
  ReportData get reportData => _reportData;

  bool isCategoryTypeSelected(CategoryType categoryType) => _reportData.categoryTypes.contains(categoryType);

  List<CategoryType> get categoryTypes => _reportData.categoryTypes;

  final List<ProcessedImage?> _mediaFiles = [];
  List<ProcessedImage?> get mediaFiles => _mediaFiles;

  final imageUrlList = <String>[];

  final MediaFile _mediaUploadFile = MediaFile();
  MediaFile get mediaUploadFile => _mediaUploadFile;

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

  Future<void> pickImageWithSourceDialog() async {
    final response = await _dialogService.showCustomDialog(variant: DialogType.uploadMedia, barrierDismissible: true);

    if (response == null || response.data == null) {
      _log.d('No asset source selected');
      return;
    }

    if (response.data is AssetSource) {
      if (response.data == AssetSource.camera) {
        final newImageFile = await _mediaService.pickImageFromCamera();
        if (newImageFile == null) {
          _log.d('No image file selected from camera');
          return;
        }
        _mediaFiles.add(newImageFile);
        rebuildUi();
      } else if (response.data == AssetSource.gallery) {
        final newImageFileList = await _mediaService.pickImagesFromGallery();
        if (newImageFileList.isEmpty) {
          _log.d('No image files selected from gallery');
          return;
        }

        _mediaFiles.addAll(newImageFileList);
        rebuildUi();
      } else {
        _log.d('Unsupported asset source: ${response.data}');
        return;
      }
    } else {
      _log.d('Invalid asset source type: ${response.data.runtimeType}');
      return;
    }
  }

  Future<void> uploadImageToCloudinary() async {
    for (final file in _mediaFiles) {
      final uploadedUrl = await _cloudinaryStorageService.uploadFile(file: file!.imageFile, folder: 'reports');
      _log.d('Uploaded Image URL: $uploadedUrl');
      if (uploadedUrl != null) {
        imageUrlList.add(uploadedUrl);
      }
    }
  }

  void removeMediaFile(int index) {
    _log.d('Media File Index: $index');
    _mediaFiles.removeAt(index);
    rebuildUi();
  }

  Future<void> reportSuccessful() async {
    _alertService.showSuccessAlert(title: 'Report Submitted', message: 'Your report has been successfully submitted.');
    await _routerService.clearStackAndShow(MainViewRoute());
  }

  Future<void> saveReportData() async {
    if (!isFormValid) {
      await HapticFeedback.heavyImpact();
      return;
    }

    setBusy(true);

    _analyticsService.logButtonClick(kAnalyticsButtonAddReport);
    if (imageUrlList.isNotEmpty) {
      await uploadImageToCloudinary();
    }
    _log.d('Image URLs: $imageUrlList');

    final newReportData = ReportData(
      userId: _userService.user!.id,
      categoryTypes: _reportData.categoryTypes,
      content: contentValue!,
      firstName: _userService.user!.firstName,
      lastName: _userService.user!.lastName,
      country: _userService.user!.country,
      state: _userService.user!.state,
      reportId: '',
      likeCount: 0,
      dislikeCount: 0,
      commentCount: 0,
      bookmarkCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      media: imageUrlList,
    );
    final newReport = Report(reportData: newReportData);
    await runBusyFuture(_reportService.addReport(newReport));

    setBusy(false);
    await reportSuccessful();
  }
}
