# Apple Developer account: suspended work

**Status (25 Sept 2026): there is no active Apple Developer Program account.** Everything that needs one is **suspended** and collected here, so that when the account exists it can be done as one separate phase (see "The Apple phase" at the end).

**Rule for every phase:** do not start, attempt or plan around work listed here. If a task needs a paid Apple account (capabilities, signing, App Store Connect, APNs, TestFlight), mark it `SUSPENDED (Apple account)` in the plan and `CHANGE_LOG.md`, add it to this file, and continue with the rest. Add new items here when they turn up.

## What still works without the account
- Swift Package Manager migration, removing CocoaPods, the iOS 15 deployment target, the Crashlytics run script (Phase 3, PR 1).
- `Info.plist` cleanup, background location removal, `PrivacyInfo.xcprivacy`, Google Sign-In configuration, flavor display names (Phase 3, PR 2).
- iOS builds with `--no-codesign`, and running the development flavor on the iOS Simulator (Google sign-in, Email, feed, reports, location with when-in-use permission).
- Installing the **development** flavor on your own iPhone through Xcode with a free personal team (profile expires after 7 days, at most 3 devices and 3 apps). No Push Notifications and no Sign in with Apple on a free account ([Apple's comparison](https://developer.apple.com/support/compare-memberships/)).
- The App Check **debug** provider on simulators and development builds.
- Refreshing the Google OAuth iOS client before the ~17 Oct 2026 deadline: sign in with Google on the iOS Simulator with the production flavor (needs the production files, not an Apple account).
- Everything on Android, the backend, CI and Dependabot.

## Suspended items
| ID | Phase and plan reference | What is suspended | Why it needs the account | Needed when it is unblocked |
|---|---|---|---|---|
| A1 | Prerequisite for all below | Enrolling in the Apple Developer Program | The account itself (individual or organization; organization verification can take a while) | Owner: enrol, add the team to Xcode |
| A2 | Phase 3 item 10, Phase 5 | Registering App IDs `co.civic24.citizen`, `.dev`, `.stg` with the Push Notifications and Sign in with Apple capabilities | Certificates, Identifiers and Profiles portal is paid | Owner: register the three App IDs and enable both capabilities |
| A3 | Phase 3 item 10 (was PR 3) | Entitlements file per flavor: `aps-environment` (development or production) and `com.apple.developer.applesignin`; Push Notifications and Background Modes (remote notifications) capabilities in the Xcode project | Capabilities cannot be signed with a free team; adding them now would also stop the free team from building for a device | Agent: entitlements PR, then verify on a device |
| A4 | Phase 3 item 10, Phase 5, Phase 6 | APNs authentication key (`.p8`) created and uploaded to each Firebase project (`civic24-sdg11`, `civic24test-f9352`) | Key is created in the paid portal | Owner: create the key and upload it in the Firebase console (Project settings, Cloud Messaging) |
| A5 | Phase 5 (Auth providers) | Firebase Auth Apple provider fully configured (Team ID, Key ID, private key) | Needs an Apple key | Owner: create the key, configure the provider |
| A6 | Phase 7 item 5 (account deletion) | Revoking the Sign in with Apple token when a user who signed in with Apple deletes their account (App Review Guideline 5.1.1) | Needs the Apple key from A5 | Agent: revoke in the deletion flow (backend) |
| A7 | Phase 5 journeys | Push notification journeys on iOS: foreground, background, terminated | APNs and a signed build with entitlements (A3, A4) | Agent and owner: test on a physical iPhone |
| A8 | Phase 5 matrix | Every "Apple" sign-in cell (iOS Simulator and iPhone, all flavors), the iPhone cells for **staging and production**, and the production iPhone cell (TestFlight) | Sign in with Apple needs the capability (A2, A3); TestFlight needs the account | Agent and owner: run the cells, record in `CHANGE_LOG.md` |
| A9 | Phase 5 item 5 | Production App Check on iOS with App Attest (capability) and DeviceCheck fallback (private key from the portal) | Both are Apple account features | Owner: DeviceCheck key; agent: App Check setup, then verify |
| A10 | Phase 7 item 2 and 6 | Distribution certificate, provisioning profiles (or fastlane `match`), team configuration, signed IPA | Signing needs the paid team | Owner: certificates and access; agent: signing setup |
| A11 | Phase 7 item 2 | iOS fastlane lane, App Store Connect API key, TestFlight upload (or Codemagic or Xcode Cloud) | App Store Connect | Owner: API key; agent: lane |
| A12 | Phase 7 item 6 | App Store Connect record, metadata, screenshots for all required sizes, privacy "nutrition labels" (from `PrivacyInfo.xcprivacy`), age rating, reviewer demo account in the review notes | App Store Connect | Owner and agent |
| A13 | Phase 7 item 7 | `shorebird release ios` (fresh base release; needs a signed archive). The Android half is not affected | Signing (A10) | Agent, with authorization |
| A14 | Phase 7 item 6, Definition of done | Submission to App Store review; a TestFlight build from CD | App Store Connect | Owner and agent |
| A15 | Phase 9 | iOS delivery of push notifications for the status tracking feature | APNs (A4) | Agent |

## Knock-on effects on the plan
- **Phase 3:** PR 1 and PR 2 go ahead. PR 3 (entitlements and capabilities) is suspended (A3).
- **Phase 5:** the test matrix shrinks. Runnable now: iOS Simulator with Google and Email, iPhone with Google on the development flavor through a free team. Suspended: all Apple cells, iPhone on staging and production, TestFlight (A8), iOS push (A7), production iOS App Check (A9).
- **Phase 6:** nothing else changes, but iOS delivery of notifications cannot be tested end to end (A4).
- **Phase 7:** Android delivery (Play internal track) continues. All iOS delivery, signing, TestFlight, App Store checklist and submission are suspended (A10 to A14).
- **Definition of done** items that cannot be met until then: Sign in with Apple verified on all flavors, a TestFlight build from CD, the App Store checklist complete, submission to App Store review.
- **Google Play** is not affected.

## The Apple phase (to run once the account exists)
1. **A1 and A2:** enrol, register the three App IDs with Push Notifications and Sign in with Apple.
2. **A4 and A5:** create the APNs key and the Sign in with Apple key; upload and configure them in both Firebase projects.
3. **A3:** entitlements and capabilities PR, then run the development flavor on the physical iPhone.
4. **A7 and A8:** push journeys and the Apple sign-in cells, then the remaining matrix cells. Record everything in `CHANGE_LOG.md`.
5. **A9:** DeviceCheck key and App Attest for production, then verify on a device.
6. **A6:** Sign in with Apple token revocation in the account deletion flow.
7. **A10 and A11:** signing, fastlane iOS lane, first TestFlight build.
8. **A12 to A14:** App Store Connect record and metadata, reviewer account, submission.
9. **A13:** fresh Shorebird base release for iOS, with authorization.
10. **A15:** iOS push for the status tracking feature when Phase 9 gets there.

Each step follows the normal rules: one PR per concern, `melos run ci:check`, an honest verification level, and no production changes without explicit authorization.
