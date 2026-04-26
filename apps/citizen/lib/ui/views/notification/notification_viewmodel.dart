import 'package:citizen/app/app.locator.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends ReactiveViewModel {
  final _notificationService = locator<NotificationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_notificationService];

  List<NotificationData> get notificationList => _notificationService.notifications;
  bool get hasUnreadNotifications => _notificationService.hasUnread;
  bool get isMarkAllBusy => busy('markAll');
  bool get hasMore => _notificationService.hasMore;
  bool get isLoadingMore => _notificationService.isLoadingMore;

  Future<void> markAllNotificationsAsRead() async {
    await runBusyFuture(_notificationService.markAllAsRead(), busyObject: 'markAll');
  }

  Future<void> markNotificationAsRead(NotificationData notification) async {
    await _notificationService.markAsRead(notification);

    // TODO: Implement Navigating to Individual Report Detail when it exists
    //   final reportId = notification.reportId;
    //   if (reportId == null || reportId.isEmpty) return;

    //   final report = await _reportService.getReportById(reportId);
    //   if (report == null) {
    //     _snackbarService.showSnackbar(
    //       message: 'This report is no longer available.',
    //       duration: const Duration(seconds: 3),
    //     );
    //     return;
    //   }
    //   await _navigationService.navigateTo(Routes.reportDetailView, arguments: ReportDetailViewArguments(report: report));
  }

  Future<void> loadMore() async {
    await _notificationService.loadMore();
  }
}
