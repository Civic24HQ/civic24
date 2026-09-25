import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  const scenarioHeight = 120.0;

  goldenScenarios(
    '$AppTabs',
    fileName: 'app_tabs',
    scenarios: [
      GoldenTestScenario(
        name: '$AppTabs with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs.underlined(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$AppTabs with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs.underlined(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
            dark: true,
          ),
        ),
      ),
    ],
  );

  goldenDeviceScenarios(
    '$AppTabs – General',
    fileName: 'app_tabs_general',
    scenarios: [
      GoldenTestScenario(
        name: '$AppTabs – General with light theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs.underlined(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
          ),
        ),
      ),
      GoldenTestScenario(
        name: '$AppTabs – General with dark theme',
        child: SizedBox(
          height: scenarioHeight,
          child: testableWidget(
            const AppTabs.underlined(
              tabs: [
                AppTab(
                  label: 'Reports',
                  view: Center(child: Text('Reports', style: TextStyle(fontSize: 24))),
                ),
                AppTab(
                  label: 'Notifications',
                  view: Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
                ),
              ],
            ),
            dark: true,
          ),
        ),
      ),
    ],
  );
}
