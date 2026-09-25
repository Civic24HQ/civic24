import 'dart:async';

import 'package:alchemist/alchemist.dart';

/// Golden test configuration for the components package (alchemist).
///
/// CI goldens render text as colored squares with the Ahem font, so they look
/// the same on macOS, Linux and Windows and are checked everywhere, including
/// GitHub Actions. They are the committed baselines (`goldens/ci/`).
///
/// Platform goldens (readable text, host operating system only) are switched
/// off: they differ between machines and would fail for other developers. To
/// look at readable images while working, set `enabled: true` locally and run
/// `flutter test --update-goldens`, but do not commit them.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(platformGoldensConfig: PlatformGoldensConfig(enabled: false)),
    run: testMain,
  );
}
