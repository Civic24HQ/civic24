// ignore_for_file: strict_raw_type
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends BaseViewModel {
  List<NotificationData> get notificationList => fakeNotificationDataList;

  bool get hasUnreadNotifications => false;
  bool get isMarkAllBusy => false;

  void markAllNotificationsAsRead() {}

  void markNotificationAsRead() {}
}
