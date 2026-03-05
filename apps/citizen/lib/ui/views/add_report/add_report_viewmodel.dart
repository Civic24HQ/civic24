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
      if (categoryTypes.length >= 3) {
        return;
      }
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
    if (_mediaFiles.length >= 4) {
      _alertService.showErrorAlert(
        title: 'Media Limit Reached',
        message: 'You can only add up to 4 media files per report.',
      );
      return;
    }
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

  /// Uploads all selected images to Cloudinary with retry.
  ///
  /// Returns the number of images that failed to upload after all retries.
  Future<int> uploadImageToCloudinary() async {
    var failedCount = 0;
    for (final file in _mediaFiles) {
      final uploadedUrl = await _cloudinaryStorageService.uploadFileWithRetry(file: file!.imageFile, folder: 'reports');
      _log.d('Uploaded Image URL: $uploadedUrl');
      if (uploadedUrl != null) {
        imageUrlList.add(uploadedUrl);
      } else {
        failedCount++;
      }
    }
    return failedCount;
  }

  void removeMediaFile(int index) {
    _log.d('Media File Index: $index');
    _mediaFiles.removeAt(index);
    rebuildUi();
  }

  Future<void> reportSuccessful() async {
    _alertService.showSuccessAlert(
      title: 'Report Submitted',
      message: 'Your report has been successfully submitted.',
      isReport: true,
    );
    await _routerService.clearStackAndShow(MainViewRoute());
  }

  Future<void> saveReportData() async {
    if (!isFormValid) {
      await HapticFeedback.heavyImpact();
      return;
    }

    setBusy(true);

    _analyticsService.logButtonClick(kAnalyticsButtonAddReport);
    if (_mediaFiles.isNotEmpty) {
      final failedCount = await uploadImageToCloudinary();
      if (failedCount > 0) {
        _log.w('$failedCount of ${_mediaFiles.length} images failed to upload');
        _alertService.showErrorAlert(
          title: 'Failed to Create Report',
          message: 'Please check your network connection and try again.',
        );
        imageUrlList.clear();
        setBusy(false);
        return;
      }
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
