# Civic24 Refactor Change Log

Running log for the refactor described in `docs/CIVIC24_REFACTOR_PROMPT.md` (master plan). Newest phase first within each section. Evidence levels follow `AGENTS.md` §7.1: **L1** static analysis, **L2** local build and tests, **L3** live cloud or device.

---

## Phase 3: iOS, Swift Package Manager and native config (started 25 Sept 2026)

Owner answers: no Apple Developer account for now (see the suspended-work section below), remove background location, include Sign in with Apple, adopt UIScene, add the privacy manifest, separate flavor display names.

### 3.1 PR 1: Swift Package Manager (`chore/migrate-ios-to-swift-package-manager`)

| Change | Why |
|---|---|
| Flutter's own migration integrated `FlutterGeneratedPluginSwiftPackage` (frameworks phase, package reference) and added the "Run Prepare Flutter Framework Script" pre-action to all three flavor schemes | Flutter only migrates the scheme it builds, so `flutter build ios --config-only` was run for development, staging and production |
| CocoaPods removed: `pod deintegrate`, `Podfile`, `Podfile.lock`, the `Pods` group and the `Pods.xcodeproj` workspace reference | Flutter reported "All plugins found for ios are Swift Packages". The 310 lockfile entries and the `post_install` hook (forced 13.0, silenced warnings, `PERMISSION_LOCATION=1`) are gone |
| One deployment target, 15.0, in every configuration; `MinimumOSVersion` removed from `AppFrameworkInfo.plist` | Was 13.0 in the project and 15.0 in the Podfile; Firebase iOS SDK 12.19.0 needs 15 |
| `Package.resolved` committed (`Runner.xcworkspace/xcshareddata/swiftpm/`); the duplicate under `Runner.xcodeproj` and the `configuration` folders are ignored | Reproducible builds. `firebase-ios-sdk` 12.19.0, 21 pins |
| Crashlytics symbol-upload Run Script rewritten | The old script only looked in DerivedData, so `flutter build ios` failed (found in the Phase 2 trial). Now: skip Debug builds, look in `<project>/build/ios/SourcePackages` and DerivedData, fail the build only for `Release-production`, warn for other configurations, warn if the FlutterFire CLI is missing |
| UIScene lifecycle adopted (own commit): `AppDelegate` is a `FlutterImplicitEngineDelegate`, `Info.plist` gets `UIApplicationSceneManifest` | Owner approved; part of the same Flutter migration run, kept as a separate commit |

**Verification (Level 2, local build):** `flutter build ios --no-codesign --flavor development -t lib/main.dart --dart-define-from-file=secrets/development.json` exits 0 (`Built build/ios/iphoneos/Civic24_DEV.app`, 97 MB) with no CocoaPods. This is the first successful iOS build of the refactor.

**Simulator run (Level 2):** `flutter build ios --simulator --debug --flavor development ...` builds, and the app installs and launches on an iPhone 17 Pro simulator (iOS 26.5): splash screen, then the login screen (Poppins, logo, email and password fields, "Continue with Google"). The log shows Firebase 12.19.0 (Core, Crashlytics, Analytics, Remote Config, Messaging) starting, "Connecting to Firebase on Development" from `bootstrap.dart`, and no crash. The only Firebase error is `no valid "aps-environment" entitlement` when registering for remote notifications, which is expected: there is no entitlements file until the Apple account exists (items A3 and A4 in `docs/APPLE_DEVELOPER_ACCOUNT.md`).

**Not verified:** sign-in (needs an interactive session), Firestore reads (App Check enforcement not checked), the Xcode GUI, staging and production builds (production is deliberately not built here because a Release-production build uploads symbols to the production Crashlytics project), a physical device, a symbolicated crash (needs Firebase, Phase 5).

**Local notes:** the FlutterFire CLI had to be installed for the upload script; a failed build leaves read-only files under `build/ios/SourcePackages` (delete with `chmod -R u+w` first); the Mac's data disk was at 98 percent (4 GB free) and a build failed with "database or disk is full", so about 4 GB of regenerable build files (`apps/citizen/build`, DerivedData) were deleted. A full iOS build needs several GB free.

### 3.2 PR 2: permissions, privacy manifest, Google config, display names (`chore/clean-up-ios-permissions-and-google-config`)

| Change | Why |
|---|---|
| `location` background mode, `NSLocationAlwaysAndWhenInUseUsageDescription`, `NSLocationAlwaysUsageDescription` and `NSLocationUsageDescription` removed; when-in-use text reworded | Owner decision. The app reads the location once while open (`Geolocator.getCurrentPosition`), so it never needs background or Always access. Answers the CodeRabbit comment on #60 |
| `ITSAppUsesNonExemptEncryption` is now boolean `false` (was the string `NO`) | Apple expects a boolean |
| `Runner/PrivacyInfo.xcprivacy` added and registered in the Runner Resources phase | Apple requires an app manifest (tracking, collected data, required-reason APIs). Draft from the plugins in use; **owner to confirm the data table before any submission** |
| Google Sign-In: Dart passes `IOS_CLIENT_ID` (already an env key) to `GoogleSignIn.initialize` on iOS; new last Run Script phase "Register Google Sign-In URL Scheme" writes the flavor plist's `REVERSED_CLIENT_ID` into the built `Info.plist`; `GIDClientID` removed | The IDs used to come from `Debug.xcconfig` and `Release.xcconfig`, which every `Debug-*` and `Release-*`/`Profile-*` configuration shares, so all flavors got one Google ID. The URL-scheme step must run after Info.plist processing: in the flavor-plist phase it was overwritten (found while testing) |
| xcconfig templates and Google values deleted; plain `#include "Generated.xcconfig"` versions of `Debug.xcconfig` and `Release.xcconfig` committed and un-ignored; unused `Staging.xcconfig` removed | Nothing custom is left in them. Bundle IDs and product names were already per-configuration build settings |
| `CFBundleDisplayName` = `$(APP_DISPLAY_NAME)` with `Civic24 DEV`, `Civic24 STG`, `Civic24` per configuration | Owner decision: distinguishable icons |
| `permission_handler_apple` reviewed (no change needed) | 9.6.1 ships an SPM manifest that enables permissions from the `Info.plist` usage strings. Resolved for this app: camera, photos, location while in use, notifications on; everything else, including Always location, off |
| Tool-generated `customLLDBInitFile` line in the staging scheme committed | Flutter added it during builds |

**Verification.** Built app inspected for all three flavors (`flutter build ios --simulator --debug`; production only as a Debug build, nothing signed in): display names as above, URL scheme equals each flavor's plist `REVERSED_CLIENT_ID`, `GIDClientID` absent, `PrivacyInfo.xcprivacy` present (development). **Sign-in (owner, iPhone 17 Pro simulator, development flavor):** before the change (baseline on `develop`) and after it, "Continue with Google" opened the sheet, returned to the app and logged in. `melos` bootstrap-free checks run separately: generated files up to date, format clean, analyze clean, `melos run flutter:test` passes. `melos run ci:check` as one command hung for 1 h 27 min at 0% CPU (parallel test runs waiting, probably clashing with simultaneous Flutter builds; not diagnosed) and was killed; the steps were then rerun one at a time.

**Not verified:** sign-in on staging and production; the URL scheme in Release builds (a Release production build is deliberately not made locally); Sign in with Apple (suspended, no entitlement); whether App Check is enforced (sign-in and the feed worked on the simulator); the privacy manifest against Apple's validator (needs App Store Connect); runtime permission prompts.

**Contributor impact:** an iOS contributor needs their own `ios/config/<flavor>/GoogleService-Info.plist` and `IOS_CLIENT_ID` in their env JSON; no xcconfig editing. Old local xcconfigs with real values should be replaced by the committed ones. The client ID is a public identifier and was not rotated.

Owner-facing follow-ups: confirm the privacy manifest data table.

### 3.4 Fix: D17, permanent permission denial lost on Android (`fix/keep-permanent-permission-denial`)
**Problem.** `PermissionService` stored `Permission.status` at start-up and in `refreshPermissions()`. On Android `status` never reports `permanentlyDenied` (only a `request()` result can), so after "don't ask again" and a restart, `isLocationPermissionDenied` and `isNotificationPermissionDenied` were false. No screen reads those getters yet, so the bug was latent.

