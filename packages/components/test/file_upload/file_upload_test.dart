import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for FileUpload
  testGoldens('$FileUpload', (WidgetTester tester) async {
    const scenarioHeight = 300.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$FileUpload with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(FileUpload(onUpload: () {})),
        ),
      )
      ..addScenario(
        '$FileUpload with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(FileUpload(onUpload: () {}), dark: true),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(600, 1000));
    await screenMatchesGolden(tester, '$FileUpload');
  });

  // Run device-specific golden tests for FileUpload
  testGoldens('$FileUpload – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: FractionallySizedBox(widthFactor: 0.7, heightFactor: 0.4, child: FileUpload(onUpload: () {})),
          ),
        ),
        name: '$FileUpload – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: FractionallySizedBox(widthFactor: 0.7, heightFactor: 0.4, child: FileUpload(onUpload: () {})),
          ),
          dark: true,
        ),
        name: '$FileUpload – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$FileUpload – General', autoHeight: true);
  });
}
