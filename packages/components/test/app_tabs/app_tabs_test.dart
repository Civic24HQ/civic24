import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];
  const scenarioHeight = 120.0;

  // Run basic golden test for AppTabs
  testGoldens('$AppTabs', (WidgetTester tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$AppTabs with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
          ),
        ),
      )
      ..addScenario(
        '$AppTabs with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
            dark: true,
          ),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, '$AppTabs');
  });

  // Run device-specific golden tests for AppTabs
  testGoldens('$AppTabs – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
          ),
        ),
        name: '$AppTabs – General with light theme',
      )
      ..addScenario(
        widget: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
            dark: true,
          ),
        ),
        name: '$AppTabs – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$AppTabs – General', autoHeight: true);
  });
}
