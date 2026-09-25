#!/bin/sh
# Runs code generation and fails if it changed any committed file, meaning the
# generated files in the repository were out of date.
#
# It compares the working tree before and after generation, so uncommitted work
# of your own does not cause a false alarm. Files that Flutter writes per
# operating system (plugin registrants) are ignored.
#
# Used by CI and by `melos run ci:check`. Needs `melos` on the PATH.
set -eu

state() {
  {
    git status --porcelain -- . ':(exclude)**/GeneratedPluginRegistrant.*' ':(exclude)**/generated_plugin*'
    git diff -- . ':(exclude)**/GeneratedPluginRegistrant.*' ':(exclude)**/generated_plugin*'
  } | shasum
}

before="$(state)"
melos run flutter:build
after="$(state)"

if [ "$before" != "$after" ]; then
  echo "::error::Generated files are out of date. Review the changes made by 'melos run flutter:build' and commit them." >&2
  git status --short -- . ':(exclude)**/GeneratedPluginRegistrant.*' ':(exclude)**/generated_plugin*'
  exit 1
fi

echo "Generated files are up to date."
