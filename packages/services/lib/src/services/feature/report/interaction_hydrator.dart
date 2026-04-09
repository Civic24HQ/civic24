import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';

class InteractionHydrator {
  InteractionHydrator(this._firestore);

  final FirebaseFirestore _firestore;

  static const int _chunkSize = 30;

  Future<List<Report>> hydrate(List<Report> reports, String userId) async {
    if (reports.isEmpty) return reports;

    final reportIds = reports.map((r) => r.reportData.reportId).toList();
    final interactionMap = <String, Interaction>{};

    final chunks = <List<String>>[];
    for (var i = 0; i < reportIds.length; i += _chunkSize) {
      final end = (i + _chunkSize < reportIds.length) ? i + _chunkSize : reportIds.length;
      chunks.add(reportIds.sublist(i, end));
    }

    final snapshots = await Future.wait(
      chunks.map(
        (chunk) => _firestore
            .collection(FirestoreCollections.users)
            .doc(userId)
            .collection(FirestoreCollections.interactions)
            .where(FieldPath.documentId, whereIn: chunk)
            .get(),
      ),
    );

    for (final snapshot in snapshots) {
      for (final doc in snapshot.docs) {
        interactionMap[doc.id] = Interaction.fromJson(doc.data());
      }
    }

    return reports.map((report) {
      final interaction = interactionMap[report.reportData.reportId];
      if (interaction == null) return report;
      return report.copyWith(
        hasLiked: interaction.hasLiked,
        hasDisliked: interaction.hasDisliked,
        hasBookmarked: interaction.hasBookmarked,
      );
    }).toList();
  }
}