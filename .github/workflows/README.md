# CI / CD workflows for Civic24

All workflows pin every action to a full commit SHA with the version in a
comment (GitHub's recommended way to get an immutable action). Dependabot
updates the SHA and the comment together (see `.github/dependabot.yml`).

| File | Runs on | What it does |
|---|---|---|
| `ci.yml` | Pull requests into `develop` or `main`, and manually | Format check, generated files up to date, analysis, tests |
| `cd.yml` | Pushes to `develop` | Builds the citizen app (development flavor) for Android and iOS and attaches the builds to a GitHub Release |
| `open_pr.yml` | Pull requests into `develop` or `main` | Assigns the author and adds labels from the branch name and changed files |

## Versions come from one place
- **Flutter:** `.fvmrc`. Both `ci.yml` and `cd.yml` read it with `flutter-version-file`, so changing the version is a one-line edit there.
- **Java:** 21, `zulu` distribution, in every workflow.
- **Melos:** the exact version in `pubspec.lock`. The workflows activate it globally because Melos scripts call each other through the `melos` command.

## `ci.yml` steps
1. Set up Java and Flutter (with caching).
2. `flutter pub get`, then activate Melos and `melos bootstrap`.
3. `melos run flutter:build` (code generation).
4. `melos run flutter:format` (in CI it fails instead of rewriting files).
5. Fail if generation changed any committed file (someone forgot to run it).
6. `melos run flutter:analyze` (must have no issues).
7. `melos run flutter:test` (placeholder values from `apps/citizen/secrets/env.example.json`, no secrets needed).

A new push to a pull request cancels the older CI run for that PR. Runs that are not pull requests are never cancelled.

Golden tests only assert on macOS and Windows (see `packages/components/test/flutter_test_config.dart`), so they are skipped on this Ubuntu job. This is temporary until `golden_toolkit` is replaced.

**Run the same checks before you open a pull request:**

```bash
melos run ci:check
```

It formats files, so commit whatever it changes.

## Secrets used
| Secret | Used by | Purpose |
|---|---|---|
| `ENCODED_DEVELOPMENT_JSON_CITIZEN` | `cd.yml` | Base64 of `apps/citizen/secrets/development.json` |

`cd.yml` uses the built-in `GITHUB_TOKEN` (with `contents: write` on the build jobs only) to publish releases. The older `TOKEN`, `CITIZEN_*_SECRETS` secrets are no longer used by any workflow.

To create or update the environment secret:

```bash
base64 -i apps/citizen/secrets/development.json | tr -d '\n' | gh secret set ENCODED_DEVELOPMENT_JSON_CITIZEN
```

## Changing things
- **Bump Flutter:** edit `.fvmrc` (and the minimum in the pubspecs if needed). Check Shorebird supports it first.
- **Update an action by hand:** find the tag's commit SHA, replace the SHA and the version comment. Dependabot normally does this in one monthly pull request.
- **A workflow needs more permissions:** add them to that job only, never to the whole workflow.
- **CI is red for an unrelated reason:** re-run it once. If it stays red, fix or revert the cause; do not skip the check.
