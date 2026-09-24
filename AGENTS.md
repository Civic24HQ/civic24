# AGENTS.md — Civic24 Engineering & Agent Guide

This document provides repository context, architectural rules, commands, and safety guidelines for AI coding agents working on the **Civic24** codebase. `CLAUDE.md` imports this file, so it is the single source of truth for every agent.

> **ACTIVE PROJECT REFACTOR IN PROGRESS:**  
> The project is currently being refactored, updated, and prepared for store release. Before starting tasks, read `CHANGE_LOG.md` (if it exists), `docs/V2_REFACTOR_PROMPT.md` (**reference only**: extra detail, never followed where it conflicts) and `docs/CIVIC24_REFACTOR_PROMPT.md` (the **master plan**: follow its phase order; it overrides V2 on any technical point). Known conflicts, already decided: no Gson or Freezed ProGuard keep rules unless a real crash requires them, no hardcoded Gemini 2.0 Flash, and no forced Java 17 (use what the Android Gradle Plugin requires). Stop and ask about any other conflict.  
> **Strict Rule on Changes:** Update dependencies first $\rightarrow$ Refactor second $\rightarrow$ Add features third. Never combine updates, refactoring, and new features in the same pull request.

---

## 1. Repository Structure

Civic24 is an open-source civic reporting app where citizens report community issues and discuss local fixes. The codebase is a Dart/Flutter monorepo managed with **Melos**, with two apps, shared packages, and a Firebase backend. The architecture is Stacked (MVVM, generated router and locator).

### Apps and Packages
* `apps/citizen`: Main mobile app (Flutter for iOS & Android; live on Google Play, iOS release pending).
  * **Views:** `startup`, `onboarding`, `auth` (login, register, forgot password), `complete_profile`, `home`, `main`, `reports`, `add_report`, `notification`, `settings`.
  * **Flavors:** `development`, `staging`, `production`.
* `apps/admin`: Admin dashboard (Flutter stub).  
  * **Rule:** Do **not** refactor or expand unless asked. Just keep it compiling during workspace-wide tasks.
* `packages/`: Shared packages:
  * `constants`: Global keys, analytics IDs, Firestore collections, and `EnvironmentConstants`.
  * `models`: Data models using `@freezed` and `@JsonSerializable`.
  * `services`: Core services: Firebase (Auth, Firestore, Storage, Messaging, Analytics, Crashlytics, Remote Config, App Check, Performance), Location, Media, Push Notifications, Cloudinary uploads, and local storage (`hive_ce`).
  * `components`: Reusable UI widgets and design system components (has unit and golden tests).
  * `styles`: Theme (`flex_color_scheme`), typography (Poppins), colors, and spacing tokens.
  * `localization`: Generated translations (`intl`, `intl_utils`). ARB files live in `lib/src/l10n/arb/`.
  * `utils`: Helpers, formatters, and custom loggers.
  * `assets`: Images, SVGs, icons, fonts, and `flutter_gen` generated classes.
  * `rules`: Shared analysis options and lint rules (`lib/analysis_options.yaml`).
* `backend/`: Firebase Cloud Functions in TypeScript (`backend/functions`, Node 24, `firebase-functions` v7, `firebase-admin` v13), Firestore rules, and indexes.

### Package Rules
* **No imports from apps:** A package in `packages/*` must **never** import from an app in `apps/*`.
* **Put code in the right place:** Keep app-specific code inside that app. Reusable UI goes in `packages/components`, business logic goes in `packages/services`, and shared models go in `packages/models`.
* **Check local READMEs:** Read the nearest `README.md` and `pubspec.yaml` before changing an app or package.

---

## 2. Current Toolchain & Known Issues

> [!NOTE]  
> These are temporary observations to recheck, not permanent design rules. When you resolve an issue during a phase, remove or update it here.

1. **Flutter Version:**
   * `.fvmrc` pins Flutter `3.47.5` (Dart 3.13.4). Pubspecs require `flutter >=3.47.0` and `sdk >=3.13.0 <4.0.0`. Change the version in `.fvmrc` only, then bump the pubspec minimum when needed.
   * CI workflows are still inconsistent until the CI repair PR merges: `.github/workflows/ci` uses Flutter `3.32.6`, while `.github/workflows/cd.yml` uses `3.38.7`. They should read `.fvmrc`.
   * FVM is optional for developers; the pinned version is what matters.
   * Flutter 3.47 starts decoupling Material and Cupertino into `material_ui` and `cupertino_ui`. The old `package:flutter/material.dart` imports still work; formal deprecation is planned for the November 2026 stable. Plan the migration for a later phase.
2. **CI File Missing Extension:**
   * The file `.github/workflows/ci` has no `.yml` extension, so GitHub Actions ignores it until renamed to `ci.yml`.
