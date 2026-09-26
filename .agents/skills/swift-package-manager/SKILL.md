---
name: swift-package-manager
description: Set up and maintain Swift Package Manager (SPM) dependencies in an iOS or macOS Xcode project, step by step. Covers adding a package, version rules, committing Package.resolved, resolving and updating dependencies from Xcode and the command line, resetting caches, CI reproducibility, migrating from CocoaPods, and a periodic update routine. Flutter projects have their own section because Flutter generates the SPM package for you. Use when adding, pinning, updating, auditing or debugging SPM dependencies.
license: MIT
metadata:
  verified-with: Xcode 26.6, Swift 6.3, Flutter 3.47
  scope: apps that use Xcode projects; Flutter specifics in references/FLUTTER.md
---

# Swift Package Manager (SPM)

SPM is Apple's dependency manager, built into Xcode. A dependency is a **package** (a Git repository with a `Package.swift`) that exposes one or more **products** (libraries you link). Versions come from Git tags (semantic versioning).

Commands marked **(run)** were executed while writing this skill. The others come from Apple's documentation or `--help` output and were not run in a project.

## When to use SPM, and when not
- New projects: prefer SPM. It is built into Xcode, needs no extra tool, and most large vendors and Flutter plugins publish SPM support. Check the maintenance status of any other manager before starting a project on it.
- A dependency that only ships a podspec cannot be added with SPM. Keep CocoaPods for it, or ask the maintainer for SPM support. You can mix both while migrating (see "Migrating from CocoaPods").

## 1. Add a package (Xcode)
1. File, Add Package Dependencies.
2. Paste the repository URL, for example `https://github.com/firebase/firebase-ios-sdk`.
3. Pick the **dependency rule** (see the table).
4. Choose the products to link and the target they go into. Link only what you use: every product adds build time and app size.
5. Xcode resolves the graph and writes `Package.resolved`. Commit it (see section 3).

| Rule | Meaning | Use it for |
|---|---|---|
| Up to Next Major | `1.2.3` up to but not including `2.0.0` (default) | Most dependencies |
| Up to Next Minor | `1.2.3` up to but not including `1.3.0` | Packages that break in minors |
| Exact | Only that version | Anything that must match a partner package (for example an SDK pinned by a wrapper) |
| Branch, Commit | Follows a branch or a hash | Short experiments only; never ship a branch |
| Local | A folder on disk | Developing the package alongside the app |

## 2. Add a package (Package.swift, for a package or library target)
```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [.iOS(.v15)],
    products: [.library(name: "MyLibrary", targets: ["MyLibrary"])],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"), // up to next major
    ],
    targets: [
        .target(name: "MyLibrary", dependencies: [
            .product(name: "Collections", package: "swift-collections"),
        ]),
        .testTarget(name: "MyLibraryTests", dependencies: ["MyLibrary"]),
    ]
)
```
`swift package resolve` fetches; `swift package show-dependencies` prints the graph **(run)**; `swift package dump-package` prints the parsed manifest as JSON **(run)**.

## 3. Package.resolved: commit it (for apps)
`Package.resolved` records the exact version and commit of every package, direct and indirect. Commit it for **apps** so every machine and CI build gets the same code. Do not commit it for **libraries** (their consumers resolve their own).

Where it lives for an Xcode project:
- With a workspace: `<Name>.xcworkspace/xcshareddata/swiftpm/Package.resolved`
- Without: `<Name>.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`

If both exist and are identical, commit one and ignore the other; do not let them drift. Never edit the file by hand.

## 4. Resolve and update
| Goal | Xcode | Command line |
|---|---|---|
| Fetch what `Package.resolved` says | File, Packages, Resolve Package Versions | `xcodebuild -resolvePackageDependencies -workspace App.xcworkspace -scheme App` |
| Move to the newest versions your rules allow | File, Packages, Update to Latest Package Versions (all packages); right-click one package in the navigator, Update Package (just that one) | Package.swift projects: `swift package update` (one package: `swift package update <name>`). Xcode projects: delete `Package.resolved`, then run the resolve command above; this updates **every** package at once (not run here) |
| Clear a bad cache | File, Packages, Reset Package Caches | see section 6 |

After any update: build, run the tests, then look at the `Package.resolved` diff before you commit. Big jumps (a major version, or many indirect changes) deserve their own commit and their own testing.

## 5. Reproducible CI
Stop CI from silently resolving newer versions than the ones you tested:
```bash
xcodebuild build -workspace App.xcworkspace -scheme App \
  -onlyUsePackageVersionsFromResolvedFile
```
(`-disableAutomaticPackageResolution` is the same idea.) The build fails if `Package.resolved` is out of date, which is what you want. Cache `~/Library/Caches/org.swift.swiftpm` and the cloned-sources folder (`-clonedSourcePackagesDirPath <path>`) between runs to save the download.

## 6. Reset when resolution misbehaves
Try in this order, stopping when it works:
1. Xcode: File, Packages, Reset Package Caches, then Resolve Package Versions.
2. `swift package reset` (Package.swift projects) **(help checked)**.
3. Delete the project's derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData/<Project>-*`.
4. Delete the shared cache: `rm -rf ~/Library/Caches/org.swift.swiftpm`.
5. If a **read-only** build folder blocks deleting binary packages: `chmod -R u+w <folder>` first, then delete.
More cases: `references/TROUBLESHOOTING.md`.

## 7. Periodic update routine (monthly, or per release)
1. Branch: `chore/update-swift-packages`.
2. See what would change without touching anything: `swift package update --dry-run` **(help checked)** for Package.swift projects; for Xcode projects read `Package.resolved` and compare with each package's latest release. Check each package's release notes for breaking changes and deployment-target changes.
3. Update (section 4).
4. Check the minimum iOS/macOS version of every new version against your app's deployment target (a package raising its minimum is the most common reason an update fails).
5. Build every configuration and run the tests. For apps with secrets or per-environment builds, build each environment.
6. Commit the `Package.resolved` change with a message that names the packages and versions. One concern per pull request.
7. Optionally automate reminders: GitHub Dependabot has a `swift` ecosystem. Check its current documentation for whether it supports your layout (Package.swift versus an Xcode project).

Security: prefer packages from the vendor or a maintained organization, pin production dependencies, read what an update changes, and treat a new package (or a changed owner) as a review item. Xcode can check package signatures and fingerprints (`-packageFingerprintPolicy`, `-packageSigningEntityPolicy`).

## 8. Migrating from CocoaPods
1. List each pod and find its SPM package (most large vendors publish one). Keep CocoaPods for any that has none; both can coexist.
2. Add the packages (section 1), matching the versions you had.
3. Remove the pod from the `Podfile` and run `pod install`. When no pods are left: `pod deintegrate`, then delete `Podfile`, `Podfile.lock` and `Pods/`.
4. Remove leftovers: the `Pods` group and `Pods.xcodeproj` reference in the workspace, `[CP]` build phases, and `#include? "Pods/..."` lines in xcconfig files. Open the workspace (or project), not a stale one.
5. Build every configuration. Fix the deployment target if a package needs a higher one.
6. If you had a script that looked for a Pods path (for example a symbol-upload step), point it at `SourcePackages/checkouts/<package>` instead.

## Flutter projects
Flutter generates a local package that pulls together the SPM dependency of each plugin. Do not add Firebase or any plugin's SDK in Xcode yourself. See `references/FLUTTER.md`.
