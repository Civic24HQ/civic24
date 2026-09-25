import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$OutlineButton',
    fileName: 'outline_button',
    scenarios: [
      GoldenTestScenario(
        name: '$OutlineButton disabled state with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', disabled: true, onTap: () {})),
        ),
      ),
      GoldenTestScenario(
        name: '$OutlineButton disabled state with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', disabled: true, onTap: () {}), dark: true),
        ),
      ),
      GoldenTestScenario(
        name: '$OutlineButton active state with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', onTap: () {})),
        ),
      ),
      GoldenTestScenario(
        name: '$OutlineButton active state with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(OutlineButton(title: 'Outline Button', onTap: () {}), dark: true),
        ),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$OutlineButton – General',
    fileName: 'outline_button_general',
    scenarios: [
      GoldenTestScenario(
        name: '$OutlineButton – General with light theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: OutlineButton(title: 'Outline Button', onTap: () {}),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$OutlineButton – General with dark theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: OutlineButton(title: 'Outline Button', onTap: () {}),
          ),
          dark: true,
        ),
      ),
    ],
  );
}
