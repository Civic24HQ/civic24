import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$ExpandingDotsIndicator',
    fileName: 'expanding_dots_indicator',
    scenarios: [
      GoldenTestScenario(
        name: '$ExpandingDotsIndicator with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0)),
        ),
      ),
      GoldenTestScenario(
        name: '$ExpandingDotsIndicator with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0), dark: true),
        ),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$ExpandingDotsIndicator – General',
    fileName: 'expanding_dots_indicator_general',
    scenarios: [
      GoldenTestScenario(
        name: '$ExpandingDotsIndicator – General with light theme',
        child: testableWidget(
          Container(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: const ExpandingDotsIndicator(count: 3, currentIndex: 0),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$ExpandingDotsIndicator – General with dark theme',
        child: testableWidget(
          Container(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: const ExpandingDotsIndicator(count: 3, currentIndex: 0),
          ),
          dark: true,
        ),
      ),
    ],
  );
}
