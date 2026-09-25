---
name: golden-toolkit-legacy
description: How golden tests were set up and written in Civic24 with the discontinued golden_toolkit package, before the Phase 2 migration to alchemist. Use when reading or restoring the old tests, comparing old and new baselines, or explaining what the migration changed. Not for writing new golden tests (use alchemist, see README "Golden Tests Guide").
---

# golden_toolkit as used in Civic24 (before alchemist)

**Reference commit:** `211cc25` (last commit on `develop` before the migration, `test/replace-golden-toolkit-with-alchemist`).
Read any old file with `git show 211cc25:<path>`; list the old baselines with `git ls-tree -r --name-only 211cc25 packages/components/test | grep goldens`.

## Why it was replaced
`golden_toolkit` 0.15.0 was last published in February 2023 and is marked discontinued on pub.dev (no replacement named). It still compiled on Flutter 3.47, but it would not get fixes. It also only asserted on macOS and Windows, so CI (Ubuntu) skipped every golden test and visual regressions were never caught in review. `alchemist` is maintained and adds portable CI images. Migration plan: Phase 2, step 6 of `docs/CIVIC24_REFACTOR_PROMPT.md`.

## Setup (all under `packages/components`)
- `pubspec.yaml` dev dependency: `golden_toolkit: ^0.15.0` (also listed in `apps/citizen` and `apps/admin`, unused there).
- Fonts: Poppins is declared in `packages/assets/pubspec.yaml`; `loadAppFonts()` loads every font in the font manifest so images show real text.
- `test/flutter_test_config.dart` (runs before every test file in the package):

```dart
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();                       // real Poppins and icon fonts
  return GoldenToolkit.runWithConfiguration(
    testMain,
    config: GoldenToolkitConfiguration(
      // assertions ran on macOS and Windows only, so Linux CI skipped them
      skipGoldenAssertion: () => kIsWeb || !Platform.isMacOS && !Platform.isWindows,
      enableRealShadows: true,
      defaultDevices: const [Device.iphone11],
    ),
  );
}
```

## Helpers (`test/helpers/`)
- `golden_test_helpers.dart`
  - `testableWidget(child, {dark = false})`: `MaterialApp` with `AppTheme.lightThemeData` / `darkThemeData`, `themeMode`, locale `en`, `appSupportedLocales`, `appLocalizationsDelegates`, `home: Scaffold(body: Center(child))`.
  - `customMaterialAppWrapper({dark})`: same app as a `Widget Function(Widget)` for `pumpDeviceBuilder(wrapper: ...)`.
- `golden_test_utils.dart`: `runBasicGoldenTest` (light and dark in a column) and `runInteractiveGoldenTest` (`DeviceBuilder` plus an `onCreate` interaction). Neither was used by any test.

## Test pattern (every component test file had exactly these two tests)
```dart
void main() {
  final devices = [Device.phone];

  // 1. Scenarios in one column, light and dark
  testGoldens('$AppFilterChip', (tester) async {
    const scenarioHeight = 120.0;
    final builder = GoldenBuilder.column()
      ..addScenario('$AppFilterChip unselected state with light theme',
          SizedBox(height: scenarioHeight, child: testableWidget(AppFilterChip(/* ... */))))
      ..addScenario('$AppFilterChip unselected state with dark theme',
          SizedBox(height: scenarioHeight, child: testableWidget(AppFilterChip(/* ... */), dark: true)));
    await tester.pumpWidgetBuilder(builder.build(), surfaceSize: const Size(500, 1000));
    await screenMatchesGolden(tester, '$AppFilterChip');
  });

  // 2. Same widget at device size(s)
  testGoldens('$AppFilterChip – General', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: devices)
      ..addScenario(widget: testableWidget(/* ... */), name: '... light theme')
      ..addScenario(widget: testableWidget(/* ... */, dark: true), name: '... dark theme');
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, '$AppFilterChip – General', autoHeight: true);
  });
}
```
Device sizes in golden_toolkit 0.15.0: `Device.phone` 375x667, `Device.iphone11` 414x896 (pixel ratio 1.0), `Device.tabletPortrait` 1024x1366, `Device.tabletLandscape` 1366x1024. The showcase test used `[phone, tabletPortrait]`. `autoHeight: true` crops the image to its content.

## Baselines
- Saved as `test/<component>/goldens/<name>.png`, name = the string passed to `screenMatchesGolden` (for example `AppFilterChip.png`, `AppFilterChip – General.png`). 19 images, macOS-rendered, readable, committed.
- Failures wrote `failures/*_masterImage|testImage|maskedDiff|isolatedDiff.png` next to the test (gitignored).

## Commands (Melos scripts in the root `pubspec.yaml` at `211cc25`)
- Check: `melos run components:golden` (or `test:golden`), that is `flutter test --tags golden` through `bin/test.sh`.
- Update: `melos run components:update:golden` (`flutter test --tags golden --update-goldens`). Only for an intentional visual change.
- `melos run flutter:test` ran them too, but only on macOS and Windows.

## Gotchas
- Baselines were generated on macOS: another macOS version or Mac model could differ by anti-aliasing.
- After Flutter 3.47 the old baselines were stale because component text moved from `bodySmall` to `bodyMedium` in Aug 2025 and CI never ran them (fixed in PR #38).
- Pass `surfaceSize` to `pumpWidgetBuilder` (the tests used 500x700, 500x1000 or 600x1000); without it the default test canvas is used and scenarios can overflow.
- Tests need the placeholder env values (`--dart-define-from-file`); `bin/test.sh` passes them.

## What the alchemist migration changed
| golden_toolkit | alchemist (now) |
|---|---|
| `testGoldens` + `GoldenBuilder.column` | `goldenScenarios` helper (`GoldenTestGroup`, `GoldenTestScenario`) |
| `DeviceBuilder` + `Device.*` | `goldenDeviceScenarios` helper with `GoldenDevice` sizes |
| `screenMatchesGolden(name)` | `fileName:` argument, snake case |
| one readable image set, macOS/Windows only | `goldens/macos` readable set (macOS only) + `goldens/ci` portable set (checked in CI, 0.5 percent tolerance) |
| `loadAppFonts()` from the package | `test/helpers/load_app_fonts.dart` (reads `FontManifest.json`) |
