import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 300.0;

  goldenScenarios(
    '$FileUpload',
    fileName: 'file_upload',
    width: 600,
    scenarios: [
      GoldenTestScenario(
        name: '$FileUpload with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(FileUpload(onUpload: () {})),
        ),
      ),
      GoldenTestScenario(
        name: '$FileUpload with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(FileUpload(onUpload: () {}), dark: true),
        ),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$FileUpload – General',
    fileName: 'file_upload_general',
    scenarios: [
      GoldenTestScenario(
        name: '$FileUpload – General with light theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: FractionallySizedBox(widthFactor: 0.7, heightFactor: 0.4, child: FileUpload(onUpload: () {})),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$FileUpload – General with dark theme',
        child: testableWidget(
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding16),
            child: FractionallySizedBox(widthFactor: 0.7, heightFactor: 0.4, child: FileUpload(onUpload: () {})),
          ),
          dark: true,
        ),
      ),
    ],
  );
}
