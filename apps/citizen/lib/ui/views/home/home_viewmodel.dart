import 'package:citizen/app/app.bottomsheets.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:constants/constants.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();

  List<ReportData> get allReportList => fakeReportDataList;
  List<ReportData> get trendingReportList => fakeReportDataTrendingList;

  CategoryType selectedCategory = CategoryType.values[0];
  List<ReportData> get fakeReportCategoryList =>
      fakeReportDataList.where((r) => r.type == selectedCategory).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  List<ReportData> get fakeReportTrendingInCategory =>
      fakeReportDataList.where((r) => r.type == selectedCategory).toList()..sort((a, b) {
        final byLikes = b.likeCount.compareTo(a.likeCount);
        if (byLikes != 0) return byLikes;
        return b.updatedAt.compareTo(a.updatedAt);
      });

  void onCategoryChanged(CategoryType category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> viewComment() async {
    final uploadResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.comment,
      isScrollControlled: true,
      data: fakeCommentDataList,
    );

    if (uploadResponse != null && uploadResponse.confirmed) {}
  }

  void onAddReport() {}
}
