#!/bin/sh
# Runs `flutter test` for the current package with the placeholder (non-secret)
# values in apps/citizen/secrets/env.example.json so EnvironmentConstants
# assertions pass. Real values go in the gitignored secrets/<flavor>.json files.
#
# `flutter test` exits with 79 when nothing was run. For an unfiltered run that
# only means the package has no test cases, so it is reported and treated as
# success. When a filter is passed (for example --tags or --name), "no tests"
# means the selection matched nothing, which stays a failure.
# Golden baselines are never updated here.
set -u

ROOT="${MELOS_ROOT_PATH:-$(cd "$(dirname "$0")/.." && pwd)}"

flutter test --no-pub --dart-define-from-file="$ROOT/apps/citizen/secrets/env.example.json" "$@"
code=$?

if [ "$code" -eq 79 ] && [ "$#" -eq 0 ]; then
  echo "No test cases found in $(basename "$PWD"); treating as success."
  exit 0
fi

exit "$code"
