import 'package:citizen/ui/views/notification/notification_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class NotificationView extends StackedView<NotificationViewModel> {
  const NotificationView({super.key});

  @override
  Widget builder(BuildContext context, NotificationViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: context.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.surface,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(l10n.featureNotifications),
        shape: Border(bottom: BorderSide(color: context.neutralLowest)),
      ),
      body: Column(
        children: [
          AppSpacing.small,
          if (viewModel.hasUnreadNotifications)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: AppEdgeInsets.horizontalPadding4,
                child: viewModel.isMarkAllBusy
                    ? const AppBusyIndicator()
                    : TextButton(
                        onPressed: viewModel.markAllNotificationsAsRead,
                        child: Text(
                          l10n.featureNotificationInstruction,
                          style: context.bodySmall?.copyWith(
                            color: viewModel.hasUnreadNotifications ? context.onPrimaryContainer : context.neutralHigh,
                            decoration: TextDecoration.underline,
                            decorationColor: viewModel.hasUnreadNotifications
                                ? context.onPrimaryContainer
                                : context.neutralHigh,
                          ),
                        ),
                      ),
              ),
            ),
          if (viewModel.notificationList.isEmpty)
            Center(
              heightFactor: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(SolarIconsOutline.notificationRemove, size: AppDimensions.size96)
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .shake(duration: 1.seconds, hz: 2)
                      .fade(duration: 1.seconds, begin: 0, end: 1),
                  AppSpacing.large,
                  Text(l10n.featureNotificationEmpty, textAlign: TextAlign.center, style: context.bodyLarge),
                ],
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: AppEdgeInsets.padding8,
                child: ListView.separated(
                  itemCount: viewModel.notificationList.length,
                  itemBuilder: (context, index) {
                    return AppNotificationTile(
                      title: viewModel.notificationList[index].title,
                      description: viewModel.notificationList[index].description,
                      timestamp: viewModel.notificationList[index].createdAt,
                      onTap: viewModel.markNotificationAsRead,
                      hasBeenSeen: viewModel.notificationList[index].hasBeenSeen,
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.small,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  NotificationViewModel viewModelBuilder(BuildContext context) => NotificationViewModel();
}