**Fix.** A permanent denial seen in a request (or reported directly by the platform, as iOS does) is remembered in the settings box (`SettingsStorageService.isPermissionPermanentlyDenied` / `setPermissionPermanentlyDenied`, keyed by the permission's value) and restored whenever `status` reports plain `denied`. It is cleared when the permission is granted, limited or provisional. Notification denials are still counted as before.

**Review follow-ups (own review on #64).** Storage is written only when the remembered value changes (the once-a-second `refreshPermissions()` poll used to write on every granted pass); the flag is keyed by the permission's name (`Permission.location`) rather than the plugin's numeric index; the getters document that the flag can outlive the real state if the user resets the permission to "Ask every time" in Settings (Android 11+) without granting it, so callers must request first and trust the result. A seventh test covers the write behaviour. **CodeRabbit follow-up:** a `request()` result is now authoritative: a plain `denied` from a request means the system could still show its dialog (for example after a Settings reset), so the remembered denial is cleared instead of restored; only status checks restore it. An eighth test covers this and fails on the previous commit.

**Known limit.** Sign-out clears every storage box, including this flag. That self-heals: on Android, requesting a permission after "don't ask again" returns `permanentlyDenied` at once without a dialog, and the flag is stored again.

**Verification (Level 2).** Eight unit tests in `permission_service_test.dart` (six in the first commit) fake the permission plugin's platform channel and use an in-memory settings store. Run against the old `PermissionService` they fail (3 of 6: denial remembered after a restart, for location and for notifications, and iOS-reported denial remembered); with the fix all 6 pass. Generated files, format, analyze and the whole test suite pass, run one step at a time. **Not verified:** on a real Android device or emulator (Android cannot be built until Phase 4; confirm there in Phase 5), and how the plugin behaves on Android versions with the runtime notification permission.

---

## Apple Developer account: suspended work (25 Sept 2026)

Owner decision: there is no Apple Developer Program account for now (Phase 3 questions, answer 1). Everything that needs one is suspended and collected in `docs/APPLE_DEVELOPER_ACCOUNT.md` (items A1 to A15, effects per phase, and the order of a separate "Apple phase" to run once the account exists). Phase 3 PR 3 (entitlements and capabilities) is suspended; PR 1 and PR 2 go ahead. The plan and `AGENTS.md` carry the same rule. Phase 3 decisions taken with this: remove background location, include Sign in with Apple in the app (its capability is suspended), adopt the UIScene change, add the privacy manifest, separate flavor display names.

---

## Phase 2: Dependency upgrade and deprecations (completed 25 Sept 2026)

Six PRs (owner approved): (1) tooling and leaf packages, (2) Firebase suite, (3) device plugins, (4) UI packages, (5) replace `golden_toolkit` with `alchemist`, (6) deprecations. Everything goes to the latest version unless a strong reason is logged. Evidence level: local analysis, generation, format check and tests; the app cannot be built or launched until the development secrets are added and Phase 3 and 4 land.

### 2.1 PR 1: tooling and leaf packages (`chore/upgrade-tooling-and-leaf-packages`)

| Package | From | To | Notes |
|---|---|---|---|
| `flutter_gen_runner` | 5.12.0 | 5.15.0 | Old `build_runner` caches made it skip its output and delete `assets.gen.dart` and `fonts.gen.dart`. Fix: `dart run build_runner clean` once. Generated output changed by a few lines |
| `flutter_svg` | 2.2.0 | 2.3.0 | |
| `build_runner` | 2.15.2 | 2.16.1 | needed `--unlock-transitive` (`build` 4.0.11) |
| `uuid` | 4.5.3 | 4.6.0 | |
| `hive_ce` | 2.15.1 | 2.20.0 | |
| `crypto`, `mime`, `path_provider`, `flutter_native_splash` (2.4.8) | patch and minor | latest | |
| `flutter_timezone` | 4.1.1 | 5.1.0 | Its API now returns `TimezoneInfo`, but nothing in the code calls it (see below) |

Lower bounds were tightened to the versions tested (`flutter pub upgrade --tighten`).

**Held back, with the reason (the one exception to "everything to the latest"):**
- **`flex_color_scheme` stays at 8.4.0 (latest is 9.0.0).** Version 9 depends on the standalone `material_ui` and `cupertino_ui` packages, so `FlexThemeData` returns `material_ui`'s `ThemeData` instead of Flutter's. `packages/styles` failed with about 10 type errors (`ThemeData`, `Typography`, `TextTheme`, `DialogThemeData`, theme extensions). Adopting it means migrating every `package:flutter/material.dart` import to `material_ui`, which is the Material and Cupertino decoupling migration, planned as its own PR before the November 2026 stable. Version 9 also defaults `useExpressiveOnContainerColors` to true, which changes light theme on-container colors.
- **`freezed` stays at 4.0.1** (latest 4.0.2): 4.0.2 needs `analyzer` ^14, but `intl_utils` 2.8.16 (the latest, used in `packages/localization`) needs `analyzer` ^13. Moves when `intl_utils` supports `analyzer` 14. `platform` stays at 3.1.6 (latest 3.2.0): another package's constraint stops it resolving today; recheck after PR 3.
- **`timezone` stays at ^0.10.0** (latest 0.11.1): `flutter_local_notifications` 19 requires `^0.10`. It moves in PR 3 with `flutter_local_notifications` 22.

**Findings**
- `flutter_timezone` and `timezone` are declared in `packages/utils` but no Dart file uses them. Cleanup candidate for the refactor PR (PR 6) or Phase 8.
- Tests, analysis, format check and golden tests pass after the upgrade (`melos run ci:check` exit 0). No golden baselines changed.

**Google Auth Platform notice (owner email, 17 Sept 2026), for Phase 5.** Google will delete OAuth clients in `civic24-sdg11` that have been inactive for 5 months, 30 days after the email, so around **17 October 2026**. Deleted clients can be restored in the Cloud Console for 30 days. The clients the production app needs are the Web client (`WEB_CLIENT_ID`), the Android client for `co.civic24.citizen`, and the iOS client for the production bundle ID (the iOS app has never shipped, so it is likely one of the inactive ones). A client counts as used when it is used in a Sign in with Google flow. Owner to list the clients in the Cloud Console (open it directly, not through the email links) and sign in with Google on the live production app to refresh the Web and Android ones. The iOS one can only be refreshed once an iOS build exists (after Phase 3), or restored after deletion.

### 2.2 PR 2: Firebase suite (`chore/upgrade-firebase-suite`)

All ten FlutterFire packages upgraded together, within their current majors (no code changes were needed):

| Package | From | To |
|---|---|---|
| `firebase_core` | 4.7.0 | 4.15.0 |
| `firebase_auth` | 6.1.4 | 6.7.0 |
| `cloud_firestore` | 6.1.2 | 6.10.0 |
| `firebase_messaging` | 16.1.1 | 16.7.0 |
| `firebase_analytics` | 12.1.1 | 12.6.0 |
| `firebase_crashlytics` | 5.0.7 | 5.4.0 |
| `firebase_storage` | 13.0.6 | 13.6.0 |
| `firebase_remote_config` | 6.2.0 | 6.7.0 |
| `firebase_performance` | 0.11.1+4 | 0.11.6 |
| `firebase_app_check` | 0.4.3 | 0.4.8 |

Platform interface and web packages moved with them (30 packages changed in the lockfile).

**Why:** the iOS CD build failed because `firebase_remote_config 6.2.0` and `firebase_storage 13.0.6` needed different FlutterFire Swift packages. Checked in the plugin sources: all ten plugins now pin the **same** Firebase iOS SDK (`12.19.0`) in their `Package.swift`, so Swift Package Manager can resolve them. Not yet proven by an actual `flutter build ios` (needs the development secrets and Firebase files).

**Tooling note:** `flutter pub upgrade --major-versions --unlock-transitive <packages>` crashes pub in this workspace ("Null check operator used on a null value" in `package_graph.dart`); the constraints were set directly to the latest versions and resolved with `flutter pub get`.

**Verification:** `melos run ci:check` exit 0 (generation, generated-files check, format, analyze, tests). App build and Firebase behavior not verified (Level 1 to 2 only).

### 2.3 PR 3: device plugins (`chore/upgrade-device-plugins`)

| Package | From | To | Code change |
|---|---|---|---|
| `flutter_local_notifications` | 19.5.0 | 22.3.1 | Yes: `initialize` and `show` now take named parameters (`settings:`, `id:`, `title:`, `body:`, `notificationDetails:`) in `LocalNotificationService` |
| `geocoding` | 4.0.0 | 5.0.0 | Yes: functions moved into a `Geocoding` class (`Geocoding().placemarkFromCoordinates(...)`) in `LocationService` |
| `timezone` | 0.10.1 | 0.11.1 | No (moves with `flutter_local_notifications`) |
| `sign_in_with_apple` | 7.0.1 | 8.2.0 | No. Adds Swift Package Manager support; minimum Flutter 3.44 |
| `permission_handler` | 11.4.0 | 12.0.3 (**held**, latest is 13.0.2) | No. See the hold note below |
| `image_cropper` | 11.0.0 | 12.2.1 | No. iOS crop UI moves to TOCropViewController 3.1.1 (new Liquid Glass look) |
| `package_info_plus` | 9.0.1 | 10.2.1 | No |
| `app_settings` | 7.0.0 | 9.0.0 | No |
| `internet_connection_checker_plus` | 2.9.1+2 | 3.1.2 | No |
| `google_sign_in` | 7.1.1 | 7.2.0 | No (still the v7 API) |
| `geolocator` 14.0.3, `image_picker` 1.2.3, `android_intent_plus` 6.1.0, `flutter_image_compress` 2.5.1, `shorebird_code_push` 2.0.7 | patch | latest | No |

`flutter_image_compress_common` 1.1.1, `sign_in_with_apple` 8.2.0 and `permission_handler_apple` 9.6.1 are the three plugins that were CocoaPods-only in the Phase 0 audit; they now ship Swift Package Manager support.

**Verification:** `melos run ci:check` exit 0. Not verified: runtime behavior of any of these plugins on a device (the test suite is nearly empty). Device test list for Phase 5: local and foreground notification display and tap, Google and Apple sign-in, location permission prompts and address lookup, image pick and crop, app settings deep link, connectivity banner.

**Notes for Phase 3 and 4 (found while upgrading):**
- **`permission_handler` is held at 12.0.3 (exception to "everything to the latest", raised in PR review).** `permission_handler_android` 14.1.0 (from `permission_handler` 13) compiles against `compileSdk = 37`, and Android requires **AGP 9.1.1 or newer with Gradle 9.3.1 or newer** for API 37. Flutter 3.47 and Shorebird are validated on AGP 8.11.x, so 13 would force a new major Android toolchain. Every other Android plugin compiles at 36 or lower (checked in the plugin sources). 12.0.3 resolves with `permission_handler_android` 13.0.1 and `permission_handler_apple` 9.6.1 (Swift Package Manager ready). **Phase 4 decision for the owner:** move to AGP 9.1.1+ and Gradle 9.3.1+ (then take `permission_handler` 13), or stay on AGP 8.11.x and keep 12.x.
- **AGP 8.11.1:** `flutter_local_notifications` 22.3.1 lists AGP 8.11.1 in its own `build.gradle`; that is how the plugin builds itself, not a requirement for apps. Phase 4 raises AGP to at least 8.11.1 anyway (Shorebird's minimum for Flutter 3.47), so no action.
- **Defect D17 (found in review, not caused by this PR): permanent denial is lost on Android.** `PermissionService._init()` and `refreshPermissions()` store `Permission.status`, but on Android `status` can never report `permanentlyDenied` (the plugin source says a status check cannot detect it); only the `request()` result can. After an app restart, `isLocationPermissionDenied` and `isNotificationPermissionDenied` are false even after "don't ask again". Fix in a separate `fix/` PR after Phase 2 (remember the denial and clear it only when granted), then confirm on a device in Phase 5.
- **Podfile:** `permission_handler` still relies on `GCC_PREPROCESSOR_DEFINITIONS` in the Podfile (`PERMISSION_LOCATION=1`, `PERMISSION_LOCATION_WHENINUSE=0`, `PERMISSION_NOTIFICATIONS=1`). Those are removed with CocoaPods in Phase 3, so the permissions have to be enabled in the way `permission_handler_apple` documents for Swift Package Manager.
- **iOS 15:** the minimum iOS deployment target moves to 15.0 (Flutter raised it automatically in a trial build).

**iOS build trial after PR 2 (development flavor, using the owner's development files):** `flutter build ios --no-codesign --flavor development` now gets through "Xcode is fetching Swift Package Manager dependencies" with no resolution error, which is the failure the CD run hit. It then stops because `ios/Flutter/Release.xcconfig` (and Debug and Staging) do not exist: only `*.xcconfig.template` files are in the repo, and the owner adds the real ones. The templates also say "copy to Development.xcconfig" while the files are named Debug, Release and Staging; fix the wording in Phase 3.
During that build Flutter edited the tracked iOS project on its own (it was reverted, nothing committed): `AppDelegate.swift` adopts `FlutterImplicitEngineDelegate` (`didInitializeImplicitFlutterEngine` registers plugins), `Info.plist` moves `GIDClientID` and the Google URL scheme entries and drops their comments, `MinimumOSVersion` removed from `AppFrameworkInfo.plist`, `Podfile`, `Podfile.lock` and `project.pbxproj` rewritten, and Swift Package Manager workspace folders added. Phase 3 does these deliberately and reviews each diff.

**iOS build trial with the xcconfigs in place (branch with all PR 3 upgrades, development flavor, `flutter build ios --no-codesign --flavor development`):**
- Swift Package Manager resolves and downloads every dependency (no `flutterfire` version conflict). All plugins, including the upgraded ones, compile. The build then fails **only** in the Crashlytics symbol-upload Run Script: `Could not find the Crashlytics upload symbols script at ".../DerivedData/Runner-.../SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"`. For `flutter build ios` (command line) the Swift package checkouts are under `apps/citizen/build/ios/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run`, not under DerivedData; the script only looks under DerivedData (the comment in the script explains the Firebase docs path did not work either). Phase 3 rewrites the script to check both locations.
- Two local tooling gaps found on the way: the FlutterFire CLI must be installed (`dart pub global activate flutterfire_cli`; the same script calls it), and a failed build leaves read-only files under `build/ios/SourcePackages` ("grpc.framework couldn't be removed"); fix by deleting `build/ios` and `~/Library/Developer/Xcode/DerivedData/Runner-*` before rebuilding.
- **The xcconfigs are not per flavor (important for Phase 3).** `project.pbxproj` uses `Debug.xcconfig` for every `Debug-*` configuration (development, staging and production), and `Release.xcconfig` for every `Release-*` and `Profile-*` configuration of all three flavors. `Staging.xcconfig` is not referenced by any configuration. So `GOOGLE_CLIENT_ID` and `GOOGLE_REVERSED_CLIENT_ID` are the same for all flavors in a given build mode, and a staging or production Release build reads the same client ID as development. That cannot be right for flavors with different bundle IDs and Firebase apps (the iOS OAuth client is tied to the bundle ID). This is a strong reason to derive both values from each flavor's `GoogleService-Info.plist` (Phase 3 plan) instead of hand-written xcconfigs. The bundle ID line in the xcconfig is ignored (the project sets `PRODUCT_BUNDLE_IDENTIFIER` per configuration).
- `Release.xcconfig` was first created as `Release.xccconfig` (typo); git did not ignore it, so it showed up as untracked and could have been committed. Renamed; the `.gitignore` rule now matches.

### 2.4 PR 4: UI packages (`chore/upgrade-ui-packages`)

| Package | From | To | Code change |
|---|---|---|---|
| `country_flags` | 3.3.0 | 4.1.2 | Yes: flag size moved into `ImageTheme` (`CountryFlag.fromCountryCode(code, theme: const ImageTheme(height: ..., width: ...))`) in `ProfileView` and `CompleteProfileView` |
| `dotted_border` | 2.1.0 | 3.1.0 | Yes: options moved into `RoundedRectDottedBorderOptions` in `FileUpload` |
| `cached_network_image` | 3.4.1 | 4.0.2 | No. Version 4 depends on the standalone `material_ui` package instead of `flutter/material.dart` (see note) |
| `shimmer` | 2.0.0 | 4.0.0 | No |
| `smooth_page_indicator` | 1.2.1 | 3.0.0 | No |
| `lottie` | 3.3.1 | 3.6.1 | No |

**Golden baselines:** 3 images changed and were refreshed in their own commit: `FileUpload.png`, `FileUpload - General.png` and `Civic24_Components_Showcase.png` (0.1 to 0.6 percent of pixels). Compared side by side and with the diff image: layout, colors and text are identical; only the dashes of the dotted border are drawn slightly differently (`dotted_border` 3). All other goldens, including the ones that use shimmer and smooth_page_indicator, are unchanged.

**Note:** `cached_network_image` 4 pulls `material_ui` (and `cupertino_ui`) into the app as transitive dependencies, next to Flutter's own Material. It compiles and nothing in our code touches its Material types. The Material and Cupertino decoupling PR (before the November 2026 stable) will bring `flex_color_scheme` 9 with it.

**Held back (all still at the latest allowed):** `flex_color_scheme` 8.4.0 (needs the `material_ui` migration), `freezed` 4.0.1 (`intl_utils` needs `analyzer` 13), `permission_handler` 12.0.3 (needs AGP 9.1.1+ for 13), `platform` 3.1.6 (another package's constraint).

**Verification:** `melos run ci:check` exit 0. Not verified on a device: image loading and caching, shimmer placeholders, page indicators, Lottie animations, country flags in the pickers, and the dotted upload border.

### 2.5 PR 5: replace `golden_toolkit` with `alchemist` (`test/replace-golden-toolkit-with-alchemist`)

`golden_toolkit` 0.15.0 (last published February 2023) is discontinued on pub.dev. It was a dev dependency of `components`, `citizen` and `admin`; only `components` used it. Replaced by `alchemist` 0.14.0 (maintained by Betterment, heavily inspired by `golden_toolkit`).

**What changed**
- `alchemist` added to `components`; `golden_toolkit` removed from all three packages.
- `test/flutter_test_config.dart` uses `AlchemistConfig` with **two sets of images**: readable **macOS platform goldens** (`goldens/macos`, real Poppins and icons, loaded by `test/helpers/load_app_fonts.dart`, checked on macOS only, like the old images) and portable **CI goldens** (`goldens/ci`, text and icons drawn as squares with the Ahem font, shadows off, checked everywhere). Result: golden tests now assert on GitHub Actions too, so the temporary "goldens are skipped in CI" rule from Phase 1 is gone.
- The 10 test files were converted with the two helpers in `test/helpers/golden_test_utils.dart`: `goldenScenarios` (was `testGoldens` with `GoldenBuilder.column`) and `goldenDeviceScenarios` (was `DeviceBuilder`, now with `GoldenDevice.phone` 375x667 and `GoldenDevice.tabletPortrait` 768x1024). The two unused old helpers (`runBasicGoldenTest`, `runInteractiveGoldenTest`) were replaced by these.
- The old baselines (`goldens/*.png`, 19 images) were deleted and replaced by 19 portable `goldens/ci/<name>.png` and 19 readable `goldens/macos/<name>.png`, both committed. Names are now snake case without spaces or dashes.
- The empty `citizen:golden` and `admin:golden` Melos scripts were removed (those apps have no golden tests). README golden guide, `AGENTS.md`, workflow README and `ci.yml` updated.

**Old versus new baselines (comparison required by the plan).** Compared side by side. The new `goldens/macos` images show the same content as the old ones (real text, icons, layout, colours, spacing) with two cosmetic differences: alchemist draws the scenario title above each scenario on a blue frame instead of the old grey canvas, and images are sized to their content. The `goldens/ci` images show the same layout with text and icons as squares by design.

**Where the readable images live (owner decision: commit both sets).** The repository `.gitignore` used to ignore `**/goldens/macos`; that rule was removed (Linux and Windows platform goldens stay ignored, none are generated). alchemist names the folder after the host operating system on purpose: readable images differ between operating systems, so they are only checked on macOS (`platforms: {HostPlatform.macOS}`); on Windows and Linux only the portable `goldens/ci` set runs. Trade-offs accepted: the readable images can differ between Macs (OS version, chip), only a Mac can update or verify them, they double the image files in git, and CI does not check them. `GoldenDevice.tabletPortrait` was aligned with golden_toolkit's size (1024x1366) and `tabletLandscape` added.

**Skill for the old library.** `.agents/skills/golden-toolkit/` holds a general, repository-independent guide to setting up and running `golden_toolkit` (which is discontinued), following the open Agent Skills format (folder with `SKILL.md`, plus `references/EXAMPLES.md`). It is listed in the README under "Skills".

**First attempt, and the fix (owner feedback on the PR).** The first commit only had the CI images, so the committed baselines looked like blank boxes where text and icons should be, which is hard to read in review. Adding the readable macOS set fixed that. Separately, the first CI run failed on Ubuntu because images generated on macOS differ from Ubuntu by anti-aliasing: `file_upload` 0.39 percent, `app_tabs` 3 pixels and the showcase 22 pixels (the other 16 matched exactly). The CI set now tolerates 0.5 percent difference, so Ubuntu passes and a real layout, size or colour change still fails.

**Verification:** `melos run ci:check` exit 0 on macOS with both sets (38 golden checks). Live proof that the CI set passes on Ubuntu: the CI run of this PR.

### 2.6 PR 6: deprecations (no PR needed)

Plan step 7 was to fix analyzer-reported deprecations (`withOpacity`, `WillPopScope`, Material 3 theme properties). Checked on 25 Sept 2026 after all upgrades: `melos run flutter:analyze` reports **no issues** (the `deprecated_member_use` lint is active in `packages/rules`, nothing turns it off), `dart fix --dry-run` says "Nothing to fix!", and a search finds no `withOpacity`, `WillPopScope` or `MaterialState` left (the code already uses `withValues`, `PopScope` and `WidgetState`). The only places that silence deprecations are generated files (`*.gen.dart`, mocks). No code change, so no PR. The Material and Cupertino decoupling is separate work planned before the November 2026 Flutter stable.

### 2.7 Phase 2 report

- **What changed and why:** PRs #44 to #48 (see 2.1 to 2.5): leaf packages, Firebase suite, device plugins, UI packages and the `golden_toolkit` to `alchemist` migration. 43 direct dependencies were behind at the start of Phase 2; 4 still are, each for a logged reason.
- **Still behind latest, on purpose:** `flex_color_scheme` 8.4.0 (9.x needs the `material_ui` migration), `permission_handler` 12.0.3 (13.x needs `compileSdk` 37 and AGP 9.1.1+), `freezed` 4.0.1 (4.0.2 needs `analyzer` ^14, `intl_utils` needs ^13), `platform` 3.1.6 (another package's constraint).
- **What broke and how it was fixed:** `flutter_gen_runner` deleted generated files after an upgrade (`dart run build_runner clean`); `flex_color_scheme` 9 broke the theme types (held); `flutter_local_notifications` 22 and `geocoding` 5 needed API changes; `country_flags` 4 and `dotted_border` 3 needed API changes; `pub upgrade --major-versions --unlock-transitive` crashes in this workspace (constraints set directly); CI failed once on Ubuntu because macOS-made golden images differ by anti-aliasing (tolerance added).
- **Verification:** `melos run ci:check` exit 0 (generation, generated-files check, format, analyze, tests including 38 golden checks on macOS); CI green on every PR. Level 1 to 2 only: no device or simulator run, no Firebase check.
- **iOS build trial (development flavor):** Swift Package Manager resolves and every plugin compiles; only the Crashlytics symbol-upload Run Script fails (Phase 3).
- **Android:** still cannot build: Gradle 8.13 is below Flutter 3.47's minimum 8.14 (Phase 4).
- **Blocked on the owner:** Google Auth Platform OAuth clients notice (deadline about 17 Oct 2026), Firebase inactivity check, production and staging secrets for Phase 5, decision on the Phase 4 Android toolchain (`permission_handler` 13 needs AGP 9.1.1+).
- **Next:** Dependabot for `pub` and `npm` (agreed for right after Phase 2), an optional cleanup of unused dependencies, then Phase 3 (iOS and Swift Package Manager).

### 2.8 Dependabot for pub and npm (PRs #50 and #55)

`.github/dependabot.yml` now covers `github-actions`, `pub` and `npm` (`/backend/functions`): monthly, minor and patch updates grouped by family (`firebase`, `ui-packages`, `device-plugins`, `build-and-test-tools`; npm: `firebase-functions`, `typescript-and-lint`), majors as separate PRs, a 3 day cooldown (7 for majors), `chore(deps)` prefix, `dependencies` label. It validates against GitHub's schema (`check-jsonschema --builtin-schema vendor.dependabot`). How to handle its PRs is in `.github/workflows/README.md`.

**First run (25 Sept 2026).** GitHub Actions: nothing to update. npm: opened 4 PRs. pub: **failed** with `dependency_services failed: Only apply dependency_services to the root of the workspace.` Cause: the member folders (`/apps/*`, `/packages/*`) were listed as well. Fix: `directory: /` only (#55). The answer to the open question from Phase 2: Dependabot's pub support works with our pub workspace when pointed at the root. It also reads the Flutter version from `.fvmrc`.

**Second run (after the fix): success.** It evaluated all dependencies of every workspace member (51 group checks) and opened no PR: the only packages behind latest are the four held ones (two are ignored in `dependabot.yml`; `freezed` 4.0.2 is inside the 3 day cooldown and blocked by `intl_utils` anyway; `platform` is blocked by another package).

**npm PRs handled.** #51 (`firebase-functions` 7.4.0, `firebase-functions-test` 3.5.0, grouped minor/patch) was checked (`npm ci` and `npm run build` pass) and merged. #52 (`@types/node` 22 to 26), #53 (`firebase-admin` 13 to 14) and #54 (`typescript` 5.7 to 7.0.2) are major updates that belong to the backend phase (Phase 6): closed with `@dependabot ignore this major version`, so they will not reopen. In Phase 6 upgrade these three by hand together with the rest of the backend (Dependabot then sees them as current).

**Note for Phase 6.** CI only checks the Flutter code, so backend PRs are not tested by it; a `backend` job (npm ci, build, lint) should be added before relying on Dependabot for `backend/functions`.

### 2.9 Cleanup: unused timezone packages (PR #57)

`flutter_timezone` and `timezone` were declared in `packages/utils` but no Dart file imports either (only a model field is called `timezone`). Both were removed. `flutter_timezone` left the lockfile, which drops one native plugin from the iOS, Android and desktop builds (the desktop `generated_plugins.cmake` and `generated_plugin_registrant.cc` files were regenerated); `timezone` stays only as a transitive dependency of `flutter_local_notifications`. `melos run ci:check` exit 0. Also removed the "Supabase CLI" prerequisite from `README.md` (no Supabase code or dependency exists); the other Supabase mentions in the README are still to be corrected in Phase 8.

---

## Phase 1: Toolchain, workspaces and Melos (24 Sept 2026)

Branch `chore/pin-flutter-and-migrate-to-pub-workspaces` (PR 1 of 2). PR 2, the CI repair (`ci/repair-workflows-and-unify-versions`), starts after PR 1 is merged.

**Evidence level reached: L2 (local analysis, generation, format check and tests on macOS). No L3.**

### 1.1 What changed and why

| Change | Why |
|---|---|
| `.fvmrc` pins Flutter **3.47.5**; `.gitignore` now ignores only `.fvm/` | One version for developers and CI. The old `**.fvmrc` pattern hid the file |
| Every pubspec: `sdk >=3.13.0 <4.0.0`, `flutter >=3.47.0` (was exact `3.41.6`) | The exact pin blocked `pub get` on any other Flutter. The range is a minimum; `.fvmrc` is the exact version |
| Pub workspace: `workspace:` in the root pubspec, `resolution: workspace` in the 11 members | Replaces Melos 6 plus `pubspec_overrides.yaml` |
| Melos 6.3.3 to **8.9.0**, config moved from `melos.yaml` into the root pubspec | Owner approved Melos 8 (latest; 7.x superseded). `melos.yaml`, 10 `pubspec_overrides.yaml` and the two app lockfiles deleted; one root `pubspec.lock`, seeded from the old citizen lock so only 70 packages moved |
| Melos scripts repaired | `flutter:pod:install` called scripts that did not exist; `admin:macos:pods` used the citizen scope; `backend:build` and `backend:deploy` used the wrong path; `flutter:check` mixed `run` and `exec` (invalid in Melos 8) |
| New scripts `flutter:test`, `citizen:run:development/staging/production` | Master plan expects them |
| Aggregate scripts chain with `&&` | Before, `melos run flutter:analyze` returned 0 even when a package failed |
| Golden scripts no longer pass `--update-goldens` | They overwrote baselines by default. Only `components:update:golden` updates them |
| `bin/test.sh`, using the placeholder values now in `apps/citizen/secrets/env.example.json` | Tests need compile-time environment values; placeholders are non-secret. The example file doubles as the test environment (a separate `config/test_env.json` was removed as a duplicate). `flutter test` exit code 79 ("no tests") is treated as success |
| Removed lints that no longer exist from `packages/rules` | Applied by `dart fix` on the owner's machine; analyzer no longer knows them |

**Dependency changes pulled forward from Phase 2 (owner decision, so the app compiles and tests run on Flutter 3.47.5).** Kept in their own commits so Phase 2 can review them.

| Package | Change | Reason |
|---|---|---|
| `solar_icons` | ^0.0.5 to ^0.1.0 | Flutter 3.44 made `IconData` a final class; 0.0.5 subclassed it and no longer compiles |
| `font_awesome_flutter` | ^10.4.0 to ^11.0.0 | Same reason. 11 icons are `FaIconData`, so `SecurityListTile` now uses `FaIcon` |
| `freezed` | ^3.1.0 to ^4.0.1 | Generated model code did not compile on Dart 3.13 |
| `json_serializable`, `json_annotation`, `build_runner`, `mockito` (transitive `analyzer` 10.2 to 13.3) | upgraded to the latest compatible | Needed by freezed 4 and current Dart |
| `flutter_launcher_icons` | removed from `apps/citizen` and `apps/admin` | Latest 0.14.4 (June 2025) needs `cli_util` ^0.4, Melos 8 needs `cli_util` >=0.5. A root `cli_util` override worked but hid the conflict. Now a global tool (see `AGENTS.md`). The global-tool run is untested by the agent |

Everything else stays on the locked versions; the full upgrade is Phase 2.

### 1.2 Verification (24 Sept 2026, Flutter 3.47.5, macOS)

| Command | Result |
|---|---|
| `melos bootstrap` | OK, 11 packages |
| `melos run flutter:build` | exit 0. The citizen router and locator generate (the Phase 0 `stackedRouterGenerator` crash is gone) |
| `melos run flutter:analyze` | exit 0, no issues in all apps and packages |
| `CI=true melos run flutter:format` | exit 0 |
| Tests (`components`, `constants`, `localization`, `models`, `services`, `styles`, `utils`) | pass. `citizen` and `admin` have no test cases (see 1.4) |
| App build or launch | **Not run.** Needs the secrets and Firebase files (owner supplies) |

### 1.3 Findings during Phase 1

- **Golden mismatch was not caused by Flutter 3.47.** 19 component golden cases failed with text about 17% wider. The baselines date from 2025-07-25; on 2025-08-29 `AppFilterChip` moved from `bodySmall` (12) to `bodyMedium` (14), and `BaseTextField` changed the same way. CI never ran the tests, so the baselines were stale before this refactor. They were regenerated in their own commit with `components:update:golden` (owner approved investigating first; the investigation showed intentional source changes). Two other candidate causes were checked: Flutter 3.47 draws text with SDF on macOS (affects edge pixels, not width) and Flutter 3.41 makes `FontWeight` control variable-font weight (Poppins is bundled as static files). Neither explains the width change.
- **Material and Cupertino decoupling (Flutter 3.47) is real but non-breaking now.** They are published as `material_ui` and `cupertino_ui` 1.0. The old `package:flutter/material.dart` imports still work; formal deprecation is planned for the November 2026 stable. It is not what changed the goldens. Migration belongs to a later phase (Phase 8 or its own PR).
- **Review of `return await` in `CloudinaryStorageService.uploadXFile` (owner edit).** Correct. Both `uploadFile` and `_uploadBytes` catch every exception themselves and return `null`, so awaiting them changes no behavior on those paths; it only makes the outer `catch` effective for anything else that throws in that block. It also clears the `unawaited_return_in_try_block` warning. `uploadXFile` is not called anywhere in the app (only `uploadFileWithRetry` is, from `add_report_viewmodel.dart`); a candidate for removal in Phase 8.
- **Latent question in `bootstrap.dart`.** It compares `EnvironmentConstants.environment == Environment.production.name` (`production`) while `kEnvProduction` is `Production`. Whether App Check uses the production providers depends on the exact string in `secrets/production.json`. To be checked in Phase 5 when the real secrets are available.
- **Tool side effects on `pub get`:** Flutter 3.47 adds an `analyzer.exclude` block to `analysis_options.yaml` in the apps, and regenerates `apps/admin` Linux and Windows plugin lists. Both are committed.
- **Untracked icon changes.** After the commits, launcher icon images and `apps/citizen/ios/Runner.xcodeproj/project.pbxproj` changed in the working tree without an agent command. They look like a run of the launcher-icons tool. Not committed; owner to confirm whether to keep them.

### 1.4 Test cases to add in Phase 8 (backlog)

The workspace has about 27 real test cases: 21 component goldens (10 components) plus 6 single placeholder tests (`constants`, `localization`, `models`, `services`, `styles`, `utils`). Nothing else:

- `apps/citizen`: 0 cases. 27 files under `test/viewmodels/` and 1 golden stub are empty groups with `registerServices` and `locator.reset` only. Viewmodels to cover: add_report, appearance_settings, comment_sheet, complete_profile, delete_confirmation_dialog, delete_feedback_sheet, delete_verification_sheet, force_update_dialog, forgot_password, home, language_settings, loading_dialog, login, logout_dialog, main, notification, onboarding, profile, reports, send_password_reset_email_dialog, settings, signin_security, signup, success, update_password, upload_media_dialog.
- `apps/admin`: 0 cases (home viewmodel and a golden stub).
- `packages/services` (18 test files, effectively 1 case): authentication, alert, analytics, app_update, cloudinary_storage (upload success, non-200, retry, `uploadXFile`), firebase storage, media, notification, remote config, report and user services.
- `packages/models`: JSON round trips for the freezed models (user, report, comment, notification).
- `packages/utils`, `constants`, `localization`, `styles`: real assertions instead of the placeholder.
- Integration test: launch, sign in, create a report with a mocked location, see it in the feed.
- Replace `golden_toolkit` (discontinued) and add goldens for more components.

### 1.5 Tools: what is needed and when

| Tool | State | Needed in |
|---|---|---|
| FVM 4.3.1 | Installed. Flutter 3.47.5 is downloaded (`fvm list` shows "Need setup"); the owner has not run setup yet | **Now** (Phase 1): `.fvmrc` and CI read it. Every later phase on a developer machine |
| Shorebird CLI | **Not installed**; the download did not complete | **Now**, once, to confirm 3.47.5 is supported before the pin is final (docs list 3.47.1). Later in Phase 7 for `shorebird release` base builds, and Phase 3 and 4 checks that native changes need a fresh base release |
| Firebase CLI, FlutterFire CLI | Not installed | Phase 5 (`flutterfire configure`) and Phase 6 (functions, emulator) |
| fastlane | Not installed | Phase 7 |

### 1.6 Decision log (Phase 1)

| Decision | Choice | Why |
|---|---|---|
| Flutter in Phase 1 | Stay on 3.47.5, fix what breaks now | Owner decision; rejected falling back to 3.41.6 |
| Phase 2 items done early | Only what 3.47.5 needs to compile, pass analysis and run tests (list in 1.1) | Owner decision; Phase 2 still reviews everything |
| Melos exit codes and analyzer findings | Fixed in Phase 1 | Owner decision |
| Golden baselines | Investigated first, then regenerated in a separate commit | Owner decision |
| `flutter_launcher_icons` | Global tool instead of an override | Owner asked for a real fix, not a workaround |
| Developers without FVM | Supported: install the Flutter version in `.fvmrc` by other means; pubspec minimum blocks older Flutter | Owner question |

### 1.8 PR 2: CI repair (`ci/repair-workflows-and-unify-versions`)

| Change | Why |
|---|---|
| `.github/workflows/ci` renamed to `ci.yml` and rewritten | It had no `.yml` extension and never ran. Now one job (was a citizen/admin matrix repeating workspace-wide commands): generate, format check, generated-files check, analyze, test. Runs on PRs into `develop` and `main` |
| Flutter from `.fvmrc`, Java 21 zulu, everywhere | Was Flutter 3.32.6 / 3.38.7 / pubspec 3.41.6 and Java 18 / 21 / 25 |
| Every action pinned to a full commit SHA with a version comment | GitHub's recommended way to get an immutable action. `checkout` v7.0.1, `setup-java` v6.0.1, `flutter-action` v2.23.0, `labeler` v7.0.0, `release-action` v1.21.0, `assign-author` v1.6.2, `pr-labeler-action` v5.0.0 |
| `cd.yml` runs on pushes to `develop` only; no releases from PRs; secrets via `env`, not pasted into scripts; releases use `GITHUB_TOKEN` with `contents: write` on the build jobs only | The old one built and published a release on every PR run. Store delivery stays Phase 7 |
| `open_pr.yml`: removed the job that only installed Java, uses `GITHUB_TOKEN` instead of the `TOKEN` personal token, also runs for PRs into `main`; branch labels for `docs/`, `ci/`, `test/`, `build/` | Least privilege, less noise |
| `.github/dependabot.yml` for `github-actions` (monthly, one grouped PR) | Pinned SHAs go stale without it. `pub` and `npm` entries remain Phase 7 |
| `melos run ci:check` | One command that does what CI does, to run before a PR |
| Melos activated globally in CI and CD (`melos` version taken from `pubspec.lock`) | Melos scripts call each other through the `melos` command, which `dart run melos` does not provide. Found while simulating CI locally. `README.md` and `AGENTS.md` FVM instructions corrected for the same reason |

**Verification:** `actionlint` clean. Every CI step run locally in CI mode: bootstrap, generate, format check, generated-files check (no files changed), analyze, test all exit 0; `melos run ci:check` exits 0. **Live CI (24 Sept 2026, Ubuntu, Flutter 3.47.5 from `.fvmrc`, Java 21): green after one fix.** The first live run failed the generated-files check because `flutter pub get` writes `apps/admin/macos/Flutter/GeneratedPluginRegistrant.swift` differently on Linux; OS-dependent plugin registrants are now excluded from that check. Labeling workflow green. GitHub Actions was disabled for the repository (`actions/permissions` `enabled: false`), which is why PRs #37 to #39 had no runs; it is enabled when this PR is ready.

**Done with this PR:** GitHub Actions enabled (`enabled: true`, default token read-only); branch protection on `develop` requires the check `Format, analyze and test` (admins can bypass, force pushes and deletion blocked, no review requirement).

**Review decisions on PR #40 (CodeRabbit):**
- Accepted and fixed: document the PATH step for a globally activated Melos; `melos run ci:check` runs the same generated-files check as CI (`bin/check_generated.sh`).
- **Deferred to Phase 7:** the iOS and Android jobs in `cd.yml` both upload to the same release tag with `allowUpdates: true`, so they can race when creating the release. Fix in Phase 7 with the rest of CD: one `release` job with `needs: [build-ios, build-android]` that downloads both build artifacts and publishes once (or use one tag per platform). Serializing both build jobs, as suggested, would double the CD time.
- **Declined:** adding `edited` to the `ci.yml` pull request trigger. It also fires on title and description edits, which with cancel-in-progress would cancel running CI for a rare benefit (a retargeted PR). Push a commit or re-run the check instead.
- **Follow-up PR** (`ci/label-pull-requests-from-forks`): switch `open_pr.yml` to `pull_request_target` so PRs from forks and Dependabot can be labeled. Nothing is checked out and no PR text reaches a script, which keeps it safe.

**Follow-up PR `ci/label-pull-requests-from-forks`:** `open_pr.yml` now uses `pull_request_target` so fork and Dependabot PRs get labels and an assignee. Found while doing it: `TimonVS/pr-labeler-action` reads its config by the PR's head branch name from the base repo, so it cannot label fork PRs. It and `technote-space/assign-author` (both last updated in 2024) were replaced by `actions/labeler` (branch rules via `head-branch`, merged into `.github/labeler.yml`) and one `gh pr edit` call, leaving no third-party action in a workflow that has a write token. Bots are not assigned; assignment failures for non-collaborators are a warning. Fixed the `style` label glob (`packages/styles`). `pull_request_target` runs from the default branch (`develop`), also for PRs into `main`, so this can only be verified live after merge, on the next pull request.

**CD paused (owner decision, option B), found on the first push to `develop` after PR #40.** Both `cd.yml` builds failed on Flutter 3.47.5, for reasons already on the plan:
- Android: `Your project's Gradle version (8.13.0) is lower than Flutter's minimum supported version of 8.14.0`. Phase 4 must raise the Gradle wrapper to at least 8.14 (Shorebird's notes for 3.47.x also list AGP 8.11.1 and Kotlin 2.2.20).
- iOS: Swift Package Manager cannot resolve `firebase_remote_config 6.2.0` (needs FlutterFire package 4.5.0) together with `firebase_storage 13.0.6` (needs 4.4.0). The Firebase packages are at mismatched versions (storage 13.0.6, auth 6.1.4, remote config 6.2.0, and so on). Phase 2 Group C must upgrade the whole FlutterFire suite as one compatible set.
`cd.yml` now runs only by hand (`workflow_dispatch`); Phase 7 restores the push trigger, fixes the release race and adds store delivery. This is the first real evidence that the app does not build on 3.47.5 yet, so the Phase 0 unknown "does it build" is answered: not until Phases 2 and 4.

**Runner pin:** GitHub announced `ubuntu-latest` moves to Ubuntu 26 from 19 October 2026, so all workflows now use `ubuntu-24.04` (and the existing `macos-15`). Moving to a newer image is a deliberate change, tested in its own PR.

**Open after this PR:** goldens are not asserted in CI (Ubuntu) until Phase 2; repository secrets `TOKEN` and `CITIZEN_*_SECRETS` are now unused and can be deleted by the owner; Dependabot `pub` and `npm` entries (Phase 7; Dependabot's docs do not mention pub workspaces, so test before relying on it).

### 1.7 Still open

- Shorebird CLI install and a check that 3.47.5 is supported.
- FVM setup on the owner machine (`fvm install` in the repo).
- Confirm or discard the untracked launcher icon and `project.pbxproj` changes.
- PR 2: CI repair.

---

## Phase 0: Baseline and audit (24 Sept 2026)

No product code changed. Branch `docs/add-refactor-plan-and-baseline-audit` adds only `AGENTS.md`, `CLAUDE.md`, `docs/*` and this file. All experiments ran in a throwaway copy of the repo outside the working tree.

**Evidence level reached: L1 (partial L2 for packages that need no credentials). No L3.**

### 0.1 Local toolchain (this machine)

| Tool | Version | Notes |
|---|---|---|
| Flutter | 3.47.5 stable (rev 6a19cca564, 2026-09-17) | Installed at `~/develop/flutter`, **not** pinned by FVM |
| Dart | 3.13.4 | DevTools 2.60.0 |
| FVM | 4.3.1 | Installed in Phase 0 via Homebrew. `fvm install 3.47.5` and `3.41.6` started but the SDK clone had not finished when this was written (see 0.9) |
| Melos (global) | 8.9.0 | Installed in Phase 0. Repo pins **6.3.3** in the root pubspec. Global Melos 8 cannot run inside the repo yet (pub workspaces are required) |
| Java | Temurin 21.0.6 | |
| Xcode | 26.6 (17F113) | iOS simulators: iOS 26.5 (iPhone 17 family, iPads) |
| CocoaPods | 1.17.0 | Warns about non-UTF-8 terminal locale |
| Android SDK | present; NDK 28.2.13676358; emulator, cmdline-tools, build-tools installed | `ANDROID_HOME` not exported in the shell |
| Node / npm | 24.13.0 / 11.6.2 | Matches `backend/functions` engine `24` |
| Homebrew | 7.0.6 | |
| gh | authenticated as `calebjesusegun` | `develop` has **no branch protection**. Squash and merge commits both allowed. Repo is public |
| Firebase CLI, FlutterFire CLI, Shorebird CLI, fastlane | **not installed** | Needed later, not in Phase 0 |

**Repo-declared versions:** root and every member pubspec pin `flutter: 3.41.6`, `sdk: >=3.10.7 <4.0.0`. Melos 6.3.3. Stacked 3.5.0, `stacked_generator` ^2.0.0 (locks 2.0.2), `stacked_services` 1.6.0. Firebase: `firebase_core` ^4.4.0, `firebase_auth` ^6.1.4, `cloud_firestore` ^6.1.2, `firebase_messaging` ^16.1.1, `firebase_analytics` ^12.1.1, `firebase_crashlytics` ^5.0.7, `firebase_storage` ^13.0.6, `firebase_remote_config` ^6.2.0, `firebase_performance` ^0.11.1+4, `firebase_app_check` ^0.4.3. `google_sign_in` ^7.1.1, `sign_in_with_apple` ^7.0.1.

**Android (as committed):** AGP 8.11.0, Gradle 8.13, Kotlin plugin 2.2.20, `google-services` 4.4.0, Crashlytics plugin 2.9.8, Performance plugin 1.4.2 (declared, **not applied**), `compileSdk`/`targetSdk` 36, NDK 28.2.13676358, Java 17 source/target, Groovy DSL, Firebase BOM 34.11.0 as plain `implementation`, `kotlin-stdlib-jdk7:1.9.20`.

**Latest stable facts (checked 24 Sept 2026):** Flutter stable is **3.47.5** (Dart 3.13.4, released 2026-09-18). The master plan's "3.44.x" is out of date. Shorebird docs list 3.47.1 as its latest recommended version. Support for 3.47.5 specifically is **unverified** (needs the Shorebird CLI). Melos latest is **8.9.0**, not 7.x; 8 requires Dart >= 3.9 and pub workspaces.

### 0.2 Baseline build of `develop`

Built exactly as committed, with the latest Flutter (3.47.5), as agreed. Secrets, Firebase files and keystore are absent, so no app build could be attempted.

| Step | Result |
|---|---|
| `flutter pub get` on the committed pubspecs | **Fails.** `civic24 requires Flutter SDK version 3.41.6`, current is 3.47.5. The exact pin blocks every newer Flutter |
| Same, after loosening the pin in a scratch copy only (`>=3.41.6`) | `pub get` succeeds in all 11 members |
| Code generation, scratch copy | `intl_utils`, `assets`, `models`, `services`, `admin`: OK. **`apps/citizen`: `stackedRouterGenerator` crashes** with `Exception: Missing implementation of visitDotShorthandPropertyAccess`. Locked `analyzer` 7.7.1 (language version 3.9) cannot read Dart 3.10+ syntax. `app.locator.dart` and `app.router.dart` are therefore not generated |
| `flutter analyze`, scratch copy | `rules`, `localization`, `constants`, `assets`, `styles`, `models`, `components`, `admin`: 0 issues. `utils`: 1 info (`LocalPlatform` deprecated). `services`: 2 warnings (`unawaited_return_in_try_block`, `cloudinary_storage_service.dart:124,130`). **`citizen`: 350 errors**, all downstream of the missing generated locator and router |
| Tests, scratch copy | Pass: `utils`, `localization`, `constants`, `styles`, `models`. **Fail:** `services` (17 files fail to load), `components` (10), `citizen` (28 plus golden), `admin` (`setupLocator` needs `stackedRouter`) |
| Why `services` and `components` tests fail | `packages/constants/lib/src/environment_constants.dart` evaluates `String.fromEnvironment(...)` with compile-time assertions. Tests only load when the compile-time values are supplied, either with `--dart-define-from-file` or with repeated `--dart-define=KEY=value` options. **Tests need environment values, so CI must provide non-secret placeholder values (by either method) before it can run them** |
| `flutter pub upgrade --major-versions --dry-run` on citizen | Resolves cleanly. `analyzer` 14.4.0, `build_runner` 2.16.1, `build` 4.0.11. So the generator failure is fixable by Phase 2 dependency upgrades. **Not yet proven** that `stacked_generator` 2.0.4 generates the router on that set |
| Observed Flutter 3.47 tool side effect | `flutter pub get` rewrote `analysis_options.yaml` in some members ("Upgrading analysis_options.yaml to exclude build and platform directories"). Expect these diffs in Phase 1 or 2 |

### 0.3 `flutter pub outdated`

Full output for all 11 members (latest Flutter, committed lockfiles): kept outside the repo in the scratch directory and available on request. Summary of **direct and dev** dependencies behind latest (36 of them). Columns: locked in the scratch resolve, resolvable under current constraints, latest.

| Package | Locked | Resolvable | Latest | Members |
|---|---|---|---|---|
| firebase_core | 4.6.0 | 4.15.0 | 4.15.0 | admin, citizen |
| firebase_auth | 6.3.0 | 6.7.0 | 6.7.0 | admin, citizen |
| cloud_firestore | 6.2.0 | 6.10.0 | 6.10.0 | admin, citizen |
| firebase_messaging | 16.1.3 | 16.7.0 | 16.7.0 | admin, citizen |
| firebase_analytics | 12.2.0 | 12.6.0 | 12.6.0 | admin, citizen |
| firebase_crashlytics | 5.1.0 | 5.4.0 | 5.4.0 | admin, citizen |
| firebase_storage | 13.2.0 | 13.6.0 | 13.6.0 | admin, citizen |
| firebase_performance | 0.11.2 | 0.11.6 | 0.11.6 | admin, citizen |
| firebase_app_check | 0.4.2 | 0.4.8 | 0.4.8 | admin, citizen |
| build_runner | 2.13.1 | 2.16.1 | 2.16.1 | admin, citizen, models |
| freezed | 3.2.5 | 4.0.2 | 4.0.2 (needs Dart >= 3.13) | models |
| stacked_generator | 2.0.2 | 2.0.4 | 2.0.4 | admin, citizen |
| mockito | 5.6.4 | 5.8.1 | 5.8.1 | admin, citizen |
| flutter_gen_runner | 5.13.0+1 | 5.15.0 | 5.15.0 | admin, citizen |
| flutter_native_splash | 2.4.7 | 2.4.8 | 2.4.8 | admin, citizen |
| sign_in_with_apple | 7.0.1 | 8.2.0 | 8.2.0 | services |
| permission_handler | 11.4.0 | 13.0.2 | 13.0.2 | services |
| geocoding | 4.0.0 | 5.0.0 | 5.0.0 | services |
| geolocator | 14.0.2 | 14.0.3 | 14.0.3 | services |
| image_cropper | 11.0.0 | 12.2.1 | 12.2.1 | services |
| flutter_local_notifications | 19.5.0 | 20.1.0 | 22.3.1 | services |
| package_info_plus | 9.0.1 | 10.2.1 | 10.2.1 | services |
| internet_connection_checker_plus | 2.9.1+2 | 3.1.2 | 3.1.2 | services |
| app_settings | 7.0.0 | 9.0.0 | 9.0.0 | services |
| flutter_timezone | 4.1.1 | 5.1.0 | 5.1.0 | utils |
| timezone | 0.10.1 | 0.11.1 | 0.11.1 | utils |
| flex_color_scheme | 8.4.0 | 9.0.0 | 9.0.0 | styles |
| cached_network_image | 3.4.1 | 4.0.2 | 4.0.2 | components |
| dotted_border | 2.1.0 | 3.1.0 | 3.1.0 | components |
| font_awesome_flutter | 10.12.0 | 11.0.0 | 11.0.0 | components |
| shimmer | 2.0.0 | 4.0.0 | 4.0.0 | components |
| smooth_page_indicator | 1.2.1 | 3.0.0 | 3.0.0 | components |
| country_flags | 3.3.0 | 4.1.2 | 4.1.2 | citizen |
| lottie | 3.3.1 | 3.6.1 | 3.6.1 | citizen |
| uuid | 4.5.3 | 4.6.0 | 4.6.0 | citizen |
| solar_icons | 0.0.5 | 0.0.5 | 0.1.0 | admin, citizen, components, models |

Discontinued: transitive `build_resolvers` and `build_runner_core` (fixed by newer `build_runner`). Direct discontinued: `golden_toolkit` 0.15.0 (last published 2023-02-21; pub.dev marks it discontinued, no replacement named; `alchemist` 0.14.0 from 2026-03-13 is a candidate). Used in `components`, `citizen` and `admin` dev dependencies. `stacked_services` 1.6.0 (Nov 2024) and `stacked` 3.5.0 (Aug 2025) are stale and are a long-term risk; `stacked_generator` still gets releases (2.0.4, June 2026).

### 0.4 Swift Package Manager readiness (iOS/Darwin plugins in citizen)

Method: inspected each plugin at its locked version for a `Package.swift`, then checked the latest release of every plugin that lacked one.

**SPM ready at the locked version (24):** app_settings, cloud_firestore, connectivity_plus, firebase_analytics, firebase_app_check, firebase_auth, firebase_core, firebase_crashlytics, firebase_messaging, firebase_performance, firebase_remote_config, firebase_storage, flutter_local_notifications, flutter_native_splash, flutter_timezone, geocoding_ios, geolocator_apple, google_sign_in_ios, image_cropper, image_picker_ios, package_info_plus, path_provider_foundation, sqflite_darwin, url_launcher_ios.

**CocoaPods only at the locked version, SPM ready at latest (3):**

| Plugin (iOS impl) | Locked | Latest | Package.swift in latest |
|---|---|---|---|
| permission_handler_apple | 9.4.7 | 9.6.1 | yes |
| sign_in_with_apple | 7.0.1 | 8.2.0 | yes |
| flutter_image_compress_common | 1.0.6 | 1.1.1 | yes |

Upgrading these three in Phase 2 is a prerequisite for removing CocoaPods in Phase 3. `_web` variants (`cloud_firestore_web`, `firebase_messaging_web`, `firebase_storage_web`) appeared in the scan but have no iOS code and are irrelevant. Plugins without native iOS code (`hive_ce`, `shorebird_code_push`, `rxdart`, etc.) are not listed. Shorebird's Dart package needs no SPM work, but the CLI must support the chosen Flutter.

**Caveat:** presence of `Package.swift` was verified from the package archives. Whether each plugin builds and links correctly under SPM with Flutter 3.47 is **unverified** until Phase 3.

### 0.5 Features, platforms, and test coverage

| Area | Facts |
|---|---|
| Citizen app | 81 lib files, 28 test files (27 viewmodel tests plus 1 golden). Views: startup, onboarding, auth, complete_profile, home, main, reports, add_report, notification, settings. Also contains `macos`, `web`, `windows`, `linux` platform folders that are not part of the release plan |
| Admin app | 10 lib files, 2 tests (viewmodel and golden). Stub. Not touched |
| Packages | `services` 39 lib / 18 tests, `components` 38 / 10 (goldens via `golden_toolkit`), `models` 39 / 1, `constants` 14 / 1, `localization` 13 / 1, `utils` 8 / 1, `styles` 11 / 1, `assets` 3 / 0, `rules` config only. Several package tests are single placeholder tests (`<pkg>_test.dart`). `packages/services/lib/services_test.dart` is a test-named file inside `lib/` |
| No integration tests | None exist |
| Entry point | Only `apps/citizen/lib/main.dart`. README references to `lib/main_development.dart` are stale |
| Flavors | `development`, `staging`, `production`. Android ids `co.civic24.citizen[.dev/.stg]`. iOS ids `co.civic24.citizen[.dev/.stg]`, schemes `development/staging/production`. iOS has a Run Script that copies `ios/config/<flavor>/GoogleService-Info.plist` |
| Shorebird | `apps/citizen/shorebird.yaml` with three flavor app IDs. IDs are not secret |

### 0.6 CI and Melos behaviour (current)

- `.github/workflows/ci` has no `.yml` extension and **never runs**. It also only triggers on PRs to `develop`, runs `melos` commands once per matrix entry (citizen and admin) although they are workspace-wide, uses Flutter 3.32.6, Java 18, `actions/checkout@v3`, `setup-java@v3`, and ends with `git diff --exit-code` inside the app dir.
- `cd.yml` is the only workflow that runs. Runs on push **and** on PR to `develop`. Flutter 3.38.7, Java 25 on iOS and 21 on Android, iOS job builds `--no-codesign` but uses `flutter build ipa`. Development flavor only. It runs analyze but **no tests and no format check**. It uploads a GitHub release on every run, including PR runs. It reads secret `ENCODED_DEVELOPMENT_JSON_CITIZEN`, but `.github/workflows/README.md` documents `CITIZEN_DEV_SECRETS` and mentions a `test` job that does not exist.
- `open_pr.yml` labels PRs and sets the author. Java 18. Uses `TOKEN` secret.
- No workflow runs golden or unit tests. Tests also cannot run without `--dart-define-from-file` values (0.2).
- `.github/CODEOWNERS`: everything owned by `@calebjesusegun`. A PR template exists and asks for `<type>/<summary>` titles.
- Melos scripts that are broken or missing (file `melos.yaml`):
  - `flutter:pod:install` calls `melos run flutter:ios:pods` and `flutter:macos:pods`, which do not exist (the scripts are named `ios:pods` and `macos:pods`).
  - `admin:macos:pods` uses `--scope="citizen"`.
  - `backend:build` and `backend:deploy` run `npm --prefix functions` from the repo root, but the folder is `backend/functions`.
  - No `flutter:test`, and no `citizen:run:*` scripts exist, although the master plan expects them to be kept. Existing test scripts are `citizen:test`, `<pkg>:test`.
  - `test:golden` and `citizen:golden` and `admin:golden` use `--update-goldens` and overwrite baselines.
  - `flutter:check` starts with `melos clean` and `melos bootstrap` and works only with the current Melos 6.
- `pubspec_overrides.yaml` is **committed** in 10 members (Melos 6 output), and root `pubspec.yaml` holds a commented-out workspace attempt with Melos 7.3.0.
- `.gitignore` contains `**.fvm/` and `**.fvmrc`. **`.fvmrc` is ignored**, which conflicts with the plan to commit it in Phase 1.

### 0.7 Files that block a reproducible build (all gitignored, must be supplied by the owner)

- `apps/citizen/secrets/{development,staging,production}.json` (keys listed in `secrets/env.example.json`, 23 keys including `WEB_CLIENT_ID`, `CLOUDINARY_*`)
- `apps/citizen/android/app/src/{development,staging,production}/google-services.json`
- `apps/citizen/ios/config/{development,staging,production}/GoogleService-Info.plist`
- `apps/citizen/ios/Flutter/{Debug,Staging,Release}.xcconfig` (templates exist as `*.xcconfig.template`)
- `apps/citizen/android/key.properties` and the upload keystore
- `apps/citizen/lib/firebase_options.dart` (named in `firebase.json`) does not exist. That is expected: `DefaultFirebaseOptions` comes from `lib/app/firebase_config.dart`, which builds the options from dart-defines

The owner will add these manually when a step needs them. The first step that needs them is a build or test run of the app itself, which is Phase 1 verification.

### 0.8 Docs vs reality

| Claim | Reality |
|---|---|
| README: Supabase for database, auth, storage, and "Supabase CLI" prerequisite | No Supabase code or dependency anywhere. Firebase plus Cloudinary |
| README: Google Generative AI validates posts and images | No Gemini or AI code anywhere in the repo |
| `apps/citizen/README.md`: run `lib/main_development.dart` | Only `lib/main.dart` exists |
| `.github/workflows/README.md`: `test` job, secrets `CITIZEN_*_SECRETS`, three-flavor builds | Not present in `cd.yml` |
| `AGENTS.md` §6.3 (as first written): keep ProGuard rules for Freezed models | Contradicts the decided rule. Freezed is Dart. Corrected in this branch |

### 0.9 Open toolchain item

`fvm install 3.47.5` and `fvm install 3.41.6` were started in the background. At the time of writing FVM was still creating its local Flutter git cache (`~/fvm`, ~46 MB, no SDK yet). The system Flutter at `~/develop/flutter` is already 3.47.5, so all Phase 0 checks used that. If the FVM install does not finish, run `fvm install 3.47.5` and `fvm install 3.41.6` again from a terminal on a stable connection.

### 0.10 Native and backend findings (read from files, not built)

**iOS (`apps/citizen/ios`)**
- Podfile: `platform :ios, '15.0'` but `post_install` sets `IPHONEOS_DEPLOYMENT_TARGET = 13.0` for every pod and `GCC_WARN_INHIBIT_ALL_WARNINGS = YES`. `Runner.xcodeproj` also sets `IPHONEOS_DEPLOYMENT_TARGET = 13.0` in one build configuration. Three values (15.0, 13.0, other) in play.
- Podfile permission macros: `PERMISSION_LOCATION=1` and `PERMISSION_LOCATION_WHENINUSE=0` (this compiles in the "always" permission code).
- `Info.plist`: `UIBackgroundModes` includes `location`; `NSLocationAlwaysUsageDescription` and `NSLocationAlwaysAndWhenInUseUsageDescription` present; `NSLocationWhenInUseUsageDescription` is "Enable your location to complete your profile while using Civic24." (not accurate about reports); `NSLocalNetworkUsageDescription` says "for debugging and development" and ships in release; `ITSAppUsesNonExemptEncryption` is the **string** `NO` (should be boolean false).
- **No `PrivacyInfo.xcprivacy`** in `Runner/`. **No `*.entitlements` file** in the repo: Push Notifications and Sign in with Apple capabilities cannot be confirmed from the repo. Needs a look in Xcode.
- Crashlytics Run Script already contains a fallback to `SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run` (derived from `DerivedData`), but the primary branch still keys off `$PODS_ROOT/FirebaseCrashlytics`. Not tested.
- Flavor plist copy script exists and errors if the plist is missing, and defaults an unknown flavor to `development`.
- No `fastlane` folder in `ios/`. `apps/citizen/android/fastlane/` has `Appfile`, `Pluginfile`, `README.md`, `report.xml`, but **no `Fastfile`** (the README describes Firebase App Distribution lanes for the three flavors that do not exist in the repo).

**Android (`apps/citizen/android`)**
- `minifyEnabled true` with `proguard-android.txt` and **no `proguard-rules.pro` file**. Not `proguard-android-optimize.txt`, and `shrinkResources` is off.
- `firebase-bom` added as plain `implementation`, `kotlin-stdlib-jdk7:1.9.20` next to Kotlin 2.2.20, Performance Gradle plugin declared and not applied, `google-services` 4.4.0, Crashlytics plugin 2.9.8, Groovy DSL, `android.enableJetifier=true`.
- `AndroidManifest.xml`: `android:usesCleartextTraffic="true"` in the **main** manifest (all flavors, including production). Location permissions are commented out (the plugin's own manifest may supply them; **unverified**). `POST_NOTIFICATIONS` present.
- The `signingConfigs.release` block reads `key.properties`; a release build without the file fails.
- Every flavor uses `applicationIdSuffix`. Development and staging inherit main's label placeholder "Civic24" (same app name on device for all flavors).

**Firebase and App Check**
- `apps/citizen/firebase.json` and `backend/.firebaserc` reference only `civic24-sdg11`. Owner confirmed: production = `civic24-sdg11` (ID `civic24-sdg11`); development and staging = `civic24test` (ID `civic24test-f9352`). Three environments, two Firebase projects. Whether development and staging are separate apps inside `civic24test-f9352` (they need separate Android/iOS apps per flavor id) is to be confirmed in Phase 5.
- `bootstrap.dart` (`connectToFirebase`) activates App Check with `AndroidPlayIntegrityProvider` and `AppleDeviceCheckProvider` when `environment == production`, and the debug providers otherwise. iOS production uses DeviceCheck, not App Attest (the master plan's Phase 5 asks to prepare App Attest with DeviceCheck fallback).

**Firestore rules and backend**
- `firestore.rules` covers `users` (owner or admin reads only), `users/*/notifications`, `users/*/interactions`, and `reports`. Everything else is denied by default. Gaps:
  - No rule for `uploads` (`FirestoreCollections.uploads` exists in Dart).
  - No rule for comments or any report subcollection. Reports can only be updated by the report owner, so other users' likes and comments (counters or arrays on the report) would be rejected. What the app actually writes is a Phase 6 question. `CommentSheetModel` exists in the app.
  - `users` cannot be read by other users. This will block profile views for "block user" (Phase 7).
  - Users can never be deleted from the client (`allow delete: if false`). Whether "Delete Account" (`ProfileViewModel.deleteAccount`) deletes through a Cloud Function is unverified.
  - The report `update` rule does not stop the owner rewriting `reportData.userId`.
  - **Role self-promotion (found in PR review, verified against the rules text and `user_account.dart`; not tested against a live project):**
    - `users/{userId}` `create` only checks `isOwner(userId)` and puts no limit on `account.userType`. A signed-in user creating their own document can set `account.userType` to `admin`, and `isAdmin()` then lets them read every user document.
    - `isNotChangingUserType()` diffs the top-level map and tests `affectedKeys().hasAny(['account.userType'])`. `affectedKeys()` returns top-level keys, so `account.userType` never matches. Changing the nested role changes the top-level key `account` and is not blocked, so an owner can also promote themselves on update.
    - Fix direction: make the role server-controlled on create and update (force `citizen` on create, compare `account.userType` on the nested map on update, or set roles only via a Cloud Function or custom claim). Proposed to the owner in Phase 6 and, because it is a security defect in production rules, raised for an earlier decision. Nothing is deployed without authorization.
- `backend/functions`: `index.ts` (9 lines) and `notification.ts` (215 lines). ESLint 8 with the legacy `--ext` flag and `eslint-config-google`. `firebase-functions` ^7.2.5, `firebase-admin` ^13.8.0, TypeScript ~5.7, Node engine 24. Not built or run in Phase 0.

### 0.11 Baseline and risk report

**Confirmed defects (evidence in the repo or in a run)**

| # | Defect | Severity | Evidence |
|---|---|---|---|
| D1 | Exact Flutter pin `3.41.6` blocks `pub get` on any other Flutter | High | 0.2 |
| D2 | Router and locator generation breaks on current Dart because `analyzer` is locked at 7.7.1 | High | 0.2 |
| D3 | `ci` has no `.yml`, never runs. The workflow that does run (`cd.yml`) has no tests or format check and publishes a release on PRs | High | 0.6 |
| D4 | Three Flutter versions, three Java versions across workflows | Medium | 0.6 |
| D5 | Tests cannot run without compile-time environment values (`--dart-define-from-file` or `--dart-define`) | High | 0.2 |
| D6 | iOS: background `location` mode, "always" permission strings, `PERMISSION_LOCATION=1`, no privacy manifest: App Review rejection risks (Guideline 2.5.4, privacy manifest) | High for store release | 0.10 |
| D7 | iOS deployment target inconsistent (15.0 / 13.0) and warnings silenced | Medium | 0.10 |
| D8 | `minifyEnabled true` with no `proguard-rules.pro`, no `shrinkResources`, `proguard-android.txt` | Medium, needs a release build to know if it crashes | 0.10 |
| D9 | `usesCleartextTraffic="true"` shipped in production manifest | Medium | 0.10 |
| D10 | Firestore rules missing `uploads`, comments and subcollections | High if features rely on them | 0.10 |
| D16 | Firestore rules allow role self-promotion to `admin` on user create and update (CWE-863) | **High (security)**, prioritize in Phase 6 or sooner | 0.10 |
| D11 | Melos scripts that reference nonexistent scripts or wrong paths; `--update-goldens` in three scripts | Medium | 0.6 |
| D12 | README describes Supabase and Gemini validation that do not exist | Low for build, medium for trust | 0.8 |
| D13 | `.gitignore` ignores `.fvmrc` | Low, blocks Phase 1 | 0.6 |
| D14 | Android fastlane has no `Fastfile`; iOS has no fastlane | Medium for Phase 7 | 0.10 |
| D15 | `sign_in_with_apple`, `permission_handler_apple`, `flutter_image_compress_common` lack SPM at locked versions | Medium (blocks Phase 3) | 0.4 |

**Recommendations (not defects)**
- Pin the newest Flutter that Shorebird supports (3.47.x). Check 3.47.5 with the Shorebird CLI.
- Use Melos 8.x (the master plan says 7.x, which is superseded).
- Have CI supply non-secret placeholder dart-defines (a file or repeated `--dart-define` options) so tests can run.
- Split `melos` scripts from `flutter:*` naming as-is, but repair the broken ones in Phase 1.

**Unknowns (need owner access, a device or a build)**
- Firebase project status (inactivity notice), which project serves development and staging.
- Whether release builds crash under R8 minification.
- Push and Sign in with Apple entitlements, APNs setup.
- Whether Shorebird supports Flutter 3.47.5.
- Whether the Phase 2 upgrade set generates `app.router.dart` with `stacked_generator` 2.0.4.
- Whether "Delete Account" removes data server-side, and what the app writes for comments and likes.
- Production usage numbers (Analytics, Crashlytics, Play Console).

### 0.12 Prioritized work plan

| Order | Work | Depends on | Effort | Needs from owner |
|---|---|---|---|---|
| 1 | **Phase 1** pin Flutter with FVM (`.fvmrc`, un-ignore it), pub workspaces plus Melos 8.x, repair Melos scripts, rename and fix CI, one Java version, add placeholder test env | Phase 0 merged | 1 day | Confirm Melos 8 instead of 7, confirm Flutter 3.47.x |
| 2 | **Phase 2** dependency upgrade in groups A to D, Stacked regeneration, replace `golden_toolkit`, fix deprecations | 1 | 2 to 3 days | Secrets file for test/build runs |
| 3 | **Phase 3** iOS SPM migration, deployment target, Info.plist, privacy manifest, Crashlytics script | 2 (three plugins must be upgraded first) | 1 to 2 days | Apple Developer access, Xcode signing, plists/xcconfigs |
| 4 | **Phase 4** Android Kotlin DSL, AGP and Gradle, BOM, ProGuard file, 16 KB check, cleartext | 2 | 1 day | Keystore and `key.properties`, `google-services.json` |
| 5 | **Phase 5** Firebase, auth, flavor matrix | 3, 4, console check | 2 to 3 days | Firebase active, console access, SHA fingerprints (including Play signing), test accounts, devices |
| 6 | **Phase 6** functions and Firestore rules | 5 | 1 to 2 days | Rule change approval, deploy approval |
| 7 | **Phase 7** CI/CD, store compliance features, fastlane, release | 6 | 4 to 5 days | Apple, Play, APNs, reviewer account |
| 8 | **Phase 8, 9** architecture, quality, features | 7 | ongoing | Proposals approved one by one |

### 0.13 Owner requests

1. ~~Confirm Melos 8.x and Flutter 3.47.x as the pin.~~ Confirmed by the owner (24 Sept 2026).
2. Log in to the Firebase console and clear the inactivity notice. **Still pending** (owner). Project IDs are recorded in 0.10.
3. For Phase 1 verification (build and test runs): the three `secrets/*.json` files. Placeholders are enough for tests. Real ones are needed to launch the app.
4. Later: the three `google-services.json` and `GoogleService-Info.plist` files, xcconfigs, keystore and `key.properties`, Play App Signing SHA-1/SHA-256, Apple Developer and App Store Connect access, APNs key, test accounts, reviewer account.
5. Install FVM SDKs if the background install did not finish (0.9). Install the Firebase CLI, FlutterFire CLI, Shorebird CLI and fastlane when their phases start.

### 0.14 Decision log

| Decision | Choice | Why |
|---|---|---|
| Flutter version for the baseline | Latest stable (3.47.5), not 3.41.6 | Owner instruction. The existing 3.41.6 pin is treated as a defect |
| Flutter version for the repo | 3.47.x (exact version fixed in Phase 1) | Owner approved. Needs a Shorebird CLI check of 3.47.5. `.fvmrc` holds the exact version, pubspecs get a minimum range |
| Baseline method | Scratch copy outside the repo with the Flutter pin loosened | Phase 0 forbids code changes and the exact pin blocks any newer Flutter |
| Melos version | 8.x (8.9.0) | Owner approved. Latest on pub.dev, same workspace model as 7. The master plan was updated from 7 to 8 |
| Branch and commit names | `type/kebab-description`, Conventional Commits with optional scope | Owner instruction |
| ProGuard | No Gson or Freezed keep rules. Add only for a real crash | Decided by owner. `AGENTS.md` §6.3 corrected |
| Java | AGP minimum (17) or 21, zulu, one version everywhere. Decided in Phase 1 | Decided by owner |
| Firebase projects | Production `civic24-sdg11`; development and staging share `civic24test-f9352` | Owner decision. Staging is barely used. Revisit before the first App Store release (0.15) |
| Committing Firebase project IDs | Allowed | Firebase documents project IDs and app config as public. Protection comes from security rules and App Check |
| Commit trailer | Keep `Co-Authored-By: Claude` on commits and PR descriptions | Owner decision. Commits made so far keep the trailer, except `48b7333` |
| PR opened as draft, then marked ready | Followed the PR template's draft rule, owner then marked it ready | Owner preference for future PRs still to be confirmed |
| Firestore role self-promotion (D16) | Recorded now, reviewed and fixed in Phase 6 | Owner decision. No rule change or deploy before that |
| Plan alignment | Added a "Phase 0 audit updates" section to the master plan, marked V2 as reference only and superseded where it conflicts | Keeps the plans consistent with the audit. V2's Java 17 and Gson items are covered by the note, not rewritten |
| Dependabot | Add in Phase 7 for pub, npm and GitHub Actions, monthly, Firebase packages grouped | Owner approved |
| PR #37 review comments | All six valid and fixed (EULA bullet split, BOM placeholder, CI test values method-agnostic, D16 added, Flutter 3.47 in the plans, Gemini model rule in V2) | Reviewer was CodeRabbit (bot). Each finding verified against the repo before changing |

### 0.15 Still open

- Revisit before the first App Store release: development and staging currently share one Firebase project (`civic24test-f9352`), so their Firestore data, Auth users and rules deploys are shared. Consider a separate staging project once staging is used for release-candidate testing.
- Phase 7: add Dependabot (pub, npm, GitHub Actions; monthly; Firebase packages grouped).
- Firebase inactivity notice (owner). Project layout is settled (see 0.14).
- FVM SDK installs (0.9).
- Everything in 0.11 "Unknowns".
