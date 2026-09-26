# SPM in Flutter iOS projects

Verified with Flutter 3.47 and Xcode 26.6 on a real app (Firebase, Google Sign-In, several plugins, three flavors).

## How it works
- `flutter config` shows `enable-swift-package-manager` (`flutter config --[no-]enable-swift-package-manager`). Building a project with it on migrates the Xcode project automatically.
- Flutter writes a local package `ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`. It lists, for each plugin that supports SPM, a `.package(path: ...)` entry pointing at the plugin's own `Package.swift` in the pub cache. That directory is generated and ignored by git.
- Plugins that do not support SPM still use CocoaPods. When every plugin supports it, Flutter says "All plugins found for ios are Swift Packages" and you can remove CocoaPods (section 8 of the main skill).
- **Never add a plugin's SDK in Xcode.** Each plugin declares its own dependency (for example the FlutterFire plugins depend on `firebase-ios-sdk` at one exact version).

## Commit these
- `ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved` (the pins).
- The migrated `project.pbxproj`, the workspace file and the scheme changes Flutter made (the "Run Prepare Flutter Framework Script" pre-action).

## Update routine
1. Change plugin versions in `pubspec.yaml`, then `flutter pub get`.
2. If several plugins pin the same underlying SDK (all FlutterFire plugins pin `firebase-ios-sdk`), upgrade them together and check they agree, or SPM cannot resolve. Example for Firebase: `grep -h "let firebaseSdkVersion" ~/.pub-cache/hosted/pub.dev/firebase_*-<version>/ios/*/Package.swift` should print one value.
3. Build to make Xcode resolve and update `Package.resolved`: `flutter build ios --no-codesign --flavor <flavor> -t lib/main.dart --dart-define-from-file=secrets/<flavor>.json`. Resolution downloads binary packages and can take minutes.
4. Commit the `Package.resolved` change with the `pubspec.yaml` and `pubspec.lock` change.

## Things that bite
- The deployment target must satisfy every package (Firebase iOS SDK 12 needs iOS 15). Set it once in the Xcode project, for every configuration.
- Flutter's plugin permission macros no longer come from a Podfile. Check each plugin's SPM documentation. Example: `permission_handler_apple` 9.6 enables permissions from the `NS...UsageDescription` keys in `Info.plist`, and finds that file from the working directory, so builds started from the Xcode app itself need `launchctl setenv PERMISSION_HANDLER_INFO_PLIST <path>` and a cleared DerivedData.
- Scripts that expected Pods (Crashlytics symbol upload) must look in `<project>/build/ios/SourcePackages/checkouts` for command-line builds and in DerivedData for Xcode builds.
- A failed build can leave read-only files in `build/ios/SourcePackages`; `chmod -R u+w` before deleting.
- Xcode may write the same `Package.resolved` under both the workspace and the project; commit one, ignore the other.