3. **Single Entry Point:**
   * The citizen app entry point is `apps/citizen/lib/main.dart`.
   * *Ignore old references in README files to `main_development.dart`—they do not exist.*
4. **Tests Need Environment Values:**
   * `EnvironmentConstants` asserts on `String.fromEnvironment` at compile time, so tests only load when compile-time values are supplied. Run tests with `melos run flutter:test` (or `bin/test.sh` inside a package): it passes the non-secret placeholders in `config/test_env.json` and treats "no tests found" (exit 79) as success.
5. **Very Few Real Tests:**
   * `apps/citizen` and `apps/admin` have zero test cases (their test files are empty groups). The workspace has about 27 real cases, 21 of them component goldens. Broader coverage is Phase 8 work.
6. **Golden Tests Caution:**
   * `test:golden` and the `*:golden` scripts run goldens without changing baselines. Only `melos run components:update:golden` overwrites them, and only for an intentional visual change.
   * Golden assertions run on macOS and Windows only (`flutter_test_config.dart`), so Linux CI skips them.
   * `golden_toolkit` is discontinued; replacing it is Phase 2 work.
7. **Launcher Icons:**
   * `flutter_launcher_icons` is not a workspace dependency (it needs `cli_util` 0.4 while Melos 8 needs 0.5). Run it as a global tool: `dart pub global activate flutter_launcher_icons`, then `dart pub global run flutter_launcher_icons -f <config>` from the app folder.
8. **Secrets are Not in Git:**
   * Flavor JSON files, Google service files, and keystores are gitignored.
   * Real citizen Firebase and OAuth configs are absent on fresh checkouts; environment-specific auth cannot be verified without credentials and project access. Never claim tests passed if real credentials or active Firebase settings are missing.

---

## 3. Common Commands

Run all commands from the **repository root** unless stated otherwise.

### 3.1 Bootstrap & Setup
With FVM (recommended). The workspace's own Melos runs through FVM's Dart, and `MELOS_SDK_PATH` makes Melos scripts use the FVM Flutter:
```bash
fvm install                            # installs the Flutter version pinned in .fvmrc
export MELOS_SDK_PATH=.fvm/flutter_sdk
fvm flutter pub get
fvm dart run melos bootstrap           # workspace: one root pubspec.lock, no pubspec_overrides.yaml
```
Without FVM (the Flutter on your PATH must match `.fvmrc`):
```bash
dart pub global activate melos
melos bootstrap
```
Every `melos ...` command in this file is `fvm dart run melos ...` on the FVM path.
Melos 8 config and every script live in the root `pubspec.yaml` under `melos:` (there is no `melos.yaml`). Aggregate scripts stop at the first failing step.

### 3.2 Code Generation & Localization
Run generation after editing Stacked views, Freezed models, assets, or localization:
```bash
# Generate code across all packages (build_runner, stacked, freezed, flutter_gen, intl)
melos run flutter:build

# Generate citizen app code only (routes, dialogs, bottom sheets, forms)
melos run citizen:build

# Generate translations after editing ARB files (lib/src/l10n/arb/)
melos run localization:intl

# Build backend Cloud Functions
melos run backend:build
```

### 3.3 Generating Code with Stacked CLI
Use Stacked CLI scripts via Melos to create new files:
```bash
melos run citizen:view         # Create new View & ViewModel
melos run citizen:service      # Create new Service
melos run citizen:dialog       # Create new Dialog
melos run citizen:bottomsheet  # Create new Bottom Sheet
```
*Note: Register new views/services in `apps/citizen/lib/app/app.dart` and run `melos run citizen:build`.*

### 3.4 Formatting & Analysis
```bash
# Format Dart files (skips generated files)
melos run flutter:format

# Analyze all apps and packages (must have 0 errors and 0 warnings)
melos run flutter:analyze

# Analyze citizen app only
melos run citizen:analyze
```

### 3.5 Testing
```bash
# Run all tests (placeholder env values, goldens never updated)
melos run flutter:test

# Run citizen app unit and widget tests
melos run citizen:test

# Run tests for one package (e.g. services, components)
melos run <package>:test

# Run all package tests
melos exec --dir-exists="test" -- "flutter test --no-pub"

# NOTE: only 'melos run components:update:golden' updates golden images. Use it only for an intentional visual change.
```

### 3.6 Running the App
> [!IMPORTANT]
> The citizen app requires compile-time configuration using `--dart-define-from-file`. Running without it will fail on an assertion in `EnvironmentConstants`.

```bash
# Development (default for local simulator/emulator)
flutter run -d <device_id> --flavor development -t lib/main.dart --dart-define-from-file=secrets/development.json

# Staging
flutter run -d <device_id> --flavor staging -t lib/main.dart --dart-define-from-file=secrets/staging.json

# Production
flutter run -d <device_id> --flavor production -t lib/main.dart --dart-define-from-file=secrets/production.json
```

