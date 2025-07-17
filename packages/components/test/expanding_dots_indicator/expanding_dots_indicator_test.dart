import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  testGoldens('$ExpandingDotsIndicator', (WidgetTester tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        '$ExpandingDotsIndicator with light theme',
        testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0)),
      )
      ..addScenario(
        '$ExpandingDotsIndicator with dark theme',
        testableWidget(const ExpandingDotsIndicator(count: 3, currentIndex: 0), dark: true),
      );
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 900));
    await screenMatchesGolden(tester, '$ExpandingDotsIndicator');
  });
}
