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
    final items = <MapEntry<String, Widget>>[];

    // Build a grid view to display the components
    // Each component is wrapped in a Card with padding and a title below it
    // The grid is responsive, adjusting the number of columns based on the available width
    // The grid items are styled with a consistent padding and spacing
    return Scaffold(
      body: Padding(
        padding: AppEdgeInsets.padding16,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: AppEdgeInsets.horizontalPadding12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSpacing.normal,
                  Text(item.key, textAlign: TextAlign.center, style: context.bodySmall),
                  AppSpacing.large,
                  Center(child: item.value),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
