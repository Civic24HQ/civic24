#!/bin/sh
# Runs `flutter test` for the current package with placeholder (non-secret)
# environment values so EnvironmentConstants assertions pass.
#
# `flutter test` exits with 79 when a package has no test cases. That is not a
# failure for this workspace, so it is reported and treated as success.
# Golden baselines are never updated here.
set -u

ROOT="${MELOS_ROOT_PATH:-$(cd "$(dirname "$0")/.." && pwd)}"

flutter test --no-pub --dart-define-from-file="$ROOT/config/test_env.json" "$@"
code=$?

if [ "$code" -eq 79 ]; then
  echo "No test cases found in $(basename "$PWD"); treating as success."
  exit 0
fi

exit "$code"
