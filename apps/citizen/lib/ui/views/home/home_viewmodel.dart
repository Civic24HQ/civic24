import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class HomeViewModel extends ReactiveViewModel {
  final _log = getLogger('HomeViewModel');
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<RouterService>();
  final _userService = locator<UserService>();
  final _reportService = locator<ReportService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService, _reportService];

  String get user => _userService.user!.id;

  List<Report> getAllReports() => _reportService.getFeedItems(ReportFeedType.all);

  List<Report> getTrendingReports() => _reportService.getFeedItems(ReportFeedType.trending);

  List<Report> getCategoryReports(CategoryType category) =>
      _reportService.getFeedItems(ReportFeedType.category, category: category);

  Future<void> startRealTimeFeed(ReportFeedType reportTypeFeed, {CategoryType? category}) async {
    await _reportService.startRealtimeFeed(reportTypeFeed, category: category);
  }

  void stopRealTimeFeed(ReportFeedType reportTypeFeed, {CategoryType? category}) =>
      _reportService.stopRealtimeFeed(reportTypeFeed, category: category);

  bool isAllInitialLoading() => _reportService.isInitialReportLoading(ReportFeedType.all);
  bool isTrendingInitialLoading() => _reportService.isInitialReportLoading(ReportFeedType.trending);
  bool isCategoryInitialLoading(CategoryType category) =>
      _reportService.isInitialReportLoading(ReportFeedType.category, category: category);

  bool isAllPaginationLoading() => _reportService.isPaginationLoading(ReportFeedType.all);
  bool isTrendingPaginationLoading() => _reportService.isPaginationLoading(ReportFeedType.trending);
  bool isCategoryPaginationLoading(CategoryType category) =>
      _reportService.isPaginationLoading(ReportFeedType.category, category: category);

  Future<void> loadMoreAll({int limit = kPageLimit}) => _reportService.loadMoreFeed(ReportFeedType.all, limit: limit);

  Future<void> loadMoreTrending({int limit = kPageLimit}) =>
      _reportService.loadMoreFeed(ReportFeedType.trending, limit: limit);

  Future<void> loadMoreCategory(CategoryType category, {int limit = kPageLimit}) =>
      _reportService.loadMoreFeed(ReportFeedType.category, category: category, limit: limit);

  Future<void> refreshAll({int limit = kPageLimit}) => _reportService.refreshFeed(ReportFeedType.all, limit: limit);

  Future<void> refreshTrending({int limit = kPageLimit}) =>
      _reportService.refreshFeed(ReportFeedType.trending, limit: limit);

  Future<void> refreshCategory(CategoryType category, {int limit = kPageLimit}) =>
      _reportService.refreshFeed(ReportFeedType.category, category: category, limit: limit);

  Future<void> initAllFeed({int limit = kPageLimit}) =>
      _reportService.loadInitialFeed(ReportFeedType.all, limit: limit);

  Future<void> initTrendingFeed({int limit = kPageLimit}) =>
      _reportService.loadInitialFeed(ReportFeedType.trending, limit: limit);

  Future<void> initCategoryFeed(CategoryType category, {int limit = kPageLimit}) =>
      _reportService.loadInitialFeed(ReportFeedType.category, category: category, limit: limit);

  void onCategoryChanged(CategoryType category) {
    _log.i('User switched to $category Tab');
  }

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
