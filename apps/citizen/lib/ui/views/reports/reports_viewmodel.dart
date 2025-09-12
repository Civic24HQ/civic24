import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:citizen/app/app.router.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReportsViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<RouterService>();

  List<ReportWithUserState> get bookmarkedReportList => fakeReportDataBookmarkList;
  List<ReportWithUserState> get myReportList => fakeReportDataUserList;

  Future<void> viewComment() async {
    final uploadResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.comment,
      isScrollControlled: true,
      data: fakeCommentDataList,
    );

    if (uploadResponse != null && uploadResponse.confirmed) {}
  }

  Future<void> onAddReport() => _navigationService.navigateToAddReportView();

  void likeReport(ReportWithUserState reportData) {
    var likes = reportData.report.likeCount;
    var dislikes = reportData.report.dislikeCount;
    var liked = reportData.hasLiked;
    var disliked = reportData.hasDisliked;

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

    final index = fakeReportDataList.indexWhere((e) => e.report == reportData.report);
    if (index < 0) return;

    fakeReportDataList[index] = ReportWithUserState(
      report: reportData.report.copyWith(likeCount: likes, dislikeCount: dislikes),
      hasLiked: liked,
      hasDisliked: disliked,
      hasBookmarked: reportData.hasBookmarked,
    );
    rebuildUi();
  }

  void dislikeReport(ReportWithUserState reportData) {
    var likes = reportData.report.likeCount;
    var dislikes = reportData.report.dislikeCount;
    var liked = reportData.hasLiked;
    var disliked = reportData.hasDisliked;

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

    final index = fakeReportDataList.indexWhere((e) => e.report == reportData.report);
    if (index < 0) return;

    fakeReportDataList[index] = ReportWithUserState(
      report: reportData.report.copyWith(likeCount: likes, dislikeCount: dislikes),
      hasLiked: liked,
      hasDisliked: disliked,
      hasBookmarked: reportData.hasBookmarked,
    );
    rebuildUi();
  }

  void bookmarkReport(ReportWithUserState reportData) {
    var bookmarks = reportData.report.bookmarkCount;
    var bookmarked = reportData.hasBookmarked;

    if (bookmarked) {
      bookmarks = (bookmarks - 1).clamp(0, 1 << 31);
      bookmarked = false;
    } else {
      bookmarks = (bookmarks + 1).clamp(0, 1 << 31);
      bookmarked = true;
    }

    final index = fakeReportDataList.indexWhere((e) => e.report == reportData.report);
    if (index < 0) return;

    fakeReportDataList[index] = ReportWithUserState(
      report: reportData.report.copyWith(bookmarkCount: bookmarks),
      hasLiked: reportData.hasLiked,
      hasDisliked: reportData.hasDisliked,
      hasBookmarked: bookmarked,
    );
    rebuildUi();
  }
}
