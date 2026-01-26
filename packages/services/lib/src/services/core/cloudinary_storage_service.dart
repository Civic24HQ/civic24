import 'dart:convert';
import 'dart:io';

import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:utils/utils.dart';

class CloudinaryStorageService {
  final _log = getLogger('CloudinaryStorageService');

  @protected
  static const String cloudName = EnvironmentConstants.cloudinaryCloudName;

  @protected
  static const String uploadPreset = EnvironmentConstants.cloudinaryUploadPreset;

  @protected
  String get uploadUrl => 'https://api.cloudinary.com/v1_1/$cloudName/auto/upload';

  /// Uploads a File to Cloudinary and returns the secure URL.
  ///
  /// [file]: The file to upload.
  /// [folder]: Optional folder in Cloudinary to upload the file to.
  /// [publicIdPrefix]: Optional prefix for the public_id of the uploaded file.
  /// Returns the secure URL of the uploaded file, or null if the upload fails.
  Future<String?> uploadFile({required File file, String? folder, String? publicIdPrefix}) async {
    try {
      final fileExists = file.existsSync();
      if (!fileExists) {
        _log.w('File not found: ${file.path}');
        return null;
      }

      final mime = lookupMimeType(file.path);
      final mimeTypeData = mime?.split('/');

      final filename = _generatePublicId(file.path.split('/').last, prefix: publicIdPrefix);

      // Cloudinary upload request
      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['upload_preset'] = uploadPreset
        ..fields['public_id'] = filename
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
            filename: filename,
            contentType: mimeTypeData != null ? MediaType(mimeTypeData[0], mimeTypeData[1]) : null,
          ),
        );

      if (folder != null && folder.isNotEmpty) {
        request.fields['folder'] = folder.replaceAll(RegExp(r'^/+|/+$'), '');
      }

      final streamedResponse = await request.send();
      final result = await http.Response.fromStream(streamedResponse);

      if (streamedResponse.statusCode == 200) {
        final data = jsonDecode(result.body) as Map<String, dynamic>;
        return data['secure_url'] as String?;
      }
      _log.w('Upload failed: ${result.body}');
      return null;
    } catch (e, st) {
      _log.e('Upload error', error: e, stackTrace: st);
      return null;
    }
  }

  /// Uploads an XFile. Falls back to byte upload when needed (e.g., web).
  Future<String?> uploadXFile({required XFile xfile, String? folder, String? publicIdPrefix}) async {
    try {
      final path = xfile.path;

      if (path.isNotEmpty &&
          (Platform.isAndroid || Platform.isIOS || Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
        return uploadFile(file: File(path), folder: folder, publicIdPrefix: publicIdPrefix);
      }

      final bytes = await xfile.readAsBytes();
      final filename = _generatePublicId(xfile.name, prefix: publicIdPrefix);

      return _uploadBytes(
        bytes: bytes,
        filename: filename,
        mimeType: lookupMimeType(xfile.name) ?? 'application/octet-stream',
        folder: folder,
      );
    } catch (e, st) {
      _log.e('Upload XFile error', error: e, stackTrace: st);
      return null;
    }
  }

  /// Uploads bytes to Cloudinary.
  @protected
  Future<String?> _uploadBytes({
    required List<int> bytes,
    required String filename,
    required String mimeType,
    String? folder,
  }) async {
    try {
      final mimeParts = mimeType.split('/');

      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['upload_preset'] = uploadPreset
        ..fields['public_id'] = filename
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: filename,
            contentType: MediaType(mimeParts[0], mimeParts[1]),
          ),
        );

      if (folder != null && folder.isNotEmpty) {
        request.fields['folder'] = folder.replaceAll(RegExp(r'^/+|/+$'), '');
      }

      final streamedResponse = await request.send();
      final result = await http.Response.fromStream(streamedResponse);

      if (streamedResponse.statusCode == 200) {
        final data = jsonDecode(result.body) as Map<String, dynamic>;
        return data['secure_url'] as String?;
      }

      _log.w('Upload bytes failed: ${result.body}');
      return null;
    } catch (e, st) {
      _log.e('_uploadBytes error', error: e, stackTrace: st);
      return null;
    }
  }

  /// Generates a unique Cloudinary public_id.
  @protected
  String _generatePublicId(String name, {String? prefix}) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final sanitized = name.replaceAll(RegExp(r'\s+'), '_');
    final p = prefix != null && prefix.isNotEmpty ? '${prefix}_' : '';
    return '$p${ts}_$sanitized';
  }
}
