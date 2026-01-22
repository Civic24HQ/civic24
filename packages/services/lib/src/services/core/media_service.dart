import 'dart:io';

import 'package:constants/constants.dart';
import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:models/utils/image_metadata.dart';
import 'package:services/services.dart';
import 'package:utils/utils.dart';

/// A service for handling media-related tasks like image or video picking, cropping,
/// compressing, and extracting metadata.
class MediaService {
  final _log = getLogger('MediaService');
  // final _dialogService = serviceLocator<DialogService>();
  final _alertService = serviceLocator<AlertService>();
  final _permissionService = serviceLocator<PermissionService>();

  final _imagePicker = ImagePicker();
  final _imageCropper = ImageCropper();

  /// Prompts the user to pick an image from the camera or gallery.
  ///
  /// Returns the selected image as a [File], or null if the user cancels or
  /// an error occurs.
  @visibleForTesting
  Future<File?> pickImage({required AssetSource source}) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source == AssetSource.camera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } on PlatformException catch (exception, stackTrace) {
      if (exception.code == 'photo_access_denied' || exception.code == 'camera_access_denied') {
        _log.w('User denied access to the camera or photo library');
        await _permissionService.requestPhotosPermission();
        return null;
      }
      _log.e('Error picking image', error: exception, stackTrace: stackTrace);
      _alertService.showErrorAlert(
        title: 'Image Selection Failed',
        message:
            'We could not access the image. This may be due to permission issues, file corruption, or the selected image being unsupported. Please try again or choose a different image.',
      );

      return null;
    } catch (e) {
      _log.e('Error picking image: $e');
      _alertService.showErrorAlert(
        title: 'Image Selection Failed',
        message:
            'We could not access the image. This may be due to permission issues, file corruption, or the selected image being unsupported. Please try again or choose a different image.',
      );
      return null;
    }
  }

  /// Prompts the user to pick multiple images from the gallery.
  ///
  /// Returns a list of selected images as [File]s, or an empty list
  /// if the user cancels or an error occurs.
  @visibleForTesting
  Future<List<File?>> pickMultiImage() async {
    try {
      final pickedFiles = await _imagePicker.pickMultiImage(maxWidth: 1000, maxHeight: 1000);
      if (pickedFiles.isEmpty) {
        return [];
      }
      return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    } on PlatformException catch (exception, stackTrace) {
      if (exception.code == 'photo_access_denied') {
        _log.w('User denied access to the photo library');
        await _permissionService.requestPhotosPermission();
        return [];
      }
      _log.e('Error picking images from gallery', error: exception, stackTrace: stackTrace);
      _alertService.showErrorAlert(
        title: 'Image Selection Failed',
        message:
            'We could not access the images. This may be due to permission issues, file corruption, or the selected images being unsupported. Please try again or choose different images.',
      );
      return [];
    } catch (e) {
      _log.e('Error picking images from gallery: $e');
      _alertService.showErrorAlert(
        title: 'Image Selection Failed',
        message:
            'We could not access the images. This may be due to permission issues, file corruption, or the selected images being unsupported. Please try again or choose different images.',
      );
      return [];
    }
  }

  /// Extracts metadata such as timestamp, location, and device info
  /// from the given [pickedFile].
  ///
  /// Returns an [ImageMetadata] object. If metadata is unavailable or an
  /// error occurs, returns empty [ImageMetadata].
  @visibleForTesting
  Future<ImageMetadata> extractImageMetadata(File pickedFile) async {
    try {
      final imageBytes = await pickedFile.readAsBytes();
      final tags = await readExifFromBytes(imageBytes);
      if (tags.isEmpty) {
        _log.d('No EXIF data found in image');
        return ImageMetadata();
      }

      final creationDate = _getExifDate(tags);
      final deviceMake = tags['Image Make']?.printable;
      final deviceModel = tags['Image Model']?.printable;
      final orientation = tags['Image Orientation']?.printable;

      double? latitude;
      double? longitude;

      if (tags.containsKey('GPS GPSLatitude') && tags.containsKey('GPS GPSLongitude')) {
        latitude = _convertToDecimal(tags['GPS GPSLatitude']!.values as List, tags['GPS GPSLatitudeRef']?.printable);
        longitude = _convertToDecimal(tags['GPS GPSLongitude']!.values as List, tags['GPS GPSLongitudeRef']?.printable);
      }

      return ImageMetadata(
        creationDate: creationDate,
        latitude: latitude,
        longitude: longitude,
        deviceMake: deviceMake,
        deviceModel: deviceModel,
        orientation: orientation,
      );
    } catch (e) {
      return ImageMetadata();
    }
  }

  /// Parses EXIF tags to extract a valid [DateTime] object.
  ///
  /// Handles various possible date-related EXIF tags and formats.
  DateTime? _getExifDate(Map<String, IfdTag> tags) {
    const possibleDateTags = [
      'Image DateTime',
      'Exif DateTimeOriginal',
      'Exif DateTimeDigitized',
      'DateTimeOriginal',
      'DateTimeDigitized',
      'DateTime',
    ];

    for (final tag in possibleDateTags) {
      final value = tags[tag]?.printable.trim();
      if (value != null && value.isNotEmpty && value != 'null') {
        try {
          return DateFormat('yyyy:MM:dd HH:mm:ss').parse(value);
        } on FormatException catch (e) {
          _log
            ..e('Error parsing date from EXIF data: $e')
            ..d('Invalid date format for tag: $tag, value: $value');
        }
      } else {
        _log.d('No valid date found in EXIF data for tag: $tag');
      }
    }

    return null; // No valid date found
  }

  /// Converts GPS coordinates from EXIF format to decimal degrees.
  ///
  /// Takes into account directional reference (`N`, `S`, `E`, `W`).
  double _convertToDecimal(List<dynamic> values, String? ref) {
    double toDouble(dynamic val) {
      try {
        if (val is num) return val.toDouble();

        // Attempt to handle Rational-like objects
        if (val is Map<String, dynamic> && val.containsKey('numerator') && val.containsKey('denominator')) {
          return (val['numerator'] as num).toDouble() / (val['denominator'] as num).toDouble();
        }

        return double.tryParse(val.toString()) ?? 0.0;
      } catch (e) {
        return 0;
      }
    }

    final degrees = toDouble(values[0]);
    final minutes = toDouble(values[1]);
    final seconds = toDouble(values[2]);

    var decimal = degrees + (minutes / 60) + (seconds / 3600);
    if (ref == 'S' || ref == 'W') decimal *= -1;
    return decimal;
  }

  /// Crops the given image file to a square aspect ratio using a UI prompt.
  ///
  /// Returns the cropped image file, or null if cancelled or an error occurs.
  @visibleForTesting
  Future<File?> cropImage(File imageFile) async {
    try {
      final croppedFile = await _imageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );
      return croppedFile != null ? File(croppedFile.path) : null;
    } catch (e) {
      _log.e('Error cropping image: $e');
      return null;
    }
  }

  /// Handles the full process of picking, extracting metadata, cropping,
  /// and returning the result as a [ProcessedImage].
  ///
  /// Returns null if any step is cancelled or fails.
  Future<ProcessedImage?> pickImageFromCamera() async {
    // if (kDebugMode) {
    //   _log.d('Picking image from source: $source');
    //   return ProcessedImage(imageFile: File('path/to/image.jpg'), metadata: ImageMetadata(), fileSize: 123456);
    // }
    final pickedFile = await pickImage(source: AssetSource.camera);
    if (pickedFile == null) {
      _log.d('No image file selected');
      return null;
    }

    final metadata = await extractImageMetadata(pickedFile);
    _log.d('Image metadata: $metadata');

    final croppedFile = await cropImage(pickedFile);
    if (croppedFile == null) {
      _log.d('No cropped image file selected');
      return null;
    }

    final fileSize = await croppedFile.length();
    _log.d('Cropped image file size: $fileSize bytes');

    return ProcessedImage(imageFile: croppedFile, metadata: metadata, fileSize: fileSize);
  }

  /// Handles the full process of picking multiple images from the gallery,
  /// extracting metadata, cropping and returning the results as a list of
  /// [ProcessedImage]s.
  ///
  /// Returns an empty list if no images are selected or an error occurs.
  Future<List<ProcessedImage?>> pickImagesFromGallery() async {
    // if (kDebugMode) {
    //   _log.d('Picking multiple images from gallery');
    //   return [
    //     ProcessedImage(imageFile: File('path/to/image1.jpg'), metadata: ImageMetadata(), fileSize: 123456),
    //     ProcessedImage(imageFile: File('path/to/image2.jpg'), metadata: ImageMetadata(), fileSize: 234567),
    //   ];
    // }
    final pickedFiles = await pickMultiImage();
    if (pickedFiles.isEmpty) {
      _log.d('No image file selected');
      return [];
    }

    final processedImages = <ProcessedImage?>[];
    for (final pickedFile in pickedFiles) {
      if (pickedFile == null) {
        _log.d('One of the selected image files is null, skipping');
        continue;
      }
      final file = File(pickedFile.path);

      final metadata = await extractImageMetadata(file);
      _log.d('Image metadata: $metadata');

      // final croppedFile = await cropImage(file);
      // if (croppedFile == null) {
      //   _log.d('No cropped image file selected');
      //   return [];
      // }

      // final fileSize = await croppedFile.length();
      final fileSize = await file.length();
      _log.d('Cropped image file size: $fileSize bytes');

      processedImages.add(ProcessedImage(imageFile: file, metadata: metadata, fileSize: fileSize));
    }
    return processedImages;
  }

  /// Opens a dialog for the user to choose between camera and gallery,
  /// and then processes the image via [pickImage].
  ///
  /// Returns null if the user cancels the dialog or an error occurs.
  // Future<ProcessedImage?> pickImageWithSourceDialog() async {
  //   final response = await _dialogService.showCustomDialog(variant: DialogType.uploadFile, barrierDismissible: true);

  //   if (response == null || response.data == null) {
  //     _log.d('No asset source selected');
  //     return null;
  //   }

  //   if (response.data is AssetSource) {
  //     return pickImageFromSource(response.data as AssetSource);
  //   } else {
  //     _log.d('Invalid asset source type: ${response.data.runtimeType}');
  //     return null;
  //   }
  // }

  /// Compresses an image file to reduce its size to below 512KB if possible.
  ///
  /// If the image is already under the limit, it is returned as-is.
  /// If compression fails or the file is invalid, returns null.
  Future<File?> compressImage(File imageFile) async {
    if (!imageFile.existsSync()) {
      _log.e('Image file does not exist: ${imageFile.path}');
      return null;
    }

    // Check if compressed image size is less than 512KB
    if ((imageFile.readAsBytesSync().lengthInBytes) / 1024 <= 512) {
      return imageFile;
    }

    final absolutePath = imageFile.absolute.path;
    File? compressedImage;
    _log.d('Compressing image absolute path: $absolutePath');

    try {
      final compressedFile = await FlutterImageCompress.compressWithFile(
        absolutePath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      compressedImage = File.fromRawPath(compressedFile!);

      // Compress the compressed image again if it's still larger than 512KB
      compressedImage = await compressImage(compressedImage);
    } catch (e) {
      _log.e('Error compressing image: $e');
      return null;
    }

    if (compressedImage != null && compressedImage.existsSync()) {
      _log.d('Compressed image size: ${compressedImage.lengthSync()} bytes');
      return compressedImage;
    } else {
      _log.e('Failed to compress image');
      return null;
    }
  }
}
