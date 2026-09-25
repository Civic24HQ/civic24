import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$PrimaryButton',
    fileName: 'primary_button',
    scenarios: [
      GoldenTestScenario(
        name: '$PrimaryButton disabled with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', disabled: true, onTap: () {})),
        ),
      ),
      GoldenTestScenario(
        name: '$PrimaryButton disabled with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', disabled: true, onTap: () {}), dark: true),
        ),
      ),
      GoldenTestScenario(
        name: '$PrimaryButton active with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', onTap: () {})),
        ),
      ),
      GoldenTestScenario(
        name: '$PrimaryButton active with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(PrimaryButton(title: 'Primary Button', onTap: () {}), dark: true),
        ),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$PrimaryButton – General',
    fileName: 'primary_button_general',
    scenarios: [
      GoldenTestScenario(
        name: '$PrimaryButton – General with light theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: PrimaryButton(title: 'Primary Button', onTap: () {}),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$PrimaryButton – General with dark theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: PrimaryButton(title: 'Primary Button', onTap: () {}),
          ),
          dark: true,
        ),
      ),
    ],
  );
}
