import 'package:constants/constants.dart';
import 'package:models/models.dart';

abstract interface class IReportFeedService {
  List<Report> getFeedItems(ReportFeedType type, {CategoryType? category});
  bool isInitialReportLoading(ReportFeedType type, {CategoryType? category});
  bool isPaginationLoading(ReportFeedType type, {CategoryType? category});
  bool hasMore(ReportFeedType type, {CategoryType? category});
  Future<void> loadInitialFeed(ReportFeedType type, {CategoryType? category, int limit});
  Future<void> loadMoreFeed(ReportFeedType type, {CategoryType? category, int limit});
  Future<void> refreshFeed(ReportFeedType type, {CategoryType? category, int limit});
  Future<void> startRealtimeFeed(ReportFeedType type, {CategoryType? category});
  Future<void> stopRealtimeFeed(ReportFeedType type, {CategoryType? category});
}
