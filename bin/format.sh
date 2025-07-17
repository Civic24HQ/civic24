#!/bin/sh
set -e

# Check if running in CI
if [ "$CI" = "true" ]; then
  echo "Running in CI mode: using --set-exit-if-changed"
  FORMAT_FLAG="--set-exit-if-changed"
else
  echo "Running locally: skipping --set-exit-if-changed"
  FORMAT_FLAG=""
fi

dart format $FORMAT_FLAG $(find lib -name '*.dart' \
  -not -name '*.freezed.dart' \
  -not -name '*.g.dart' \
  -not -name '*.gen.dart' \
  -not -path '*/l10n/generated/*' \
  -not -path '*/**/generated/*' \
  -not -path '*/**/workers/*' \
  -not -name '*app.router.dart' \
  -not -name '*app.locator.dart' \
  -not -name '*app.logger.dart' \
  -not -name '*app.dialogs.dart' \
  -not -name '*app.bottomsheets.dart' \
  -not -name '*.form.dart' \
  -not -name '*.router.dart' \
  -not -name '*.mocks.dart' \
  -not -name 'lib/generated_plugin_registrant.dart')
