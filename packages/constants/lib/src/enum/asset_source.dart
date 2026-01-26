import 'package:localization/localization.dart';

/// Specifies the source where the picked image should come from.
enum AssetSource {
  /// Opens up the device camera, letting the user to take a new picture.
  camera,

  /// Opens the user's photo gallery.
  gallery;

  String get label => switch (this) {
    camera => l10n.generalTakePicture,
    gallery => l10n.generalUploadFile,
  };
}
