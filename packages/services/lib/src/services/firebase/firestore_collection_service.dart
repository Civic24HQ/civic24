import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:services/src/services/firebase/firestore_service.dart';

/// A base service class for interacting with a Firestore collection.
///
/// This class extends [FirestoreService] and provides high-level methods for
/// performing CRUD operations on a Firestore collection of type [T].
/// It uses Firestore's `withConverter` to handle serialization and
/// deserialization.
///
/// To use this class, extend it and define the [collectionPath] for
/// the specific Firestore collection.
///
/// Example usage:
/// ```dart
/// class UserService extends FirestoreService<User> {
///   @override
///   Logger get log => Logger();
///
///   @override
///   String get collectionPath => FirestoreCollection.users;
///
///   @override
///   User convertFromJson(Map<String, dynamic> json) =>
///    UserModel.fromJson(json);
/// }
/// ```
abstract class FirestoreCollectionService<T extends SerializeJson> extends FirestoreService<T> {
  /// The Firestore collection path for this service.
  ///
  /// The path should be defined in `packages/constants/lib/src/firestore_collection.dart`
  /// to maintain consistency across the project.
  @protected
  String get collectionPath;

  /// A reference to the Firestore collection specified by [collectionPath].
  ///
  /// This reference uses Firestore's `withConverter` method to handle
  /// serialization and deserialization of documents from Firestore.
  @protected
  late final CollectionReference<T> collectionReference = FirebaseFirestore.instance
      .collection(collectionPath)
      .withConverter<T>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data();
          data?['id'] = snapshot.id;
          data?['path'] = snapshot.reference.path;
          return convertFromJson(data!);
        },
        toFirestore: (object, _) => object.toJson(),
      );

  /// Generates a new document ID for the Firestore collection.
  ///
  /// This method ensures that new documents have unique IDs before being added
  /// to the Firestore collection.
  @protected
  String generateNewDocId() => super.newDocId(collectionReference: collectionReference);

  /// Checks if a document exists in the Firestore collection.
  ///
  /// Returns `true` if the document exists, otherwise returns `false`.
  Future<bool> documentExists({required String documentId}) async {
    final document = await collectionReference.doc(documentId).get();
    return document.exists;
  }

  /// Creates a new document in the Firestore collection.
  ///
  /// - [payload]: The data to store in the document.
  /// - [documentId]: (Optional) A custom document ID. If not provided, an
  /// ID will be generated.
  /// - [verbose]: Whether to log detailed creation messages.
  @protected
  Future<void> create({required T payload, String? documentId, bool verbose = false}) => createDocument(
    collectionReference: collectionReference,
    payload: payload,
    documentId: documentId,
    verbose: verbose,
  );

  /// Retrieves a single document by its [documentId].
  ///
  /// Returns `null` if the document does not exist.
  @protected
  Future<T?> get(String documentId) => findDocument(collectionReference: collectionReference, documentId: documentId);

  /// Fetches a list of documents from the collection.
  ///
  /// - [limit]: The maximum number of documents to retrieve
  /// (default: unlimited).
  @protected
  Future<List<T>> getDocuments({int? limit}) => fetchDocuments(collectionReference: collectionReference, limit: limit);

  /// Fetches a list of documents based on a Firestore query.
  ///
  /// - [query]: A Firestore query to filter documents.
  /// - [limit]: The maximum number of documents to retrieve.
  @protected
  Future<List<T>> getDocumentsWithQuery({required Query<T> query, int? limit}) async {
    _validateQuery(query);
    return fetchDocumentsWithQuery(query: query);
  }

  /// Updates an existing document in the Firestore collection.
  ///
  /// - [documentId]: The ID of the document to update.
  /// - [payload]: The updated data to be stored in the document.
  @protected
  Future<void> update({required String documentId, required T payload}) =>
      updateDocument(collectionReference: collectionReference, documentId: documentId, payload: payload);

  /// Partially updates a document by updating only the specified fields.
  ///
  /// - [documentId]: The ID of the document to update.
  /// - [payload]: A map containing only the fields to be updated.
  @protected
  Future<void> onlyUpdate({required String documentId, required Map<String, Object?> payload}) =>
      updateOnlyDocument(collectionReference: collectionReference, documentId: documentId, payload: payload);

  /// Deletes a document from the Firestore collection.
  ///
  /// - [documentId]: The ID of the document to delete.
  @protected
  Future<void> delete({required String documentId}) =>
      deleteDocument(collectionReference: collectionReference, documentId: documentId);

  /// Subscribes to real-time updates for a single document.
  ///
  /// Returns a stream that emits updated document data whenever changes occur.
  @protected
  Stream<T?> subscribe({required String documentId}) =>
      subscribeToDocument(collectionReference: collectionReference, documentId: documentId);

  /// Subscribes to real-time updates for the collection.
  ///
  /// Returns a stream of document lists that updates whenever changes occur.
  ///
  /// - [limit]: The maximum number of documents to include in the stream.
  @protected
  Stream<List<T>> subscribeList({int? limit}) =>
      subscribeToList(collectionReference: collectionReference, limit: limit);

  /// Subscribes to real-time updates for a query-based document list.
  ///
  /// Returns a stream of filtered documents that updates when data changes.
  ///
  /// - [query]: A Firestore query to filter the results.
  /// - [limit]: The maximum number of documents to include in the stream.
  @protected
  Stream<List<T>> subscribeListWithQuery({required Query<T> query, int? limit}) {
    _validateQuery(query);
    return subscribeToListWithQuery(query: query, limit: limit);
  }

  /// Ensures that the query belongs to the correct collection reference.
  void _validateQuery(Query<T> query) {
    final expectedPath = collectionReference.path;
    final queryPath = query.firestore.collection(collectionPath).path;

    if (queryPath != expectedPath) {
      throw ArgumentError(
        'The provided query does not belong to the expected collection:'
        ' $expectedPath',
      );
    }
  }
}
