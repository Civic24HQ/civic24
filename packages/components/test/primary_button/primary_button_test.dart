import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for PrimaryButton
  testGoldens('$PrimaryButton', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$PrimaryButton disabled with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', disabled: true, onTap: () {})),
        ),
      )
      ..addScenario(
        '$PrimaryButton disabled with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', disabled: true, onTap: () {}), dark: true),
        ),
      )
      ..addScenario(
        '$PrimaryButton active with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', onTap: () {})),
        ),
      )
      ..addScenario(
        '$PrimaryButton active with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', onTap: () {}), dark: true),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, '$PrimaryButton');
  });

  // Run device-specific golden tests for PrimaryButton
  testGoldens('$PrimaryButton – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: PrimaryButton(title: 'Primary Button', onTap: () {}),
          ),
        ),
        name: '$PrimaryButton – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: PrimaryButton(title: 'Primary Button', onTap: () {}),
          ),
          dark: true,
        ),
        name: '$PrimaryButton – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$PrimaryButton – General', autoHeight: true);
  });
}
