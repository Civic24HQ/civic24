import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  testGoldens('$TestComponent', (WidgetTester tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario('$TestComponent with light theme', testableWidget(const TestComponent()))
      ..addScenario('$TestComponent with dark theme', testableWidget(const TestComponent(), dark: true));
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 900));
    await screenMatchesGolden(tester, '$TestComponent');
  });
}