---

## 4. Code & Architecture Rules

### 4.1 State Management (Stacked MVVM)
* **Views (`StackedView<TViewModel>`):**
  * Views only build UI and handle user taps.
  * No database calls, direct service calls, or business logic inside views.
* **ViewModels (`BaseViewModel` / `FormViewModel`):**
  * ViewModels handle business logic, form validation, and state updates.
  * Do not store `BuildContext` inside ViewModels.
* **Dependency Injection (GetIt):**
  * Registered in `packages/services` and generated in `apps/citizen/lib/app/app.locator.dart`.
  * Access services with `serviceLocator<T>()` or locator getters.
  * Never create service instances directly inside widgets or ViewModels (e.g. `final auth = AuthService()`).
* **Navigation:**
  * Use the generated `stackedRouter` (`RouterService`) with `navigator2: true` (see `build.yaml`).

### 4.2 Data Models
* Models in `packages/models` must use `@freezed` and `@JsonSerializable`.
* Re-run generation when fields change: `melos run models:build`.
* **Never edit generated files by hand** (`*.freezed.dart`, `*.g.dart`, `*.locator.dart`, `*.router.dart`, `*.gen.dart`, `*.form.dart`). Always update the source file and re-run the generator.

### 4.3 UI & Theming
* Use theme tokens, colors, padding, and text styles from `packages/styles` (`flex_color_scheme`).
* Do not use raw hex colors (`#XXXXXX`), magic spacing numbers, or inline fonts in views.
* Use the Poppins font from `packages/assets`.

### 4.4 Localization
* Never hardcode user-facing strings in UI files.
* Add strings to `packages/localization/lib/src/l10n/arb/intl_en.arb`.
* Run `melos run localization:intl` to generate code.
* Use them in UI with `l10n.<stringKey>`.

### 4.5 Logging & Errors
* Use `getLogger('ClassName')` from `packages/utils`.
* Caught errors in services should be logged and sent to Firebase Crashlytics as non-fatal errors.
* Never log auth tokens, passwords, or personal user data.

### 4.6 Tests & Mocks
* Tests live in `apps/citizen/test/` and in each package's `test/` folder.
* Mocks use Mockito in `test_helpers.dart`.
* When changing a public service method, regenerate mocks with `build_runner`.

---

## 5. Firebase & Secrets

### 5.0 Firebase Projects
* Production: `civic24-sdg11`. Development and staging: `civic24test-f9352` (shared for now, revisit before the first App Store release). Project IDs are public config, not secrets.

### 5.1 Never Commit Secrets
These files are gitignored and must stay out of git:
* `apps/citizen/secrets/{development,staging,production}.json`
* `apps/citizen/android/app/src/{development,staging,production}/google-services.json`
* `apps/citizen/ios/config/{development,staging,production}/GoogleService-Info.plist`
* `apps/citizen/ios/Flutter/{Debug,Staging,Release}.xcconfig`
* `apps/citizen/android/key.properties` and keystores (`*.jks`, `*.keystore`)

### 5.2 When Missing Credentials: Stop & Ask
* Never make up fake values for production files.
* Use `apps/citizen/secrets/env.example.json` only as a list of required keys.
* Never put sensitive API keys (like Gemini / AI keys) in the mobile app. They belong in Cloud Functions (`backend/functions`).

### 5.3 Google Sign-In Configuration
* **Android:** Ensure SHA-1 and SHA-256 fingerprints for:
  1. Local Debug Keystore (`~/.android/debug.keystore`)
  2. Release Upload Keystore (`key.properties`)
  3. **Google Play App Signing Key** (from Play Console $\rightarrow$ App Integrity)  
  ...are added in Firebase Console for each package ID (`co.civic24.citizen`, `.dev`, `.stg`).
* **Web Client ID:** `WEB_CLIENT_ID` in `secrets/<flavor>.json` must match the OAuth 2.0 Web Client ID in Google Cloud Console. A mismatch causes `ApiException 10`.
* **iOS:** Ensure `ios/Flutter/*.xcconfig` contains `GIDClientID` and `GOOGLE_REVERSED_CLIENT_ID` matching the bundle ID, and that the reversed scheme is in `Info.plist`.

### 5.4 Firebase App Check
* Configured in `apps/citizen/lib/bootstrap.dart`.
* On emulators and simulators, copy the debug token from console logs and add it to Firebase Console under App Check $\rightarrow$ Manage Debug Tokens.

### 5.5 Production Safety
* Never change Firebase Console settings, Firestore rules in production, or signing credentials without explicit permission.

---

## 6. iOS, Android & Store Guidelines

