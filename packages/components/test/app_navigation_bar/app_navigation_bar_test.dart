import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const selectedIndex = 0;
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$AppNavigationBar',
    fileName: 'app_navigation_bar',
    scenarios: [
      GoldenTestScenario(
        name: '$AppNavigationBar with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {})),
        ),
      ),
      GoldenTestScenario(
        name: '$AppNavigationBar with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {}),
            dark: true,
          ),
        ),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$AppNavigationBar – General',
    fileName: 'app_navigation_bar_general',
    scenarios: [
      GoldenTestScenario(
        name: '$AppNavigationBar – General with light theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {}),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$AppNavigationBar – General with dark theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: AppNavigationBar.citizen(selectedIndex: selectedIndex, onDestinationSelected: (_) {}),
          ),
          dark: true,
        ),
      ),
    ],
  );
}
