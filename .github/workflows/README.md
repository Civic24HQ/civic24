# CI / CD workflows for Civic24

All workflows pin every action to a full commit SHA with the version in a
comment (GitHub's recommended way to get an immutable action). Dependabot
updates the SHA and the comment together (see `.github/dependabot.yml`).

| File | Runs on | What it does |
|---|---|---|
| `ci.yml` | Pull requests into `develop` or `main`, and manually | Format check, generated files up to date, analysis, tests |
| `cd.yml` | **Manually only (paused)**, see below | Builds the citizen app (development flavor) for Android and iOS and attaches the builds to a GitHub Release |
| `open_pr.yml` | Pull requests into `develop` or `main` (`pull_request_target`) | Assigns the author and adds labels from the branch name and changed files (`.github/labeler.yml`) |

## `cd.yml` is paused
It ran on the first push to `develop` on Flutter 3.47.5 and both builds failed for known reasons:
- **Android:** the Gradle wrapper is 8.13 and Flutter 3.47 needs 8.14 or newer (Shorebird also lists AGP 8.11.1 and Kotlin 2.2.20). Fixed in Phase 4.
- **iOS:** `firebase_remote_config 6.2.0` and `firebase_storage 13.0.6` need different FlutterFire Swift packages, so Swift Package Manager cannot resolve them. Fixed in Phase 2 by upgrading the Firebase suite as one set.

Until then it only runs when started by hand (Actions tab, Run workflow). Phase 7 restores the push trigger, fixes the release race between the two jobs and adds store delivery.

## Versions come from one place
- **Flutter:** `.fvmrc`. Both `ci.yml` and `cd.yml` read it with `flutter-version-file`, so changing the version is a one-line edit there.
- **Java:** 21, `zulu` distribution, in every workflow.
- **Runners:** pinned to `ubuntu-24.04` and `macos-15`, not `-latest`, so an operating system upgrade (GitHub moves `ubuntu-latest` to Ubuntu 26 from 19 October 2026) is a deliberate change, not a surprise.
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

Golden tests run here too: the portable alchemist CI images (`goldens/ci`, text as squares, no shadows, 0.5 percent tolerance for anti-aliasing) are checked on Ubuntu. The readable images with real fonts (`goldens/macos`) are only checked on macOS. See `packages/components/test/flutter_test_config.dart`.

**Run the same checks before you open a pull request:**

```bash
melos run ci:check
```

It formats files, so commit whatever it changes.

## `open_pr.yml` and `pull_request_target`
Labeling uses `pull_request_target` so it also works for pull requests from forks and from Dependabot, whose normal token is read-only. That trigger runs with a write token, so:
- never add a checkout of the pull request, or run anything from it, to that workflow;
- never put pull request text (title, branch name, body) directly into a script; pass it through `env`;
- it runs the file, and reads `.github/labeler.yml`, from the default branch (`develop`), even for pull requests into `main`, so a change to it only takes effect after it is merged into `develop`.

Labels are configured in `.github/labeler.yml` (branch name patterns and changed-file globs). Branch labels follow our `type/description` names (`feat/`, `fix/`, `chore/`, `docs/`, `ci/`, `test/`, `build/`).

## Secrets used
| Secret | Used by | Purpose |
|---|---|---|
| `ENCODED_DEVELOPMENT_JSON_CITIZEN` | `cd.yml` | Base64 of `apps/citizen/secrets/development.json` |

`cd.yml` uses the built-in `GITHUB_TOKEN` (with `contents: write` on the build jobs only) to publish releases. The old personal-token secret `TOKEN` is still used by the workflows on `main` until `develop` is merged into it; delete it after that.

To create or update the environment secret:

```bash
base64 -i apps/citizen/secrets/development.json | tr -d '\n' | gh secret set ENCODED_DEVELOPMENT_JSON_CITIZEN
```

## Changing things
- **Bump Flutter:** edit `.fvmrc` (and the minimum in the pubspecs if needed). Check Shorebird supports it first.
- **Update an action by hand:** find the tag's commit SHA, replace the SHA and the version comment. Dependabot normally does this in one monthly pull request.
- **A workflow needs more permissions:** add them to that job only, never to the whole workflow.
- **CI is red for an unrelated reason:** re-run it once. If it stays red, fix or revert the cause; do not skip the check.

## Dependency updates (Dependabot)
`.github/dependabot.yml` makes Dependabot check monthly and open pull requests for:
- **GitHub Actions** (pinned SHAs and their version comments), one grouped PR.
- **Pub packages** of the whole workspace (Dependabot is pointed at the workspace root `/` only; listing the member folders too makes it fail). Minor and patch updates come grouped by family: `firebase`, `ui-packages`, `device-plugins`, `build-and-test-tools`. Major updates come as separate PRs. New releases wait 3 days (majors 7) before being proposed.
- **npm packages** of `backend/functions`, grouped the same way.

Dependabot only opens PRs; nothing changes until one is merged, and CI runs on each. It does not fix code, so a major update PR can be red until someone adapts the code, or it can be closed.

**Handling a Dependabot PR**
1. CI green on a grouped minor or patch PR: skim the changelog links in the description, then merge.
2. CI red: check out the branch, run `melos run ci:check`, fix what the new version needs (see the migration notes of the package), push to the same branch.
3. A major update you do not want yet: comment `@dependabot ignore this major version` on the PR. To stop it for good, add an `ignore` entry in `dependabot.yml` with the reason.
4. Useful comments: `@dependabot rebase`, `@dependabot recreate`, `@dependabot ignore this dependency`.
5. Dependabot never touches Flutter itself: change `.fvmrc` by hand (check Shorebird supports the version first).

**Held back on purpose** (listed under `ignore:`): `flex_color_scheme` and `permission_handler` majors. Remove the entry when the reason in `CHANGE_LOG.md` is resolved.

**Checking that it works.** After a change to `dependabot.yml` is merged, open Insights, Dependency graph, Dependabot on GitHub and read the log of the last run per ecosystem. Dart pub workspaces are not mentioned in GitHub's Dependabot documentation. The first `pub` run failed because the member folders were listed; the root-only setup is the fix. If it still fails or opens no PRs for member packages, the log says why; the fallback is Renovate.

Security updates (separate from this schedule) are turned on in the repository settings and open a PR as soon as a vulnerability is published for a dependency.
