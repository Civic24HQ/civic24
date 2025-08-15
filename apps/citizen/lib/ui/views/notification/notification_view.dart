import 'package:citizen/ui/views/notification/notification_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NotificationView extends StackedView<NotificationViewModel> {
  const NotificationView({super.key});

  @override
  Widget builder(BuildContext context, NotificationViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: const Center(child: Text('Notification View')),
      ),
    );
  }

  @override
  NotificationViewModel viewModelBuilder(BuildContext context) => NotificationViewModel();
}
