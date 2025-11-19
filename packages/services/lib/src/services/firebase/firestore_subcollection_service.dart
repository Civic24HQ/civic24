import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:services/src/services/firebase/firestore_service.dart';

/// A service class to manage Firestore subcollections, providing
/// CRUD operations for documents within a specific subcollection.
///
/// This service ensures that the subcollection path follows Firestore's
/// hierarchy rules and provides convenience methods for common operations.
///
/// **Example Usage:**
/// ```dart
/// class ReviewService extends FirestoreSubCollectionService<ReviewModel> {
///   @override
///   String get subcollectionPath => 'services/{serviceId}/reviews';
///
///   @override
///   ReviewModel convertFromJson(Map<String, dynamic> json) =>
///     ReviewModel.fromJson(json);
///
///  @override
///  String get collectionPath => 'services';
/// }
///
/// final orderService = OrderService();
///
/// orderService.create(
///   rootDocumentId: 'user_123',
///   payload: OrderModel(orderId: 'order_456', totalAmount: 100),
/// );
/// ```
abstract class FirestoreSubCollectionService<T extends SerializeJson> extends FirestoreService<T> {
  /// Constructor ensures that the provided subcollection path is valid.
  FirestoreSubCollectionService() {
    assert(pathParts.length.isOdd, '''Subcollection should be odd to account for collection + docId + subcollection''');

    assert(pathParts.length >= 3, '''
      The path you provided does not point to a subcollection. 
      Use FirestoreCollectionService if you want a root collection.''');
  }

  /// The path to the subcollection that we are working with.
  /// Must be a full path using `/` as a separator.
  String get subcollectionPath;

  /// Splits the subcollection path into its components.
  @visibleForTesting
  List<String> get pathParts => subcollectionPath.split('/');

  /// Retrieves the last segment of the path, which is the subcollection name.
  @visibleForTesting
  String get subcollectionName => pathParts.last;

  /// Gets the root collection from the provided subcollection path.
  @nonVirtual
  String get collectionPath => pathParts.first;

  /// Returns a reference to the subcollection under a specified root document.
  ///
  /// Example: `users/{rootDocumentId}/orders`
  CollectionReference<T> collectionReference({required String rootDocumentId}) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(rootDocumentId)
        .collection(subcollectionName)
        .withConverter<T>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();
            data?['id'] = snapshot.id;
            return convertFromJson(data!);
          },
          toFirestore: (object, _) => object.toJson(),
        );
  }

  /// Generates a new document ID within the subcollection.
  @protected
  String getNewDocId({required String rootDocumentId}) =>
      super.newDocId(collectionReference: collectionReference(rootDocumentId: rootDocumentId));

  /// Creates a new document in the subcollection.
  /// If [documentId] is provided, it is used as the document's ID.
  Future<void> create({
    required T payload,
    required String rootDocumentId,
    String? documentId,
    bool verbose = false,
  }) async {
    log.d('path: $collectionPath/$rootDocumentId/${documentId ?? ''}');
    return createDocument(
      collectionReference: collectionReference(rootDocumentId: rootDocumentId),
      payload: payload,
      documentId: documentId,
      verbose: verbose,
    );
  }

  /// Retrieves a specific document from the subcollection.
  Future<T?> get({required String documentId, required String rootDocumentId}) async {
    log.d('path: $collectionPath/$rootDocumentId/$documentId');
    return findDocument(
      collectionReference: collectionReference(rootDocumentId: rootDocumentId),
      documentId: documentId,
    );
  }

  /// Fetches all documents from the specified subcollection.
  Future<List<T>> getDocuments({required String rootDocumentId}) async {
    log.d('path: $collectionPath/$rootDocumentId/$subcollectionPath');
    return fetchDocuments(collectionReference: collectionReference(rootDocumentId: rootDocumentId));
  }

  /// Updates a document by merging the provided [payload] with the existing
  /// data.
  Future<void> update({required String documentId, required String rootDocumentId, required T payload}) async {
    return updateDocument(
      collectionReference: collectionReference(rootDocumentId: rootDocumentId),
      documentId: documentId,
      payload: payload,
    );
  }

  /// Deletes a document from the subcollection.
  Future<void> delete({required String documentId, required String rootDocumentId}) async {
    return deleteDocument(
      collectionReference: collectionReference(rootDocumentId: rootDocumentId),
      documentId: documentId,
    );
  }
}
