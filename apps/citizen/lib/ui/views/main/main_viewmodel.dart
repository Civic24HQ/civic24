import 'package:citizen/app/app.locator.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends ReactiveViewModel {
  final _notificationService = locator<NotificationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_notificationService];

  int get notificationCount => _notificationService.unreadCount;
}
