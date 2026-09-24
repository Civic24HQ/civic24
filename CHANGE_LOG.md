# Civic24 Refactor Change Log

Running log for the refactor described in `docs/CIVIC24_REFACTOR_PROMPT.md` (master plan). Newest phase first within each section. Evidence levels follow `AGENTS.md` §7.1: **L1** static analysis, **L2** local build and tests, **L3** live cloud or device.

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
| Why `services` and `components` tests fail | `packages/constants/lib/src/environment_constants.dart` evaluates `String.fromEnvironment(...)` with compile-time assertions. Tests only load with `--dart-define-from-file`. **Tests need environment values, so CI cannot run them without a file of (non-secret) placeholder values** |
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
- `apps/citizen/firebase.json` and `backend/.firebaserc` reference only `civic24-sdg11`. Owner confirmed: `civic24-sdg11` is **production**; a second project serves development and staging (name not yet given). Stated as "three environments, two Firebase projects" unless the owner corrects this.
- `bootstrap.dart` (`connectToFirebase`) activates App Check with `AndroidPlayIntegrityProvider` and `AppleDeviceCheckProvider` when `environment == production`, and the debug providers otherwise. iOS production uses DeviceCheck, not App Attest (the master plan's Phase 5 asks to prepare App Attest with DeviceCheck fallback).

**Firestore rules and backend**
- `firestore.rules` covers `users` (owner or admin reads only), `users/*/notifications`, `users/*/interactions`, and `reports`. Everything else is denied by default. Gaps:
  - No rule for `uploads` (`FirestoreCollections.uploads` exists in Dart).
  - No rule for comments or any report subcollection. Reports can only be updated by the report owner, so other users' likes and comments (counters or arrays on the report) would be rejected. What the app actually writes is a Phase 6 question. `CommentSheetModel` exists in the app.
  - `users` cannot be read by other users. This will block profile views for "block user" (Phase 7).
  - Users can never be deleted from the client (`allow delete: if false`). Whether "Delete Account" (`ProfileViewModel.deleteAccount`) deletes through a Cloud Function is unverified.
  - The report `update` rule does not stop the owner rewriting `reportData.userId`.
- `backend/functions`: `index.ts` (9 lines) and `notification.ts` (215 lines). ESLint 8 with the legacy `--ext` flag and `eslint-config-google`. `firebase-functions` ^7.2.5, `firebase-admin` ^13.8.0, TypeScript ~5.7, Node engine 24. Not built or run in Phase 0.

### 0.11 Baseline and risk report

**Confirmed defects (evidence in the repo or in a run)**

| # | Defect | Severity | Evidence |
|---|---|---|---|
| D1 | Exact Flutter pin `3.41.6` blocks `pub get` on any other Flutter | High | 0.2 |
| D2 | Router and locator generation breaks on current Dart because `analyzer` is locked at 7.7.1 | High | 0.2 |
| D3 | `ci` has no `.yml`, never runs. The workflow that does run (`cd.yml`) has no tests or format check and publishes a release on PRs | High | 0.6 |
| D4 | Three Flutter versions, three Java versions across workflows | Medium | 0.6 |
| D5 | Tests cannot run without `--dart-define-from-file` values | High | 0.2 |
| D6 | iOS: background `location` mode, "always" permission strings, `PERMISSION_LOCATION=1`, no privacy manifest: App Review rejection risks (Guideline 2.5.4, privacy manifest) | High for store release | 0.10 |
| D7 | iOS deployment target inconsistent (15.0 / 13.0) and warnings silenced | Medium | 0.10 |
| D8 | `minifyEnabled true` with no `proguard-rules.pro`, no `shrinkResources`, `proguard-android.txt` | Medium, needs a release build to know if it crashes | 0.10 |
| D9 | `usesCleartextTraffic="true"` shipped in production manifest | Medium | 0.10 |
| D10 | Firestore rules missing `uploads`, comments and subcollections | High if features rely on them | 0.10 |
| D11 | Melos scripts that reference nonexistent scripts or wrong paths; `--update-goldens` in three scripts | Medium | 0.6 |
| D12 | README describes Supabase and Gemini validation that do not exist | Low for build, medium for trust | 0.8 |
| D13 | `.gitignore` ignores `.fvmrc` | Low, blocks Phase 1 | 0.6 |
| D14 | Android fastlane has no `Fastfile`; iOS has no fastlane | Medium for Phase 7 | 0.10 |
| D15 | `sign_in_with_apple`, `permission_handler_apple`, `flutter_image_compress_common` lack SPM at locked versions | Medium (blocks Phase 3) | 0.4 |

**Recommendations (not defects)**
- Pin the newest Flutter that Shorebird supports (3.47.x). Check 3.47.5 with the Shorebird CLI.
- Use Melos 8.x (the master plan says 7.x, which is superseded).
- Provide non-secret placeholder dart-defines for tests so CI can run them.
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

### 0.13 Owner requests (nothing is needed before Phase 1 starts, except confirmations)

1. Confirm **Melos 8.x** (latest is 8.9.0; the master plan's 7.x is superseded) and **Flutter 3.47.x** as the pin.
2. Log in to the Firebase console and clear the inactivity notice. Give the name and ID of the development and staging project and say if development and staging share it.
3. For Phase 1 verification (build and test runs): the three `secrets/*.json` files. Placeholders are enough for tests. Real ones are needed to launch the app.
4. Later: the three `google-services.json` and `GoogleService-Info.plist` files, xcconfigs, keystore and `key.properties`, Play App Signing SHA-1/SHA-256, Apple Developer and App Store Connect access, APNs key, test accounts, reviewer account.
5. Install FVM SDKs if the background install did not finish (0.9). Install the Firebase CLI, FlutterFire CLI, Shorebird CLI and fastlane when their phases start.

### 0.14 Decision log

| Decision | Choice | Why |
|---|---|---|
| Flutter version for the baseline | Latest stable (3.47.5), not 3.41.6 | Owner instruction. The existing 3.41.6 pin is treated as a defect |
| Flutter version for the repo | Decided in Phase 1 | Needs Shorebird 3.47.5 check |
| Baseline method | Scratch copy outside the repo with the Flutter pin loosened | Phase 0 forbids code changes and the exact pin blocks any newer Flutter |
| Melos version | Recommend 8.x | Latest on pub.dev, same workspace model as 7 |
| Branch and commit names | `type/kebab-description`, Conventional Commits with optional scope | Owner instruction |
| ProGuard | No Gson or Freezed keep rules. Add only for a real crash | Decided by owner. `AGENTS.md` §6.3 corrected |
| Java | AGP minimum (17) or 21, zulu, one version everywhere. Decided in Phase 1 | Decided by owner |

### 0.15 Still open

- Firebase inactivity notice and project layout (owner).
- FVM SDK installs (0.9).
- Everything in 0.11 "Unknowns".