### 6.1 iOS & Swift Package Manager
* The iOS project is moving from CocoaPods to Swift Package Manager (SPM).
* **Crashlytics Run Script:** Update the Run Script in `Runner.xcodeproj` to use the SPM checkouts path instead of `${PODS_ROOT}/FirebaseCrashlytics/run`:
  `"${BUILD_DIR%Build/*}SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"`.
* **Deployment Target:** Set the minimum iOS target to `15.0` (or what Firebase requires) directly in Xcode. Remove any Podfile `post_install` overrides forcing lower versions.

### 6.2 App Store Review Requirements
* **No Background Location:**  
  Never add `location` to `UIBackgroundModes` in `apps/citizen/ios/Runner/Info.plist`. Civic24 only needs location when the app is in use (`whenInUse`) to tag issues. Background location leads to rejection under **Guideline 2.5.4**.
* **Clear Permission Strings:**  
  `NSLocationWhenInUseUsageDescription` must clearly say that location is used to attach coordinates to reported issues.
* **User-Generated Content (Guideline 1.2):**  
  * Feed cards must have a "Report / Flag" button.
  * User profiles and issue details must have a "Block User" option.
* **Terms of Use (Civic24 submission requirement):**
  Sign-up must include Terms of Use (EULA) acceptance before a user can post. This is a Civic24 requirement for the first App Store submission, tracked separately from Guideline 1.2.
* **Account Deletion (Guideline 5.1.1):**  
  The "Delete Account" button in `ProfileViewModel` must work properly.
* **Privacy Manifest:**  
  Maintain `apps/citizen/ios/Runner/PrivacyInfo.xcprivacy` declaring accessed APIs (like `NSPrivacyAccessedAPICategoryUserDefaults`).

### 6.3 Android & 16 KB Page Support
* Support **16 KB page sizes** as required for Android 15+ (Google Play 2026 rule).
* Set `compileSdk = 36` and `targetSdk = 36`.
* Use Kotlin DSL (`build.gradle.kts`).
* Use platform notation for the Firebase BOM: `implementation(platform("com.google.firebase:firebase-bom:<version>"))`. `<version>` is a placeholder, not a copyable value: replace it with the latest published BOM version from the Firebase Android release notes when you make the change (the repo currently uses 34.11.0).
* Do not add Gson or Freezed ProGuard keep rules. Freezed models are Dart, so R8 never touches them. Add a keep rule to `proguard-rules.pro` only when a real release build crash or a plugin's docs require it, and log why in `CHANGE_LOG.md`.

### 6.4 Shorebird Code Push
* Shorebird cannot patch changes that touch native code (Gradle, Kotlin, Xcode, Podfile, SPM, or new native plugins).
* Any phase that changes SDKs or native code requires a **fresh base release** (`shorebird release`), not a patch.

---

## 7. Verification & Definition of Done

### 7.1 Verification Levels
Always state how changes were verified:
1. **Level 1 (Static Analysis):** Analyzer passes (`melos run flutter:analyze`) with 0 errors and 0 warnings, code generation passes.
2. **Level 2 (Local Build & Tests):** Unit tests pass, app builds and runs locally on an emulator or simulator.
3. **Level 3 (Live Cloud Verification):** Tested against real Firebase project, real sign-in, or real physical device.

*Never mark a feature as verified if credentials or devices were missing. State what was tested and what remains blocked.*

### 7.2 Definition of Done
A task or phase is complete only when:
1. `melos bootstrap` runs without errors.
2. `melos run flutter:build` finishes with exit code 0.
3. `melos run flutter:analyze` returns **0 errors and 0 warnings**.
4. Tests pass (`melos run citizen:test`, `<package>:test`).
5. App builds and launches in the `development` flavor on an iOS Simulator or Android Emulator.
6. Changes, decisions, and any blocked items are recorded in `CHANGE_LOG.md`.

---

## 8. Git Workflow & PRs

* **Branch from `develop`:** (e.g. `chore/2026-refactor-phase1`). Never push directly to `develop` or `main`.
* **Conventional Commits:** Use standard prefixes: `feat:`, `fix:`, `chore:`, `refactor:`, `test:`, `docs:`.
* **One concern per PR:** Keep each PR focused on one specific step.
* **PR Descriptions:** State what changed, why, what tests were run, and any open questions.
* **Keep this file updated:** When a phase changes a command, version, or convention (e.g. moving to pub workspaces, Melos 8, Kotlin DSL, or Swift Package Manager), update this `AGENTS.md` file in the same PR.
* **Keep temporary work out:** Keep task-specific migration plans and release checklists in separate documents (`docs/V2_REFACTOR_PROMPT.md`, `CHANGE_LOG.md` and the master plan `docs/CIVIC24_REFACTOR_PROMPT.md`), not here, so temporary work does not become standing instructions.
