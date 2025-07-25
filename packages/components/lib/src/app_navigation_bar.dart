import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:localization/localization.dart';
import 'package:styles/styles.dart';

enum _AppNavigationDestination { admin, citizen }

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar.admin({
    required this.selectedIndex,
    this.onDestinationSelected,
    this.notificationCount = 0,
    super.key,
  }) : _destination = _AppNavigationDestination.admin;

  const AppNavigationBar.citizen({
    required this.selectedIndex,
    this.onDestinationSelected,
    this.notificationCount = 0,
    super.key,
  }) : _destination = _AppNavigationDestination.citizen;

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final int notificationCount;

  final _AppNavigationDestination _destination;

  @override
  Widget build(BuildContext context) {
    final destinations = _buildDestinations();

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: context.backgroundColor,
        indicatorColor: context.primaryContainer,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: context.primary);
          }
          return IconThemeData(color: context.neutralHighest);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return context.bodySmall?.copyWith(color: context.onPrimaryContainer, fontWeight: FontWeight.w500);
          }
          return context.bodySmall?.copyWith(color: context.neutralHighest);
        }),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations,
      ),
    );
  }

  List<NavigationDestination> _buildDestinations() {
    List<UserDestination> destinationList;

    switch (_destination) {
      case _AppNavigationDestination.admin:
        destinationList = adminDestinations;
      case _AppNavigationDestination.citizen:
        destinationList = citizenDestinations;
    }

    return destinationList.map(_buildNavigationDestination).toList();
  }

  NavigationDestination _buildNavigationDestination(UserDestination destination) {
    return NavigationDestination(
      icon: Badge.count(
        count: notificationCount,
        isLabelVisible: destination.isNotificationPage && notificationCount > 0,
        child: Icon(destination.icon),
      ),
      selectedIcon: Badge.count(
        count: notificationCount,
        isLabelVisible: destination.isNotificationPage && notificationCount > 0,
        child: Icon(destination.selectedIcon),
      ),
      label: destination.label,
      tooltip: destination.label,
    );
  }
}

class UserDestination {
  const UserDestination({required this.icon, required this.selectedIcon, required this.label});
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  bool get isNotificationPage => label == l10n.pageNotifications;
}

List<UserDestination> adminDestinations = [
  UserDestination(icon: IconsaxPlusLinear.home_2, selectedIcon: IconsaxPlusBold.home_2, label: l10n.pageHome),
  UserDestination(icon: IconsaxPlusLinear.people, selectedIcon: IconsaxPlusBold.people, label: l10n.pageReports),
  UserDestination(
    icon: IconsaxPlusLinear.notification,
    selectedIcon: IconsaxPlusBold.notification,
    label: l10n.pageNotifications,
  ),
  UserDestination(icon: IconsaxPlusLinear.setting_2, selectedIcon: IconsaxPlusBold.setting_2, label: l10n.pageSettings),
];
List<UserDestination> citizenDestinations = [
  UserDestination(icon: IconsaxPlusLinear.home_2, selectedIcon: IconsaxPlusBold.home_2, label: l10n.pageHome),
  UserDestination(icon: IconsaxPlusLinear.people, selectedIcon: IconsaxPlusBold.people, label: l10n.pageReports),
  UserDestination(
    icon: IconsaxPlusLinear.notification,
    selectedIcon: IconsaxPlusBold.notification,
    label: l10n.pageNotifications,
  ),
  UserDestination(icon: IconsaxPlusLinear.setting_2, selectedIcon: IconsaxPlusBold.setting_2, label: l10n.pageSettings),
];
