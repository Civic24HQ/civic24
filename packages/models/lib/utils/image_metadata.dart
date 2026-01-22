import 'dart:io';

/// Holds metadata information extracted from an image file.
class ImageMetadata {
  ImageMetadata({
    this.creationDate,
    this.latitude,
    this.longitude,
    this.deviceMake,
    this.deviceModel,
    this.orientation,
  });

  /// The date and time the image was captured, if available.
  final DateTime? creationDate;

  /// The latitude where the image was captured, if available.
  final double? latitude;

  /// The longitude where the image was captured, if available.
  final double? longitude;

  /// The manufacturer of the device that captured the image.
  final String? deviceMake;

  /// The model of the device that captured the image.
  final String? deviceModel;

  /// The image orientation (e.g., normal, rotated).
  final String? orientation;
}

/// Represents a processed image along with its metadata and file size.
class ProcessedImage {
  ProcessedImage({required this.imageFile, required this.metadata, this.fileSize = 0});

  /// The processed (e.g., cropped, compressed) image file.
  final File imageFile;

  /// Metadata extracted from the image, such as location and device info.
  final ImageMetadata metadata;

  /// The size of the image file in bytes.
  final int fileSize;

  /// Returns the file name of the image file.
  String get fileName {
    var path = imageFile.path;

    // Normalize backslashes (for Windows, web, etc.)
    path = path.replaceAll(r'\\', '/');

    // Remove trailing slash if any
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }

    // Get the last part
    return path.split('/').last;
  }

  /// Returns the file size as a formatted string (e.g., 2.1 MB).
  String get fileSizeFormatted {
    if (fileSize == 0) return '0 bytes';
    const units = ['bytes', 'KB', 'MB', 'GB', 'TB'];
    var size = fileSize.toDouble();
    var unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    final rounded = size < 10 ? size.toStringAsFixed(2) : size.toStringAsFixed(0);
    return '$rounded ${units[unitIndex]}';
  }
}
