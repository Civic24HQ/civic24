import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';

class FeedQueryBuilder {
  FeedQueryBuilder({required this.collectionReference, required this.userId});

  final Query<Report> collectionReference;
  final String? userId;

  Query<Report> buildFeedQuery(ReportFeedType type, {CategoryType? category, int limit = kPageLimit}) {
    var query = collectionReference;

    switch (type) {
      case ReportFeedType.all:
        query = query.orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.trending:
        query = query
            .orderBy('reportData.likeCount', descending: true)
            .orderBy('reportData.updatedAt', descending: true)
            .orderBy('reportData.reportId', descending: true);

      case ReportFeedType.category:
        query = query
            .where('reportData.categoryTypes', arrayContains: category!.name)
            .orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.userReports:
        query = query.where('reportData.userId', isEqualTo: userId).orderBy('reportData.createdAt', descending: true);

      case ReportFeedType.userBookmarks:
        throw UnsupportedError('userBookmarks does not use buildFeedQuery.');
    }

    return query.limit(limit);
  }
}
