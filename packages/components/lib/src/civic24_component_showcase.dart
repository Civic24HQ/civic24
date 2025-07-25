import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

class ComponentGridShowcase extends StatelessWidget {
  const ComponentGridShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of components to showcase
    // Each entry is a MapEntry with a string key (component name) and a widget value (the component itself)
    // This allows for easy expansion in the future if more components are added
    // final widgets = <Widget>[const TestComponent(), const ExpandingDotsIndicator(count: 3, currentIndex: 0)];
    final items = <MapEntry<String, Widget>>[
      MapEntry(
        'App Filter Chip',
        AppFilterChip(
          smallChip: true,
          label: 'Light & Electricity',
          tooltip: 'Filter by Light & Electricity',
          trailingIconTooltip: 'Info about Light & Electricity',
          onTrailingIconPressed: () {},
          onSelected: (isSelected) {},
        ),
      ),
      const MapEntry('Expanding Dots Indicator', ExpandingDotsIndicator(count: 3, currentIndex: 0)),
      MapEntry(
        'Primary Button',
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.size350),
          child: PrimaryButton(title: 'Proceed', onTap: () {}),
        ),
      ),
      const MapEntry('Page Progress Bar', PageProgressBar()),
      MapEntry(
        'App Navigation Bar',
        AppNavigationBar.citizen(selectedIndex: 0, onDestinationSelected: (index) {}, notificationCount: 5),
      ),
      MapEntry('File Upload', FractionallySizedBox(widthFactor: 0.55, child: FileUpload(onUpload: () {}))),
      MapEntry(
        'App Tabs',
        SizedBox(
          height: AppDimensions.size72,
          child: AppTabs(
            tabs: const [
              AppTab(
                label: 'Reports',
                view: Center(child: Text('', style: TextStyle(fontSize: 24))),
              ),
              AppTab(
                label: 'Notifications',
                view: Center(child: Text('', style: TextStyle(fontSize: 24))),
              ),
            ],
            initialIndex: 0,
            onTabChanged: (index) {},
          ),
        ),
      ),
      MapEntry(
        'App Text Field',
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.size350),
          child: AppTextField(
            label: 'Email Address',
            hintText: 'Enter your email address',
            textInputAction: TextInputAction.next,
            onChanged: (_) {},
          ),
        ),
      ),
      MapEntry(
        'Outline Button',
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.size350),
          child: OutlineButton(title: 'Proceed', onTap: () {}),
        ),
      ),
    ];

    // Build a grid view to display the components
    // Each component is wrapped in a Card with padding and a title below it
    // The grid is responsive, adjusting the number of columns based on the available width
    // The grid items are styled with a consistent padding and spacing

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppEdgeInsets.padding8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.size24),
                child: Padding(
                  padding: AppEdgeInsets.horizontalPadding12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSpacing.large,
                      Text(item.key, textAlign: TextAlign.center, style: context.titleMedium),
                      AppSpacing.normal,
                      Center(child: item.value),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
