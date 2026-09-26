# SPM troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| "Failed to resolve dependencies" or "dependency graph is unresolvable" | Two packages need incompatible versions of a third | Read which packages conflict; align them (upgrade together) or use an Exact rule the whole graph accepts |
| Resolution hangs or fails after an interruption | Corrupt cache | Reset Package Caches, then delete `~/Library/Caches/org.swift.swiftpm` and the project's derived data |
| "No space left on device" or "database or disk is full" during resolve | Disk full; SPM caches and derived data are large | Free space (derived data, old simulators), then resolve again |
| Cannot delete `SourcePackages` | Binary packages are read-only | `chmod -R u+w <folder>` then delete |
| "Package.resolved file is corrupted or malformed" | Hand edit or merge conflict | Delete it, resolve again, review the diff |
| Build says a package needs a higher iOS version | Deployment target lower than the package's minimum | Raise the target (and check your supported devices) or pin an older package version |
| "Missing package product" | Package not resolved, or product not linked to the target | Resolve; add the product under Frameworks, Libraries and Embedded Content |
| Works locally, fails in CI | CI resolves different versions, or has no network to the Git host | Use `-onlyUsePackageVersionsFromResolvedFile`, commit `Package.resolved`, cache the sources |
| Merge conflict in `Package.resolved` | Two branches changed pins | Take one side, resolve, review the diff; do not merge by hand |
| Symlink or path errors in a generated package | Generated folder is stale | Regenerate it (for Flutter: `flutter clean`, `flutter pub get`, build) |
| "checksum ... does not match" for a binary target | Many SDKs (Firebase, gRPC) ship as `binaryTarget` XCFrameworks with a published checksum. A mismatch means a corrupted download or cache, or a tampered artifact | Reset the caches and resolve again. If it persists, do not skip the check: confirm the package version and URL are the vendor's, then report it upstream |

Binary targets are large (Firebase alone is several hundred MB) and their extracted folders are read-only, which is why deleting a build's `SourcePackages` can fail until you `chmod -R u+w` it.
