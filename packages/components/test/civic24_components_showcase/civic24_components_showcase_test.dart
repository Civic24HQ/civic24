import 'package:alchemist/alchemist.dart';
import 'package:components/components.dart';

import '../helpers/golden_test_helpers.dart';
import '../helpers/golden_test_utils.dart';

void main() {
  goldenDeviceScenarios(
    'Civic24 Components Showcase',
    fileName: 'civic24_components_showcase',
    devices: const [GoldenDevice.phone, GoldenDevice.tabletPortrait],
    scenarios: [
      GoldenTestScenario(name: 'Light Theme', child: testableWidget(const ComponentGridShowcase())),
      GoldenTestScenario(name: 'Dark Theme', child: testableWidget(const ComponentGridShowcase(), dark: true)),
    ],
  );
}
