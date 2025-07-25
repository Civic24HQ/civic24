import 'package:flutter/material.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

const double _kCounterWidth = 30;
const double _kCounterHeight = 20;

class AppTab {
  const AppTab({required this.label, this.view, this.count = 0});

  final String label;
  final Widget? view;
  final int count;
}

class AppTabs extends StatefulWidget {
  const AppTabs({required this.tabs, this.initialIndex, this.onTabChanged, super.key});

  final int? initialIndex;
  final List<AppTab> tabs;
  final ValueChanged<int>? onTabChanged;

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.initialIndex ?? 0);
    _activeIndex = widget.initialIndex ?? 0;
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
      widget.onTabChanged?.call(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: context.neutralLow,
          indicatorPadding: AppEdgeInsets.horizontalPadding24,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: context.primaryColor, width: AppDimensions.size2),
            borderRadius: AppBorderRadius.radius16,
          ),
          tabs: widget.tabs.map((tab) {
            final isSelected = _activeIndex == widget.tabs.indexOf(tab);
            return Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      tab.label,
                      style: context.bodyLarge?.copyWith(
                        color: isSelected ? context.colorScheme.onSurface : context.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AppSpacing.small,
                  if (tab.count > 0)
                    Container(
                      height: _kCounterHeight,
                      width: _kCounterWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? context.colorScheme.primary : context.neutralLowest,
                        borderRadius: AppBorderRadius.radius4,
                      ),
                      child: Text(
                        tab.count.toShortNumber,
                        style: context.bodySmall?.copyWith(
                          color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppDimensions.padding16),
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: widget.tabs.map((tab) {
                return tab.view ?? const SizedBox();
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
