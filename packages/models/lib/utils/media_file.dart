enum MediaStatus { idle, uploading, success, failed }

class MediaFile {
  MediaFile({
    this.hint,
    this.fileName = '',
    this.cloudStorageUrl = '',
    this.size = 0,
    this.status = MediaStatus.idle,
    this.progress = 0.0,
    this.maxSize = 15,
    this.dateUploaded,
  });

  final String? hint;
  final String fileName;
  final String cloudStorageUrl;
  final int size;
  final MediaStatus status;
  final double progress;
  final int maxSize;
  final DateTime? dateUploaded;

  MediaFile copyWith({
    String? fileName,
    String? cloudStorageUrl,
    int? size,
    MediaStatus? status,
    double? progress,
    DateTime? dateUploaded,
  }) {
    return MediaFile(
      fileName: fileName ?? this.fileName,
      cloudStorageUrl: cloudStorageUrl ?? this.cloudStorageUrl,
      size: size ?? this.size,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      dateUploaded: dateUploaded ?? this.dateUploaded,
    );
  }

  bool get isSuccess => status == MediaStatus.success;
}
