import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for ExpandingDotsIndicator
  testGoldens('$ExpandingDotsIndicator', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$ExpandingDotsIndicator with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0)),
        ),
      )
      ..addScenario(
        '$ExpandingDotsIndicator with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0), dark: true),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, '$ExpandingDotsIndicator');
  });


  // Run device-specific golden tests for TestComponent
  testGoldens('$ExpandingDotsIndicator – General', (tester) async {
    const scenarioHeight = 120.0;

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0)),
        name: '$ExpandingDotsIndicator – General with light theme',
      )
      ..addScenario(
        widget: SizedBox(
          height: scenarioHeight,
          child: testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0), dark: true),
        ),
        name: '$ExpandingDotsIndicator – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$ExpandingDotsIndicator – General', autoHeight: true);
  });

}
