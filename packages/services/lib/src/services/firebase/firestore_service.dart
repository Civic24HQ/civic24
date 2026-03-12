import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// An abstract mixin class that provides common Firestore operations
/// for managing documents and collections.
///
/// This class is intended to be extended or mixed in by other classes
/// that interact with Firestore. It includes methods for creating,
/// reading, updating, deleting, and subscribing to documents.
///
abstract mixin class FirestoreService<T> {
  /// Logger instance for tracking events and errors.
  Logger get log;

  /// Converts Firestore JSON data into a strongly typed object of type [T].
  /// Subclasses must implement this method to handle the conversion.
  T convertFromJson(Map<String, dynamic> json);

  /// Generates a new Firestore document ID within the
  /// given [collectionReference].
  ///
  /// Logs the generated document ID for debugging.
  ///
  /// Returns:
  /// - A [String] representing the new document ID.
  @protected
  String newDocId({required CollectionReference<T> collectionReference}) {
    final uid = collectionReference.doc().id;
    log.d('Generated uid "$uid"');
    return uid;
  }

  /// Creates a new document with the given [payload] in the
  /// specified [collectionReference].
  ///
  /// If a [documentId] is provided, it will be used; otherwise, a new ID
  /// is generated.
  ///
  /// The [verbose] flag controls logging verbosity.
  ///
  @protected
  Future<void> createDocument({
    required CollectionReference<T> collectionReference,
    required T payload,
    String? documentId,
    bool verbose = false,
  }) async {
    try {
      final newDocumentId = documentId ?? newDocId(collectionReference: collectionReference);
      if (verbose) {
        log.d('create() -> document with id: $newDocumentId');
      }
      await collectionReference.doc(newDocumentId).set(payload);
      if (verbose) {
        log
          ..d('Document created at ${collectionReference.path}/$newDocumentId')
          ..d('Document payload: $payload');
      }
    } catch (e, stackTrace) {
      log.e('Could not create account', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Retrieves a document by its [documentId] from the given
  /// [collectionReference].
  ///
  /// Throws:
  /// - [DocumentNotFoundException] if the document ID is empty.
  ///
  /// Returns:
  /// - The document of type [T], or `null` if not found.
  @protected
  Future<T?> findDocument({required CollectionReference<T> collectionReference, required String documentId}) async {
    log.d('find() -> documentId value "$documentId"');
    if (documentId.isEmpty) {
      throw emptyFieldException();
    }

    try {
      final doc = await collectionReference.doc(documentId).get();
      return doc.exists ? doc.data() : null;
    } catch (e, stackTrace) {
      log.e('Find serialise failed.', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Fetches all documents from the specified [collectionReference].
  ///
  /// The optional [limit] parameter restricts the number of results
  /// (default is 9999).
  ///
  /// Returns:
  /// - A [List] of documents of type [T].
  @protected
  Future<List<T>> fetchDocuments({required CollectionReference<T> collectionReference, int? limit}) async {
    log.d('fetchDocuments() -> limit: $limit');
    final collectionItems = await collectionReference.limit(limit ?? 9999).get();
    return collectionItems.docs.map<T>((e) => e.data()).toList();
  }

  /// Retrieves a list of documents based on a custom Firestore [Query].
  ///
  /// Returns:
  /// - A [List] of documents of type [T].
  @protected
  Future<List<T>> fetchDocumentsWithQuery({required Query<T> query}) async {
    log.d('fetchDocumentsWithQuery() -> listQuery: ${query.parameters}');
    final collectionItems = await query.get();
    log.i('Fetched ${collectionItems.docs.length} documents');
    return collectionItems.docs.map<T>((e) => e.data()).toList();
  }

  /// Retrieves the raw [QuerySnapshot] for a given Firestore [Query].
  ///
  /// This method can be used by services that need access to the
  /// underlying document snapshots (for example, to implement
  /// cursor-based pagination using `startAfterDocument`).
  @protected
  Future<QuerySnapshot<T>> fetchQuerySnapshot({required Query<T> query}) async {
    log.d('fetchQuerySnapshot() -> listQuery: ${query.parameters}');
    final collectionItems = await query.get();
    log.i('Fetched ${collectionItems.docs.length} documents');
    return collectionItems;
  }

  /// Updates an entire document in the specified [collectionReference] using
  /// [documentId].
  ///
  /// The existing document will be merged with the new [payload] data.
  ///
  /// Throws:
  /// - [DocumentNotFoundException] if the documentId is empty.
  @protected
  Future<void> updateDocument({
    required CollectionReference<T> collectionReference,
    required String documentId,
    required T payload,
  }) async {
    log.d('update() -> documentId value "$documentId"');
    if (documentId.isEmpty) {
      throw emptyFieldException();
    }

    final options = SetOptions(merge: true);
    try {
      await collectionReference.doc(documentId).set(payload, options);
    } catch (e, stackTrace) {
      log.e('update error: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Updates specific fields of a document in the [collectionReference].
  ///
  /// The provided [payload] contains only the fields that need to be updated.
  ///
  /// Throws:
  /// - [DocumentNotFoundException] if the documentId is empty.
  @protected
  Future<void> updateOnlyDocument({
    required CollectionReference<T> collectionReference,
    required String documentId,
    required Map<String, Object?> payload,
  }) async {
    log.d('updateOnly() ->  documentId "$documentId" | payload: $payload');
    if (documentId.isEmpty) {
      throw emptyFieldException();
    }

    try {
      await collectionReference.doc(documentId).update(payload);
    } catch (e, stackTrace) {
      log.e('Error only updating', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Deletes a document from the given [collectionReference] using
  /// [documentId].
  ///
  /// Throws:
  /// - [DocumentNotFoundException] if the documentId is empty.
  @protected
  Future<void> deleteDocument({required CollectionReference<T> collectionReference, required String documentId}) async {
    log.d('delete() -> documentId: "$documentId"');
    if (documentId.isEmpty) {
      throw emptyFieldException();
    }

    try {
      await collectionReference.doc(documentId).delete();
      log.t('Successfully deleted document: $documentId');
    } catch (e, stackTrace) {
      log.e('delete error: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Subscribes to real-time updates for a single document in
  /// [collectionReference].
  ///
  /// Throws:
  /// - [DocumentNotFoundException] if the documentId is empty.
  ///
  /// Returns:
  /// - A [Stream] emitting the updated document data of type [T].
  @protected
  Stream<T?> subscribeToDocument({required CollectionReference<T> collectionReference, required String documentId}) {
    log.d('subscribeToDocument() -> documentId: "$documentId"');
    if (documentId.isEmpty) {
      throw emptyFieldException();
    }
    return collectionReference.doc(documentId).snapshots().map((s) => s.data());
  }

  /// Subscribes to real-time updates for an entire collection.
  ///
  /// The optional [limit] parameter restricts the number of results
  /// (default is 9999).
  ///
  /// Returns:
  /// - A [Stream] emitting a list of documents of type [T].
  @protected
  Stream<List<T>> subscribeToList({required CollectionReference<T> collectionReference, int? limit}) {
    log.d('subscribeToList() -> limit: $limit');
    final snapshots = collectionReference.limit(limit ?? 9999).snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
  }

  /// Subscribes to real-time updates for a collection with a custom [Query].
  ///
  /// Returns:
  /// - A [Stream] emitting a list of documents of type [T].
  @protected
  Stream<List<T>> subscribeToListWithQuery({required Query<T> query, int? limit}) {
    log.d('subscribeToListWithQuery() -> limit: $limit');
    return query.limit(limit ?? 9999).snapshots().map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
  }

  /// Subscribes to real-time updates for an entire collection with a custom [Query]
  ///
  /// The optional [limit] parameter restricts the number of results
  /// (default is 9999).
  ///
  /// Returns:
  /// - A [Stream] emitting a [QuerySnapshot] of type [T].
  @protected
  Stream<QuerySnapshot<T>> subscribeToSnapshotWithQuery({required Query<T> query, int? limit}) {
    log.d('subscribeToQuerySnapshot() -> limit: $limit');
    final snapshots = query.limit(limit ?? 9999).snapshots(includeMetadataChanges: true);
    return snapshots;
  }

  /// Creates an exception for missing or empty document IDs.
  ///
  /// This is a utility method used in multiple validation checks.
  ///
  /// Returns:
  /// - A [DocumentNotFoundException] indicating the missing field.
  @protected
  static DocumentNotFoundException emptyFieldException({String field = 'documentId'}) {
    return DocumentNotFoundException(message: 'The $field is empty');
  }
}

/// Exception for handling cases where a document is not found.
class DocumentNotFoundException implements Exception {
  DocumentNotFoundException({required this.message});
  final String message;

  @override
  String toString() => 'DocumentNotFoundException: $message';
}
