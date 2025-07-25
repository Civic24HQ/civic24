import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone];

  // Run basic golden test for AppFilterChip
  testGoldens('$AppFilterChip', (WidgetTester tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$AppFilterChip unselected state with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            AppFilterChip(
              smallChip: true,
              label: 'Light & Electricity',
              tooltip: 'Filter by Light & Electricity',
              trailingIconTooltip: 'Info about Light & Electricity',
              onTrailingIconPressed: () {},
              onSelected: (_) {},
            ),
          ),
        ),
      )
      ..addScenario(
        '$AppFilterChip unselected state with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            AppFilterChip(
              smallChip: true,
              label: 'Light & Electricity',
              tooltip: 'Filter by Light & Electricity',

              trailingIconTooltip: 'Info about Light & Electricity',
              onTrailingIconPressed: () {},
              onSelected: (_) {},
            ),
            dark: true,
          ),
        ),
      )
      ..addScenario(
        '$AppFilterChip selected state with light theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            AppFilterChip(
              smallChip: true,
              label: 'Light & Electricity',
              isSelected: true,
              tooltip: 'Filter by Light & Electricity',

              trailingIconTooltip: 'Info about Light & Electricity',
              onTrailingIconPressed: () {},
              onSelected: (_) {},
            ),
          ),
        ),
      )
      ..addScenario(
        '$AppFilterChip selected state with dark theme',
        SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            AppFilterChip(
              smallChip: true,
              label: 'Light & Electricity',
              isSelected: true,
              tooltip: 'Filter by Light & Electricity',

              trailingIconTooltip: 'Info about Light & Electricity',
              onTrailingIconPressed: () {},
              onSelected: (_) {},
            ),
            dark: true,
          ),
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 1000));
    await screenMatchesGolden(tester, '$AppFilterChip');
  });

  // Run device-specific golden tests for AppFilterChip
  testGoldens('$AppFilterChip – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppFilterChip(
              smallChip: true,
              label: 'Light & Electricity',
              tooltip: 'Filter by Light & Electricity',
              trailingIconTooltip: 'Info about Light & Electricity',
              onTrailingIconPressed: () {},
              onSelected: (isSelected) {},
            ),
          ),
        ),
        name: '$AppFilterChip – General with light theme',
      )
      ..addScenario(
        widget: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppFilterChip(
              smallChip: true,
              label: 'Light & Electricity',
              tooltip: 'Filter by Light & Electricity',
              trailingIconTooltip: 'Info about Light & Electricity',
              onTrailingIconPressed: () {},
              onSelected: (isSelected) {},
            ),
          ),
          dark: true,
        ),
        name: '$AppFilterChip – General with dark theme',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$AppFilterChip – General', autoHeight: true);
  });
}
