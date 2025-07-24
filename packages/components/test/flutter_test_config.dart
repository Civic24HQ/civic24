import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Ensure that the app fonts are loaded before running tests
  await loadAppFonts();

  // Run the tests with Golden Toolkit configuration
  // This configuration is set to skip golden assertions on web and non-MacOS/Windows
  // platforms, and enables real shadows for golden tests.
  return GoldenToolkit.runWithConfiguration(
    testMain,
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion:
          () => kIsWeb || !Platform.isMacOS && !Platform.isWindows,
      enableRealShadows: true,
      defaultDevices: const [Device.iphone11],
    ),
  );
}
