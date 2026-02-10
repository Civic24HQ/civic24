import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
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
  List<ListenableServiceMixin> get listenableServices => [
    _userService,
    _reportService,
  ];

  String get user => _userService.user!.id;
  List<Report> get reportList => [];

  List<Report> get myReportList =>
      reportList.where((r) => r.reportData.userId == user).toList()..sort(
        (a, b) => b.reportData.createdAt.compareTo(a.reportData.createdAt),
      );
  List<Report> get bookmarkedReportList =>
      reportList.where((r) => r.hasBookmarked).toList()..sort(
        (a, b) => b.reportData.createdAt.compareTo(a.reportData.createdAt),
      );

  Future<void> viewComment() async {
    final uploadResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.comment,
      isScrollControlled: true,
      data: fakeCommentDataList,
    );

    if (uploadResponse != null && uploadResponse.confirmed) {}
  }

  Future<void> onAddReport() => _navigationService.navigateToAddReportView();

  void likeReport(Report report) {
    var likes = report.reportData.likeCount;
    var dislikes = report.reportData.dislikeCount;
    var liked = report.hasLiked;
    var disliked = report.hasDisliked;
    if (liked) {
      likes = (likes - 1).clamp(0, 1 << 31);
      liked = false;
    } else {
      likes = (likes + 1).clamp(0, 1 << 31);
      liked = true;
      if (disliked) {
        dislikes = (dislikes - 1).clamp(0, 1 << 31);
        disliked = false;
      }
    }

    final index = fakeReportDataList.indexWhere(
      (e) => e.reportData == report.reportData,
    );
    if (index < 0) return;

    fakeReportDataList[index] = Report(
      reportData: report.reportData.copyWith(
        likeCount: likes,
        dislikeCount: dislikes,
      ),
      hasLiked: liked,
      hasDisliked: disliked,
      hasBookmarked: report.hasBookmarked,
    );
    rebuildUi();
  }

  void dislikeReport(Report report) {
    var likes = report.reportData.likeCount;
    var dislikes = report.reportData.dislikeCount;
    var liked = report.hasLiked;
    var disliked = report.hasDisliked;
    if (disliked) {
      dislikes = (dislikes - 1).clamp(0, 1 << 31);
      disliked = false;
    } else {
      dislikes = (dislikes + 1).clamp(0, 1 << 31);
      disliked = true;
      if (liked) {
        likes = (likes - 1).clamp(0, 1 << 31);
        liked = false;
      }
    }

    final index = fakeReportDataList.indexWhere(
      (e) => e.reportData == report.reportData,
    );
    if (index < 0) return;

    fakeReportDataList[index] = Report(
      reportData: report.reportData.copyWith(
        likeCount: likes,
        dislikeCount: dislikes,
      ),
      hasLiked: liked,
      hasDisliked: disliked,
      hasBookmarked: report.hasBookmarked,
    );
    rebuildUi();
  }

  void bookmarkReport(Report report) {
    var bookmarks = report.reportData.bookmarkCount;
    var bookmarked = report.hasBookmarked;

    if (bookmarked) {
      bookmarks = (bookmarks - 1).clamp(0, 1 << 31);
      bookmarked = false;
    } else {
      bookmarks = (bookmarks + 1).clamp(0, 1 << 31);
      bookmarked = true;
    }

    final index = fakeReportDataList.indexWhere(
      (e) => e.reportData == report.reportData,
    );
    if (index < 0) return;

    fakeReportDataList[index] = Report(
      reportData: report.reportData.copyWith(bookmarkCount: bookmarks),
      hasLiked: report.hasLiked,
      hasDisliked: report.hasDisliked,
      hasBookmarked: bookmarked,
    );
    rebuildUi();
  }
}
