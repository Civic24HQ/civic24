import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$PageProgressBar',
    fileName: 'page_progress_bar',
    scenarios: [
      GoldenTestScenario(
        name: '$PageProgressBar with light theme',
        child: SizedBox(height: scenarioHeight, child: testableWidget(const PageProgressBar())),
      ),
      GoldenTestScenario(
        name: '$PageProgressBar with dark theme',
        child: SizedBox(height: scenarioHeight, child: testableWidget(const PageProgressBar(), dark: true)),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$PageProgressBar – General',
    fileName: 'page_progress_bar_general',
    scenarios: [
      GoldenTestScenario(
        name: '$PageProgressBar – General with light theme',
        child: testableWidget(
          const Padding(padding: EdgeInsets.all(AppDimensions.padding16), child: PageProgressBar()),
        ),
      ),
      GoldenTestScenario(
        name: '$PageProgressBar – General with dark theme',
        child: testableWidget(
          const Padding(padding: EdgeInsets.all(AppDimensions.padding16), child: PageProgressBar()),
          dark: true,
        ),
      ),
    ],
  );
}
