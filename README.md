# Civic24

![Civic24 Banner](.github/banner.png)

[![style: analysis](https://img.shields.io/badge/style-flutter_analysis-blue.svg)](https://dart.dev/guides/language/analysis-options)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)


**Civic24** is a mobile platform that empowers people to report civic-related issues in their communities and engage with fellow citizens through feedback and discussion.

This directly aligns with [**SDG Goal 11: Sustainable Cities and Communities**](https://globalgoals.org/goals/11-sustainable-cities-and-communities), which aims to make urban areas inclusive, safe, resilient, and sustainable.

Civic24 also uses **Google’s Generative AI** to validate submitted posts and images, ensuring that only genuinely civic-related content gets shared.

And the best part? It’s **Open Source**. 🧑🏾‍💻

👉 Click here to view the [Civic24 Design Case Study](https://www.behance.net/gallery/229296271/Civic24-Mobile-App-Design-UIUX-Case-Study)

---

## Description
This repository contains the source code for the **Civic24** mobile applications, including:
- **Citizen App**: The main user-facing app that enables individuals to report civic issues, view updates, and participate in public conversations.
- **Admin App**: A web-based dashboard for government officials and administrators to review reports, manage feedback and oversee community activity.
- **Shared Packages**: Modular Dart packages used across both apps to ensure consistent design, localization and shared functionality:
  - `components/`: Reusable UI widgets.
  - `styles/`: Design system and typography.
  - `services/`: Firebase/Supabase integrations.
  - `localization/`, `utils/`, `models/`, etc.

This monorepo is managed using **Melos** to handle interdependencies between packages efficiently.

---

## 🚀 Requirements

Make sure the following tools are installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install), the exact version is pinned in [`.fvmrc`](.fvmrc) (currently 3.47.5). The easiest way to get it is [FVM](https://fvm.app/) (`brew install fvm`), but FVM is optional: any install of that Flutter version works
- Dart SDK (comes with Flutter)
- [Melos](https://melos.invertase.dev/) 8 (`dart pub global activate melos`)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- [Git](https://git-scm.com/)
- [VS Code](https://code.visualstudio.com/)

---

## 📦 Getting Started

```bash
git clone https://github.com/Civic24HQ/civic24
cd civic24

# With FVM (recommended): installs the Flutter version in .fvmrc,
# then runs the workspace's own Melos through FVM's Flutter and Dart.
fvm install
fvm flutter --version                  # should match .fvmrc
export MELOS_SDK_PATH=.fvm/flutter_sdk # makes Melos scripts use the FVM SDK
fvm dart pub global activate melos
export PATH="$PATH:$HOME/.pub-cache/bin"   # add to ~/.zshrc too, or `melos` is "command not found"
melos bootstrap
```

```bash
# Without FVM: install the Flutter version in .fvmrc yourself
# (the SDK on your PATH must match it), then:
flutter --version
dart pub global activate melos
export PATH="$PATH:$HOME/.pub-cache/bin"   # add to ~/.zshrc too, or `melos` is "command not found"
melos bootstrap
```

The rest of this README writes `melos ...`; the commands are the same with or without FVM once `MELOS_SDK_PATH` is exported. Melos scripts call each other through the `melos` command, so Melos must be activated globally, not only run with `dart run`. The pubspecs require `flutter >= 3.47.0`, so `pub get` stops with a clear message on an older Flutter.

The repository is a Dart pub workspace: there is a single `pubspec.lock` at the root and no `pubspec_overrides.yaml` files. Melos scripts live in the root `pubspec.yaml` under `melos:`.

---

## Project Structure

```
civic24/
├── apps/
│   ├── citizen/          # Main user-facing app
│   └── admin/            # Admin dashboard
│
├── packages/
│   ├── assets/           # Images and Fonts Setup
│   ├── components/       # Reusable UI Widgets
│   ├── constants/        # Static Variables and constants
│   ├── localization/     # i18n Setup
│   ├── models/           # Data Models
│   ├── rules/            # Flutter Linter Rules Setup
│   ├── services/         # Firebase, Supabase, API Integrations
│   ├── styles/           # Design System and Typography
│   └── utils/            # Utility Methods
│
├── bin/                  # Helper scripts (format, test)
├── .fvmrc                # Pinned Flutter version
├── pubspec.yaml          # Workspace definition and Melos scripts
└── README.md
```

---

## Melos Workspace

### **Common Commands**

```bash
melos bootstrap            # Link and install all packages
melos clean                # Clean all builds
melos run flutter:format   # Run custom format script for apps and packages
melos run localization:intl    # Generate localization files
melos run flutter:build    # Runs build for all apps and packages
melos run flutter:analyze  # Static code analysis for apps and packages
melos run flutter:test     # Runs tests (placeholder env values, never updates goldens)
melos run citizen:run:development  # Run the citizen app (needs apps/citizen/secrets/development.json)
```

Golden baselines are only updated on purpose, with `melos run components:update:golden`.

Launcher icons are generated with a global tool, not a workspace dependency:

```bash
dart pub global activate flutter_launcher_icons
cd apps/citizen && dart pub global run flutter_launcher_icons -f flutter_launcher_icons-development.yaml
```

### Running on iOS

iOS uses Swift Package Manager (no CocoaPods). To run a flavor you need two files of your own, both gitignored, from your own Firebase project:

- `apps/citizen/ios/config/<flavor>/GoogleService-Info.plist`
- `apps/citizen/secrets/<flavor>.json`, including `IOS_CLIENT_ID` (the `CLIENT_ID` value in that plist; see `secrets/env.example.json`)

Then `melos run citizen:run:development`, or `flutter run -d <simulator> --flavor development -t lib/main.dart --dart-define-from-file=secrets/development.json` from `apps/citizen`. Install the FlutterFire CLI once (`dart pub global activate flutterfire_cli`) for the Crashlytics upload step. There is nothing to edit in Xcode or any xcconfig. The three flavors show as Civic24 DEV, Civic24 STG and Civic24.

**Running from the Xcode app.** `flutter run` and `xcodebuild` work as they are. The Xcode app itself starts package resolution from `/`, where the `permission_handler_apple` package cannot find `ios/Runner/Info.plist`, so camera, photos and location would silently report "denied". Once per login (it resets on reboot), point it at the file, then restart Xcode and clear its cache:

```bash
launchctl setenv PERMISSION_HANDLER_INFO_PLIST "$PWD/apps/citizen/ios/Runner/Info.plist"   # run from the repository root
rm -rf ~/Library/Developer/Xcode/DerivedData
```

---

## Firebase & Supabase

- Firebase is used for push notifications (FCM), analytics, and crash reporting.
- Supabase is used for real-time PostgreSQL database, authentication, and storage.

---

## Developer Guidelines

- Follow the Flutter linter rules in `packages/rules/analysis_options.yaml`
- Use consistent commit naming: `feat:`, `fix:`, `chore:`, `refactor:`
- Document all new features in PR Description
- Write unit and golden tests where necessary

---

## 🚦 CI/CD Pipelines

Civic24 uses **GitHub Actions** to automate Continuous Integration (CI), Continuous Deployment (CD) and Pull Request (PR) management.

### Continuous Integration (`ci.yml`)
Runs on every Pull Request into `develop` or `main`, and again on each new push to that PR.

**Key checks:**
- **Code generation** – `melos run flutter:build`
- **Formatting** – `melos run flutter:format` (fails instead of rewriting files in CI)
- **Generated files up to date** – fails if generation changed any committed file
- **Analysis** – `melos run flutter:analyze` (must be clean)
- **Tests** – `melos run flutter:test` (placeholder values, no secrets)

Run the same checks locally before opening a PR:

```bash
melos run ci:check
```

### Continuous Deployment (`cd.yml`)
Runs on every push to `develop`. It builds the citizen app (development flavor) for Android and iOS and attaches the builds to a GitHub Release. It needs the `ENCODED_DEVELOPMENT_JSON_CITIZEN` repository secret (base64 of `apps/citizen/secrets/development.json`):

```bash
base64 -i apps/citizen/secrets/development.json | tr -d '\n' | gh secret set ENCODED_DEVELOPMENT_JSON_CITIZEN
```

Full details, versions and how to change them: [`.github/workflows/README.md`](.github/workflows/README.md).

### Pull Request Intelligence (`open_pr.yml`)
This is triggered when a PR is opened or updated. It automatically labels PRs (e.g. `apps/admin`, `packages/constants`) based on which files changed.

### Best Practices
- Use **Draft PRs** while work is in progress.
- Run `melos run ci:check` before opening a PR, and make sure CI is green before requesting review.

---

## 🖼️ Golden Tests Guide

Golden tests capture snapshots of widgets to catch visual regressions. They use [alchemist](https://pub.dev/packages/alchemist) and live in `packages/components/test`.

### How they look
Two sets of images are kept next to every test:
- **`goldens/macos/`**: readable images with the real fonts and icons. Checked on macOS only. **Open these to see what a component looks like.**
- **`goldens/ci/`**: text and icons drawn as coloured squares (the Ahem font), shadows off. These are what CI checks on Ubuntu. Because anti-aliasing differs slightly between operating systems, a difference of up to 0.5 percent of the pixels is tolerated. A change in font size, spacing, colour or layout still fails; the wording of a label does not.

### How to Write a Golden Test

Use the `testableWidget` helper to wrap your widget with theme, localization and layout context, and the `goldenScenarios` helper for a set of named scenarios.

```dart
void main() {
  goldenScenarios(
    'MyWidget',
    fileName: 'my_widget',
    scenarios: [
      GoldenTestScenario(
        name: 'light theme',
        child: SizedBox(height: 120, child: testableWidget(const MyWidget())),
      ),
      GoldenTestScenario(
        name: 'dark theme',
        child: SizedBox(height: 120, child: testableWidget(const MyWidget(), dark: true)),
      ),
    ],
  );
}
```

Use `goldenDeviceScenarios` to render the scenarios at phone or tablet size (`GoldenDevice.phone`, `GoldenDevice.tabletPortrait`).

### Running Golden Tests

```bash
melos run components:golden          # check the baselines
melos run components:update:golden   # refresh both sets (on a Mac, only for an intentional visual change)
```

Every test run, including CI, checks them: `melos run flutter:test`.

### Output Location

Baselines are saved next to each test as `goldens/macos/<fileName>.png` and `goldens/ci/<fileName>.png`. Commit both sets. The readable `goldens/macos` images are only checked on macOS, so update them on a Mac.

---

## 🧠 Skills

Reusable, step-by-step guides that people read and AI coding agents can load. They follow the open [Agent Skills](https://agentskills.io) format: one folder per skill containing a `SKILL.md` (name and description in the header, instructions below) and optional `references/`, `scripts/` and `assets/` folders. They live in `.agents/skills/`, a tool-neutral location.

| Skill | What it covers |
|---|---|
| [`golden-toolkit`](.agents/skills/golden-toolkit/SKILL.md) | Setting up, writing and running Flutter golden tests with the `golden_toolkit` package (discontinued), for projects that cannot use `alchemist` |

**Using them:** read the `SKILL.md` directly on GitHub. Tools that scan `.agents/skills/` pick them up automatically. Claude Code reads `.claude/skills/`, so copy or link a skill folder there (`mkdir -p .claude/skills && ln -s ../../.agents/skills/golden-toolkit .claude/skills/golden-toolkit`). **Adding one:** create `.agents/skills/<name>/SKILL.md` (the folder name must equal `name`, lowercase with hyphens, description under 1024 characters), keep `SKILL.md` under 500 lines, move long examples to `references/`, list it in this table, and validate it with `skills-ref validate .agents/skills/<name>`.

---

## Download Civic24 App (Preview Builds)

You can test the latest preview builds of the Civic24 mobile apps without setting up a development environment.

### Download from Releases
Go to the official [Releases Page](https://github.com/Civic24HQ/civic24/releases/) to download:

- `.apk` file for Android
- `.ipa` file for iOS

Each release contains build artifacts generated from our CI pipelines.

---

## Contribution

1. Fork the repository
2. Create a new branch from `develop`: `git checkout -b feat/amazing-feature`
3. Make your changes, test locally and write a clear well-commented code
4. Run the following commands:
```bash
  melos clean
  melos bootstrap
  melos run flutter:format
  melos run localization:intl
  melos run flutter:build
  melos run flutter:analyze
```
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request with a clear description and screenshots if necessary

---

## Contact & Community

For feedback, ideas or contributions kindly open an issue or connect with me on Twitter [@CalebJesusegun](https://x.com/CalebJesusegun).

Let's build Civic24 together 🌍