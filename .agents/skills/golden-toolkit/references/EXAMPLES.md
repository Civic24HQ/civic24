# golden_toolkit examples

Complete, copyable files. Adjust the theme and localization to your app.

## `test/flutter_test_config.dart`
```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();

  return GoldenToolkit.runWithConfiguration(
    testMain,
    config: GoldenToolkitConfiguration(
      // Only assert where the baselines were generated.
      skipGoldenAssertion: () => kIsWeb || !Platform.isMacOS,
      enableRealShadows: true,
      defaultDevices: const [Device.iphone11],
    ),
  );
}
```

## `test/helpers/golden_helpers.dart`
```dart
import 'package:flutter/material.dart';

/// Wraps a widget in an app with theme and locale, for scenarios in a column.
Widget testableWidget(Widget child, {bool dark = false}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    locale: const Locale('en'),
    // supportedLocales: ..., localizationsDelegates: ...,
    home: Scaffold(body: Center(child: child)),
  );
}

/// Same app as a wrapper for DeviceBuilder (`pumpDeviceBuilder(wrapper: ...)`).
Widget Function(Widget) appWrapper({bool dark = false}) {
  return (child) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    home: Scaffold(body: child),
  );
}
```

## `test/my_button/my_button_test.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../helpers/golden_helpers.dart';

void main() {
  // 1. States in one column, light and dark.
  testGoldens('MyButton', (tester) async {
    const height = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario('enabled, light',
          SizedBox(height: height, child: testableWidget(const MyButton())))
      ..addScenario('enabled, dark',
          SizedBox(height: height, child: testableWidget(const MyButton(), dark: true)));
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 700));
    await screenMatchesGolden(tester, 'my_button'); // goldens/my_button.png
  });

  // 2. The same widget at device sizes.
  testGoldens('MyButton on devices', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone, Device.tabletPortrait])
      ..addScenario(widget: const MyButton(), name: 'default');
    await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
    await screenMatchesGolden(tester, 'my_button_devices', autoHeight: true);
  });
}
```

## Interaction before the screenshot
```dart
final builder = DeviceBuilder()
  ..addScenario(
    name: 'expanded',
    widget: const MyExpandable(),
    onCreate: (scenarioWidgetKey) async {
      final finder = find.descendant(of: find.byKey(scenarioWidgetKey), matching: find.byType(GestureDetector));
      await tester.tap(finder);
      await tester.pumpAndSettle();
    },
  );
```

## Commands
```bash
flutter test --tags golden                    # check
flutter test --tags golden --update-goldens   # create or refresh baselines
```
