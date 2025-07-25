import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for PageProgressBar
  testGoldens('$PageProgressBar', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$PageProgressBar with light theme',
        SizedBox(height: scenarioHeight, child: testableWidget(const PageProgressBar())),
      )
      ..addScenario(
        '$PageProgressBar with dark theme',
        SizedBox(height: scenarioHeight, child: testableWidget(const PageProgressBar(), dark: true)),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, '$PageProgressBar');
  });

  // Run device-specific golden tests for PageProgressBar
  testGoldens('$PageProgressBar – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          const Padding(padding: EdgeInsets.all(AppDimensions.padding16), child: PageProgressBar()),
        ),
        name: '$PageProgressBar – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          const Padding(padding: EdgeInsets.all(AppDimensions.padding16), child: PageProgressBar()),
          dark: true,
        ),
        name: '$PageProgressBar – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$PageProgressBar – General', autoHeight: true);
  });
}
