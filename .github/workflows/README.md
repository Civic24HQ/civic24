# CI / CD Workflows for Civic24 🔧

This repo uses GitHub Actions + Melos to build, test, and publish Android and iOS artifacts.

## Workflows

- `cd.yml` — Runs on pushes to `develop`, on tags `v*`, and on PRs targeting `develop`.
  - Jobs:
    - `test` — Runs unit and widget tests across packages and apps, then runs analyzer.
    - `build-ios` — Builds iOS artifacts per-app and per-flavor. For `citizen` we build `development`, `staging`, and `production` flavors (injects secrets). For `admin` we use the normal, single-target flow.
    - `build-android` — Builds Android artifacts per-app and per-flavor. For `citizen` we build the three flavors and pass in dart-defines via secrets.

- `open_pr.yml` — PR labeler and basic checks when a PR is opened/synced.

## Required repository secrets

Add these repository secrets under Settings → Secrets and variables → Actions:

- `TOKEN` — Token used by release action to upload artifacts.
- `CITIZEN_DEV_SECRETS` — Contents of `apps/citizen/secrets/development.json` (stringified JSON).
- `CITIZEN_STAGING_SECRETS` — Contents of `apps/citizen/secrets/staging.json` (stringified JSON).
- `CITIZEN_PROD_SECRETS` — Contents of `apps/citizen/secrets/production.json` (stringified JSON).

Notes:
- Secrets must be valid JSON files; the workflow will write them to `apps/citizen/secrets/<flavor>.json` at runtime.
- Keep secrets out of git history; the repo already ignores `/secrets/`.

## Local verification

To reproduce CI locally:

1. Checkout branch and run:

```bash
# from repo root
dart pub global activate melos
melos bootstrap
melos run flutter:analyze
melos exec --dir-exists="test" -- "flutter test --no-pub"
```

2. To build a flavor locally (citizen production example):

```bash
flutter build apk --flavor production --target lib/main.dart --dart-define-from-file=apps/citizen/secrets/production.json --split-per-abi
```

## Troubleshooting

- If CI fails with "secrets not set" make sure repository secrets are present and valid JSON strings.
- If builds fail on macOS runners, ensure CocoaPods and Xcode versions are compatible; see `ios/ExportOptions.plist` for archive settings.
