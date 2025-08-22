import 'package:citizen/ui/views/home/home_view.dart';
import 'package:citizen/ui/views/main/main_viewmodel.dart';
import 'package:citizen/ui/views/notification/notification_view.dart';
import 'package:citizen/ui/views/reports/reports_view.dart';
import 'package:citizen/ui/views/settings/settings_view.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  void updateIndex(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(covariant MainView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedIndex != widget.initialIndex) {
      updateIndex(widget.initialIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: MainViewModel.new,
      onViewModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            onPageChanged: updateIndex,
            children: const <Widget>[
              HomeView(),
              ReportsView(),
              NotificationView(),
              SettingsView(),
            ],
          ),
          bottomNavigationBar: AppNavigationBar.citizen(
            selectedIndex: _selectedIndex,
            onDestinationSelected: updateIndex,
          ),
        );
      },
    );
  }
}
