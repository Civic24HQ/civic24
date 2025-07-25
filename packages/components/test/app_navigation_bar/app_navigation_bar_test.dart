import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];
  const selectedIndex = 0;

  // Run basic golden test for AppNavigationBar
  testGoldens('$AppNavigationBar', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$AppNavigationBar with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {})),
        ),
      )
      ..addScenario(
        '$AppNavigationBar with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {}),
            dark: true,
          ),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, '$AppNavigationBar');
  });

  // Run device-specific golden tests for AppNavigationBar
  testGoldens('$AppNavigationBar – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {}),
          ),
        ),
        name: '$AppNavigationBar – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {}),
          ),
          dark: true,
        ),
        name: '$AppNavigationBar – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$AppNavigationBar – General', autoHeight: true);
  });
}
