import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$AppTextField',
    fileName: 'app_text_field',
    scenarios: [
      GoldenTestScenario(
        name: '$AppTextField with light theme',
        child: SizedBox(
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
      ),
      GoldenTestScenario(
        name: '$AppTextField with dark theme',
        child: SizedBox(
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
      ),
      GoldenTestScenario(
        name: '$AppTextField multiline with light theme',
        child: SizedBox(
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
      ),
      GoldenTestScenario(
        name: '$AppTextField multiline with dark theme',
        child: SizedBox(
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
      ),
    ],
  );

  goldenDeviceScenarios(
    '$AppTextField – General',
    fileName: 'app_text_field_general',
    scenarios: [
      GoldenTestScenario(
        name: '$AppTextField – General with light theme',
        child: testableWidget(
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
      ),
      GoldenTestScenario(
        name: '$AppTextField – General with dark theme',
        child: testableWidget(
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
      ),
    ],
  );
}
