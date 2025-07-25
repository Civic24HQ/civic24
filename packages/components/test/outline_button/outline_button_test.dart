import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for OutlineButton
  testGoldens('$OutlineButton', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$OutlineButton disabled state with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', disabled: true, onTap: () {})),
        ),
      )
      ..addScenario(
        '$OutlineButton disabled state with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', disabled: true, onTap: () {}), dark: true),
        ),
      )
      ..addScenario(
        '$OutlineButton active state with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', onTap: () {})),
        ),
      )
      ..addScenario(
        '$OutlineButton active state with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', onTap: () {}), dark: true),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, '$OutlineButton');
  });

  // Run device-specific golden tests for OutlineButton
  testGoldens('$OutlineButton – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: OutlineButton(title: 'Outline Button', onTap: () {}),
          ),
        ),
        name: '$OutlineButton – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: OutlineButton(title: 'Outline Button', onTap: () {}),
          ),
          dark: true,
        ),
        name: '$OutlineButton – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$OutlineButton – General', autoHeight: true);
  });
}
