import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

const double _kCounterWidth = 30;
const double _kCounterHeight = 20;

enum _TabBarStyle { underlined, buttoned }
class AppTab {
  const AppTab({required this.label, this.view, this.count = 0});

  final String label;
  final Widget? view;
  final int count;
}

class AppTabs extends StatefulWidget {
  const AppTabs.underlined({required this.tabs, this.initialIndex, this.onTabChanged, this.padding, super.key})
    : _tabBarStyle = _TabBarStyle.underlined;

  const AppTabs.buttoned({required this.tabs, this.initialIndex, this.onTabChanged, this.padding, super.key})
    : _tabBarStyle = _TabBarStyle.buttoned;

  final int? initialIndex;
  final List<AppTab> tabs;
  final ValueChanged<int>? onTabChanged;
  final EdgeInsets? padding;

  final _TabBarStyle _tabBarStyle;


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
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          switch (widget._tabBarStyle) {
            _TabBarStyle.underlined => TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: context.neutralLow,
              // indicatorPadding: AppEdgeInsets.horizontalPadding24,
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
            _TabBarStyle.buttoned => TabBar(
              controller: _tabController,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.padding8),
              labelPadding: const EdgeInsets.only(right: AppDimensions.padding16),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              dividerHeight: 0,
              tabs: widget.tabs.map((tab) {
                final isSelected = _activeIndex == widget.tabs.indexOf(tab);
                return SortChip(
                  value: tab.label,
                  groupValue: isSelected ? tab.label : null,
                  onChanged: (value) {
                    if (value != null) {
                      _tabController.animateTo(widget.tabs.indexOf(tab));
                    }
                  },
                );
              }).toList(),
            ),
          },
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
      ),
    );
  }
}
