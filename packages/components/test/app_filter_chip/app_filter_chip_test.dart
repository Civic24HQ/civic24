import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$AppFilterChip',
    fileName: 'app_filter_chip',
    scenarios: [
      GoldenTestScenario(
        name: '$AppFilterChip unselected state with light theme',
        child: SizedBox(
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
      ),
      GoldenTestScenario(
        name: '$AppFilterChip unselected state with dark theme',
        child: SizedBox(
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
      ),
      GoldenTestScenario(
        name: '$AppFilterChip selected state with light theme',
        child: SizedBox(
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
      ),
      GoldenTestScenario(
        name: '$AppFilterChip selected state with dark theme',
        child: SizedBox(
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
      ),
    ],
  );

  goldenDeviceScenarios(
    '$AppFilterChip – General',
    fileName: 'app_filter_chip_general',
    scenarios: [
      GoldenTestScenario(
        name: '$AppFilterChip – General with light theme',
        child: testableWidget(
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
      ),
      GoldenTestScenario(
        name: '$AppFilterChip – General with dark theme',
        child: testableWidget(
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
      ),
    ],
  );
}
