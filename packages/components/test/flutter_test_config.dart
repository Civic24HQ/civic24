import 'dart:async';

import 'package:alchemist/alchemist.dart';

import 'helpers/load_app_fonts.dart';

/// Golden test configuration for the components package (alchemist).
///
/// Two sets of images are kept next to every test:
///
/// * `goldens/macos/`: readable images (real fonts and icons). Checked on
///   macOS only, the way the old golden_toolkit images were. Open these to see
///   what a component looks like.
/// * `goldens/ci/`: text and icons are drawn as squares (the Ahem font) and
///   shadows are off, so the images are portable. These are the ones GitHub
///   Actions checks on Ubuntu. Anti-aliasing differs slightly between
///   operating systems, so a difference of up to 0.5 percent of the pixels is
///   tolerated.
///
/// Update both with `melos run components:update:golden` on a Mac.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(platforms: {HostPlatform.macOS}),
      ciGoldensConfig: const CiGoldensConfig(diffThreshold: 0.005),
    ),
    run: testMain,
  );
}
