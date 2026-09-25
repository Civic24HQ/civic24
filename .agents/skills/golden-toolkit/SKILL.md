---
name: golden-toolkit
description: Set up, write and run Flutter golden (screenshot) tests with the golden_toolkit package (eBay Motors), without alchemist. Covers dependency and font setup, flutter_test_config.dart, GoldenBuilder and DeviceBuilder tests, generating and updating baselines, CI and cross-platform caveats, and troubleshooting. Use when a project already uses golden_toolkit or must keep using it. The package is discontinued, so prefer alchemist for new work.
license: MIT
metadata:
  package: golden_toolkit 0.15.0
  status: discontinued upstream
---

# golden_toolkit (Flutter golden tests)

## What it is, and its status
`golden_toolkit` adds helpers on top of `flutter_test` for golden tests: render a widget, save a PNG baseline, and fail when a later render differs. It gives you
- `testGoldens`, `screenMatchesGolden`, `multiScreenGolden`
- `GoldenBuilder` (many scenarios in one image) and `DeviceBuilder` (scenarios at device sizes)
- `loadAppFonts()` so images show your real fonts and icons instead of the test framework's black-box font
- `GoldenToolkit.runWithConfiguration` for global settings

**It is discontinued.** pub.dev marks it discontinued with no replacement named; the last release is 0.15.0 (February 2023) and it declares a Dart 2 SDK range (`<3.0.0`), which Dart 3 tooling tolerates. It keeps working with recent Flutter versions but will not get fixes. For new work use `alchemist` (a maintained package inspired by it). Use this skill to keep an existing setup running.

## Setup
1. Add the dev dependency: `flutter pub add --dev golden_toolkit`.
2. Declare your fonts in `pubspec.yaml` (`flutter: fonts:`). Fonts declared in packages you depend on are loaded too.
3. Create `test/flutter_test_config.dart`. Flutter runs it before every test file in that package:
```dart
import 'dart:async';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts(); // without this, text and icons render as black boxes
  return GoldenToolkit.runWithConfiguration(
    testMain,
    config: GoldenToolkitConfiguration(
      enableRealShadows: true,            // default false
      defaultDevices: const [Device.phone, Device.tabletLandscape], // default
      // skipGoldenAssertion: () => !Platform.isMacOS, // see "CI and platforms"
    ),
  );
}
```
4. Write a test (below), generate baselines, commit the PNGs.

## Writing tests
Wrap the widget in an app that supplies theme, locale and localization; the golden output is only as good as that wrapper. Full helper and test files: [references/EXAMPLES.md](references/EXAMPLES.md).

**One image, several scenarios** (states, light and dark themes):
```dart
testGoldens('Button states', (tester) async {
  final builder = GoldenBuilder.column()
    ..addScenario('enabled', wrap(const MyButton()))
    ..addScenario('disabled', wrap(const MyButton(enabled: false)));
  await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 400));
  await screenMatchesGolden(tester, 'my_button');
});
```
`GoldenBuilder.grid(columns: n, widthToHeightRatio: r)` lays scenarios out as a grid.

**The same widget at device sizes:**
```dart
testGoldens('MyScreen on devices', (tester) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [Device.phone, Device.tabletPortrait])
    ..addScenario(widget: const MyScreen(), name: 'default');
  await tester.pumpDeviceBuilder(builder, wrapper: materialAppWrapper());
  await screenMatchesGolden(tester, 'my_screen', autoHeight: true);
});
```
`multiScreenGolden(tester, 'name', devices: [...])` writes one PNG per device instead.

Key options: `pumpWidgetBuilder(widget, wrapper:, surfaceSize:, textScaleSize:)` (default surface 800x600, text scale 1.0); `screenMatchesGolden(tester, name, autoHeight:, finder:, customPump:, skip:)`; `autoHeight: true` crops the image to its content; a `finder` captures one widget.

Device presets: `Device.phone` 375x667, `Device.iphone11` 414x896 (pixel ratio 1), `Device.tabletPortrait` 1024x1366, `Device.tabletLandscape` 1366x1024. Create your own with `Device(name:, size:, devicePixelRatio:, textScale:, brightness:, safeArea:)`.

## Run and update
- Check: `flutter test --tags golden` (every `testGoldens` test is tagged `golden` by default; change with the `tags` config field).
- Create or update baselines: `flutter test --tags golden --update-goldens`. Do this only for an intentional visual change, and review the diff of the images.
- Baselines are saved next to the test file as `goldens/<name>.png` (`goldens/<name>.<device>.png` for `multiScreenGolden`). Change the layout with `fileNameFactory` / `deviceFileNameFactory` in the configuration.
- On failure, `failures/` gets `<name>_masterImage.png`, `_testImage.png`, `_maskedDiff.png` and `_isolatedDiff.png`. Do not commit that folder.

## CI and platforms
Rendered pixels differ between operating systems (font rasterization, anti-aliasing) and sometimes between OS versions or CPU types. Options:
- Generate baselines on the same OS that checks them. Simplest: generate and check on the CI image.
- Or check only where they were generated: `skipGoldenAssertion: () => !Platform.isMacOS` (the test still runs, so it is not verified elsewhere).
- Neither option tolerates small pixel differences: `golden_toolkit` has no diff threshold. If you need one, install a custom `GoldenFileComparator` in `testExecutable` or switch to `alchemist`, which offers a threshold and portable "CI" images.

## Troubleshooting
| Symptom | Cause and fix |
|---|---|
| Black boxes instead of text or icons | `loadAppFonts()` not called, or the font is not declared in `pubspec.yaml` |
| Overflow errors or clipped scenarios | Set `surfaceSize`, or give each scenario a fixed `SizedBox` height |
| Widget throws about missing theme, `MediaQuery`, localizations | Pass a `wrapper:` that supplies them (see the example wrapper) |
| Passes locally, fails on CI (or the other way round) | Different OS: see "CI and platforms" |
| "No such file" for a baseline | Baselines do not exist yet: run with `--update-goldens` |
| Shadows missing | Set `enableRealShadows: true` |
| Test env values or plugins needed by the widget | Provide test doubles; golden tests build the real widget tree |

## Moving to alchemist
| golden_toolkit | alchemist |
|---|---|
| `testGoldens` + `GoldenBuilder` | `goldenTest` + `GoldenTestGroup` / `GoldenTestScenario` |
| `DeviceBuilder` | scenarios wrapped in `SizedBox` of the device size |
| `screenMatchesGolden(name)` | `fileName:` argument |
| `loadAppFonts()` | not provided: load fonts yourself from `FontManifest.json` for readable "platform" images |
| one image set | separate portable "CI" images (Ahem font, tolerance) and readable platform images |
