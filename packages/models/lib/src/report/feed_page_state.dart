import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/src/report/report_data.dart';

/// Holds the pagination state and loaded data for a single feed.
///
/// Each feed variant (e.g. "all", "trending", "category_road") maintains
/// its own independent [FeedPageState], enabling concurrent pagination
/// across multiple feeds without shared mutable state.
class FeedPageState {
  List<Report> items = [];
  QueryDocumentSnapshot? lastDocument;
  StreamSubscription<dynamic>? liveSubscription;
  bool hasMore = true;
  bool isLoadingFirstPage = false;
  bool isLoadingNextPage = false;

  Future<void> dispose() async {
    await liveSubscription?.cancel();
    liveSubscription = null;
  }
}
