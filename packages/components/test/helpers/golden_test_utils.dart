import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

/// A screen size used to render a scenario the way a device would show it.
enum GoldenDevice {
  phone(375, 667),
  tabletPortrait(1024, 1366),
  tabletLandscape(1366, 1024);

  const GoldenDevice(this.width, this.height);

  final double width;
  final double height;
}

/// A basic golden test: one column of named scenarios (for example a light and
/// a dark theme), each as wide as [width].
///
/// ```dart
/// void main() {
///   goldenScenarios(
///     'MyWidget',
///     fileName: 'my_widget',
///     scenarios: [
///       GoldenTestScenario(name: 'light theme', child: SizedBox(height: 120, child: testableWidget(MyWidget()))),
///       GoldenTestScenario(name: 'dark theme', child: SizedBox(height: 120, child: testableWidget(MyWidget(), dark: true))),
///     ],
///   );
/// }
/// ```
void goldenScenarios(
  String description, {
  required String fileName,
  required List<GoldenTestScenario> scenarios,
  double width = 500,
}) {
  goldenTest(
    description,
    fileName: fileName,
    constraints: BoxConstraints(maxWidth: width),
    builder: () => GoldenTestGroup(columns: 1, children: scenarios),
  );
}

/// A golden test that renders every scenario inside each of the given
/// [devices], sized like that device (for example a phone screen). The scenario
/// name gets the device name appended.
void goldenDeviceScenarios(
  String description, {
  required String fileName,
  required List<GoldenTestScenario> scenarios,
  List<GoldenDevice> devices = const [GoldenDevice.phone],
}) {
  final maxWidth = devices.map((d) => d.width).reduce((a, b) => a > b ? a : b);
  goldenTest(
    description,
    fileName: fileName,
    constraints: BoxConstraints(maxWidth: maxWidth),
    builder: () => GoldenTestGroup(
      columns: 1,
      children: [
        for (final device in devices)
          for (final scenario in scenarios)
            GoldenTestScenario.builder(
              name: devices.length == 1 ? scenario.name : '${scenario.name} (${device.name})',
              builder: (context) =>
                  SizedBox(width: device.width, height: device.height, child: scenario.builder(context)),
            ),
      ],
    ),
  );
}
