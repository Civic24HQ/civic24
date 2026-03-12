fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android development

```sh
[bundle exec] fastlane android development
```

This lane builds the Android app and distributes it to Firebase App Distribution for Development Flavor.

### android staging

```sh
[bundle exec] fastlane android staging
```

This lane builds the Android app and distributes it to Firebase App Distribution for Staging Flavor.

### android production

```sh
[bundle exec] fastlane android production
```

This lane builds the Android app and distributes it to Firebase App Distribution for Production Flavor.

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
