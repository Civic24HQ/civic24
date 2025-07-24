import 'package:components/components.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  final devices = [Device.phone, Device.tabletPortrait];

  // Run basic golden test for Civic24 Components Showcase
  testGoldens('Civic24 Components Showcase', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(widget: testableWidget(const ComponentGridShowcase()), name: 'Light Theme')
      ..addScenario(widget: testableWidget(const ComponentGridShowcase(), dark: true), name: 'Dark Theme');

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'Civic24_Components_Showcase', autoHeight: true);
  });
}
