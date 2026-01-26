import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// The [FirebaseStorageService] mixin class provides common Firebase Storage
/// operations for managing file uploads and downloads.

abstract mixin class FirebaseStorageService {
  /// Logger instance for tracking events and errors.
  Logger get log;

  /// A reference to the root of Firebase Storage specified by [storageReference].
  ///
  /// This reference uses Firebase Storage's `ref` method to handle
  /// file storage operations.
  @protected
  late final Reference storageReference = FirebaseStorage.instance.ref();

  /// Uploads a file to Firebase Storage under the specified user's directory.
  ///
  /// The [file] parameter is the file to be uploaded.
  /// The [userId] parameter specifies the user directory under which the file
  /// will be stored.
  /// Returns a [bool] indicating the success of the upload operation.
  Future<bool> uploadFile({required File file, required String userId}) async {
    try {
      final fileName = file.path.split('/').last;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final uniqueFileName = '${timestamp}_$fileName';
      final storagePath = '$userId/uploads/$uniqueFileName';
      final ref = storageReference.child(storagePath);
      final uploadTask = ref.putFile(file);

      await uploadTask;
      // final downloadUrl = await snapshot.ref.getDownloadURL();

      log.i('File uploaded successfully to $storagePath');
      return true;
    } catch (e, stackTrace) {
      log.e('Could not upload file', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Retrieves a list of files uploaded by the specified user from Firebase Storage.
  ///
  /// The [userId] parameter specifies the user whose uploaded files are to be retrieved.
  /// Returns a [List<Reference>?] of the uploaded files, or `null` if no files are found
  Future<List<Reference>?> getUsersUploadedFiles({required String userId}) async {
    try {
      final storagePath = '$userId/uploads';
      final ref = storageReference.child(storagePath);
      final uploads = await ref.listAll();
      log.i('Retrieved uploaded files successfully from $storagePath');
      return uploads.items;
    } catch (e, stackTrace) {
      log.e('Could not retrieve uploaded files', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Retrieves download URLs for files uploaded by the specified user from Firebase Storage.
  ///
  /// The [userId] parameter specifies the user whose uploaded file URLs are to be retrieved.
  /// Returns a [List<String>] of download URLs for the uploaded files.
  Future<List<String>> getUsersUploadedFileUrls({required String userId}) async {
    try {
      final storagePath = '$userId/uploads';
      final ref = storageReference.child(storagePath);
      final uploads = await ref.listAll();
      final downloadUrls = <String>[];

      for (final item in uploads.items) {
        final url = await item.getDownloadURL();
        downloadUrls.add(url);
      }

      log.i('Retrieved uploaded file URLs successfully from $storagePath');
      return downloadUrls;
    } catch (e, stackTrace) {
      log.e('Could not retrieve uploaded file URLs', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
