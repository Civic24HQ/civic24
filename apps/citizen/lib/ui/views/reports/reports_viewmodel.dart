import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReportsViewModel extends ReactiveViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<RouterService>();
  final _userService = locator<UserService>();
  final _reportService = locator<ReportService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService, _reportService];

  String get user => _userService.user!.id;

  List<Report> getUserReports() => _reportService.getFeedItems(ReportFeedType.userReports);

  List<Report> getUserBookmarkedReports() => _reportService.getFeedItems(ReportFeedType.userBookmarks);

  Future<void> startRealTimeFeed(ReportFeedType reportTypeFeed) async {
    await _reportService.startRealtimeFeed(reportTypeFeed);
  }

  void stopRealTimeFeed(ReportFeedType reportTypeFeed) => _reportService.stopRealtimeFeed(reportTypeFeed);

  bool isUserReportsInitialLoading() => _reportService.isInitialReportLoading(ReportFeedType.userReports);
  bool isUserBookmarksInitialLoading() => _reportService.isInitialReportLoading(ReportFeedType.userBookmarks);

  bool isUserReportsPaginationLoading() => _reportService.isPaginationLoading(ReportFeedType.userReports);
  bool isUserBookmarksPaginationLoading() => _reportService.isPaginationLoading(ReportFeedType.userBookmarks);

  Future<void> loadMoreUserReports({int limit = kPageLimit}) =>
      _reportService.loadMoreFeed(ReportFeedType.userReports, limit: limit);

  Future<void> loadMoreUserBookmarks({int limit = kPageLimit}) =>
      _reportService.loadMoreFeed(ReportFeedType.userBookmarks, limit: limit);

  Future<void> refreshUserReports({int limit = kPageLimit}) =>
      _reportService.refreshFeed(ReportFeedType.userReports, limit: limit);

  Future<void> refreshUserBookmarks({int limit = kPageLimit}) =>
      _reportService.refreshFeed(ReportFeedType.userBookmarks, limit: limit);

  Future<void> initUserReportsFeed({int limit = kPageLimit}) =>
      _reportService.loadInitialFeed(ReportFeedType.userReports, limit: limit);

  Future<void> initUserBookmarksFeed({int limit = kPageLimit}) =>
      _reportService.loadInitialFeed(ReportFeedType.userBookmarks, limit: limit);


  Future<void> viewComment() async {
    final uploadResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.comment,
      isScrollControlled: true,
      data: fakeCommentDataList,
    );

    if (uploadResponse != null && uploadResponse.confirmed) {}
  }

  Future<void> onAddReport() async {
    await _navigationService.navigateToAddReportView();
  }

  Future<void> likeReport(Report report) async {
    await _reportService.likeReportOptimistic(report, user);
  }

  Future<void> dislikeReport(Report report) async {
    await _reportService.dislikeReportOptimistic(report, user);
  }

  Future<void> bookmarkReport(Report report) async {
    await _reportService.bookmarkReportOptimistic(report, user);
  }

}
