import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for AppTextField
  testGoldens('$AppTextField', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$AppTextField with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            Padding(
              padding: const EdgeInsets.all(AppDimensions.padding16),
              child: AppTextField(
                label: 'Email Address',
                hintText: 'Enter your email address',
                textInputAction: TextInputAction.next,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      )
      ..addScenario(
        '$AppTextField with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            Padding(
              padding: const EdgeInsets.all(AppDimensions.padding16),
              child: AppTextField(
                label: 'Email Address',
                hintText: 'Enter your email address',
                textInputAction: TextInputAction.next,
                onChanged: (_) {},
              ),
            ),
            dark: true,
          ),
        ),
      )
      ..addScenario(
        '$AppTextField multiline with light theme',
        SizedBox(
          height: 200,
          child: testableWidget(
            Padding(
              padding: const EdgeInsets.all(AppDimensions.padding16),
              child: AppTextField(
                label: 'Home Address',
                hintText: 'Enter your home address',
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      )
      ..addScenario(
        '$AppTextField multiline with dark theme',
        SizedBox(
          height: 200,
          child: testableWidget(
            Padding(
              padding: const EdgeInsets.all(AppDimensions.padding16),
              child: AppTextField(
                label: 'Home Address',
                hintText: 'Enter your home address',
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                onChanged: (_) {},
              ),
            ),
            dark: true,
          ),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 1000));
    await screenMatchesGolden(tester, '$AppTextField');
  });

  // Run device-specific golden tests for AppTextField
  testGoldens('$AppTextField – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppTextField(
              label: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (_) {},
            ),
          ),
        ),
        name: '$AppTextField – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppTextField(
              label: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (_) {},
            ),
          ),
          dark: true,
        ),
        name: '$AppTextField – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$AppTextField – General', autoHeight: true);
  });
}
