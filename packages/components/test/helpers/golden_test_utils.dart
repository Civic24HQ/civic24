import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:styles/styles.dart';

import 'golden_test_helpers.dart';

/// The [runBasicGoldenTest] is a basic snapshot test (Light & Dark themes)
///
/// void main() {
///   runBasicGoldenTest(
///     name: 'MyWidget',
///     widget: MyWidget(),
///     surfaceSize: const Size(500, 900),
///   );
/// }
///
void runBasicGoldenTest({
  required String name,
  required Widget widget,
  double scenarioHeight = AppDimensions.size120,
  Size surfaceSize = const Size(500, 900),
}) {
  testGoldens(name, (WidgetTester tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario('$name – Light Theme', SizedBox(height: scenarioHeight, child: testableWidget(widget)))
      ..addScenario('$name – Dark Theme', SizedBox(height: scenarioHeight, child: testableWidget(widget, dark: true)));

    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: surfaceSize);

    await screenMatchesGolden(tester, name.toLowerCase().replaceAll(' ', '_'), autoHeight: true);
  });
}

/// The [runInteractiveGoldenTest] is a basic snapshot test with interaction support using DeviceBuilder.
///
/// void main() {
///   runInteractiveGoldenTest(
///     name: 'ExpandingDotsIndicator Interaction',
///     build: (key) => ExpandingDotsIndicator(
///       key: key,
///       count: 4,
///       currentIndex: 1,
///       onDotClicked: (index) {
///         -- Simulate onTap, hover and state update or callback for the widget --
///       },
///     ),
///     onCreate: (tester, key) async {
///       final finder = find
///           .descendant(of: find.byKey(key), matching: find.byType(GestureDetector))
///           .at(2);
///       expect(finder, findsOneWidget);
///       await tester.tap(finder);
///       await tester.pumpAndSettle();
///     },
///   );
/// }
///
void runInteractiveGoldenTest({
  required String name,
  required Widget Function(Key key) build,
  required Future<void> Function(WidgetTester tester, Key key) onCreate,
  List<Device> devices = const [Device.phone, Device.tabletLandscape],
  bool isDarkMode = false,
}) {
  testGoldens(name, (tester) async {
    final scenarioKey = UniqueKey();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(name: 'Interactive $name', widget: build(scenarioKey), onCreate: (key) => onCreate(tester, key));

    await tester.pumpDeviceBuilder(builder, wrapper: customMaterialAppWrapper(dark: isDarkMode));

    await screenMatchesGolden(tester, name.toLowerCase().replaceAll(' ', '_'));
  });
}
