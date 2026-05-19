# OneStep iOS SDK — Architecture (V4 surface)

**Status:** Living document. Created alongside the V4 public-API draft in
`OneStepSDK/V2/NEW_API_SURFACE/OneStep.swift`. Read together with
[`IDENTITY_MODEL.md`](../../../IDENTITY_MODEL.md) (root of the repo), which
covers the identity/auth model in detail.

---

## 1. Goals of V4

The V4 surface (`OneStep`) replaces the V2 facade (`OneStep` /
`OneStepProtocol`) as the canonical entry point for host integrations. It
keeps the same internal services and persistence, but rationalises the
public API around three concrete host shapes:

| Path | Host | Entry point |
|---|---|---|
| **A** | Customer patient app (long-running, BG monitoring) | `setPatient(apiKey:customerPatientId:identityVerification:userAttributes:)` |
| **B** | Patient app holding a OneStep patient UUID (cookie session established externally) | `setPatient(authPatientUuid:userAttributes:)` |
| **C** | Clinician app, per-session, no BG monitoring | `setPatient(authPatientUuid:)` or `OneStep.withPatient(_:_:)` |

Design principles:

- **Uniform error type:** every async/authenticated call returns
  `Result<Value, OSTError>`. No `throws`, no `Bool`, no per-feature error
  types. `OSTError` already exists in V2 — we did **not** introduce
  `OSTErrorLatest`.
- **Result over throws** lets host apps switch on outcomes without
  `do/catch` boilerplate and gives us a single place to add new error
  categories.
- **Reuse existing product protocols:** `MotionLab`, `Monitoring`,
  `Insights` are reused as-is. No `InsightsLatest`. No `OSTInsights` stub.
- **Patient lifecycle is re-callable:** calling `setPatient` while already
  authenticated is supported (switches patient, no module nil-ing). Same
  rules as documented in IDENTITY_MODEL.md §10.
- **`clearPatient` ≠ `logout`:** `clearPatient` drops the patient context
  in-memory (clinician switching patients); `logout` is the full sign-out
  contract (network disconnect, Keychain wipe, DB purge, scheduler
  teardown).

---

## 2. Layered architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                       Host app                                   │
│   AppDelegate / SwiftUI app — calls OneStep at launch          │
└────────────┬─────────────────────────────────────────────────────┘
             │ public API
             ▼
┌──────────────────────────────────────────────────────────────────┐
│                       OneStep (facade)                         │
│   • initialize / shared / withPatient / registerBGTasks          │
│   • setPatient(A) / setPatient(B/C) / clearPatient / logout      │
│   • setAgent / updateUserAttributes / sync / push / handle       │
│   • version / inAppPermissionsRequired / isBackgroundActive      │
│   • motionLab() / monitoring() / insights()                      │
│   • authStatePublisher / events                                  │
└────────┬──────────┬────────────┬────────────┬───────────────────┘
         │          │            │            │
         ▼          ▼            ▼            ▼
   ┌─────────┐ ┌─────────┐ ┌─────────────┐ ┌──────────────┐
   │MotionLab│ │Monitoring│ │  Insights   │ │ Cross-cutting│
   │ Service │ │ Service  │ │  Service    │ │  helpers     │
   └────┬────┘ └────┬─────┘ └─────┬───────┘ │              │
        │           │             │         │ SyncManager  │
        │           │             │         │ Scheduler    │
        ▼           ▼             ▼         │ Logger       │
   ┌──────────────────────────────────────┐ │ SessionMgr   │
   │     V1 internal infrastructure       │ │ Credentials  │
   │ • OSTRecorder / SensorsReader        │ │ KeychainMgr  │
   │ • SDKBackgroundEngine                │ │              │
   │ • SDKPersistencyLayer (Core Data)    │ └──────────────┘
   │ • SDKNetworkService / NetworkClient  │
   │ • SDKMotionDataProvider              │
   └──────────────────────────────────────┘
```

The V4 facade does **not** introduce new domain logic — it composes the
existing services. Anything you can reach via `OneStep.shared` today is
reachable via `OneStep` after the migration.

---

## 3. Module responsibilities

| Module | Purpose | Key types |
|---|---|---|
| **MotionLab** | In-app, gyroscope-required gait recordings. Used by patient and clinician apps for assessments. | `MotionLab` protocol, `MotionLabService`, `OSTRecorder`, `OSTMotionMeasurement`, `MotionLabConfig` |
| **Monitoring** | Continuous background motion sensing. Aggregates daily walks, step bouts. Wakes via BGTaskScheduler / location triggers. | `Monitoring` protocol, `MonitoringService`, `MonitoringConfig`, `MonitoringRuntimeState`, `MonitoringPreference`, `OSTDailyAggregatedBackgroundRecord`, `StepBouts` |
| **Insights** | Clinical interpretation: parameter metadata, normative comparisons, trends, fall risk, reports. No gyroscope needed. | `Insights` protocol, `InsightsService`, `OSTMotionDataService`, `TrendAnalysis`, `FallRiskAssessment`, `ClinicalReport` |

Each module is lazily initialised under `moduleLock` and nil'd on
`logout()` (and `clearPatient()`) so the next authenticated session gets a
fresh service instance that re-reads persisted state.

---

## 4. Identity and auth state

Authoritative reference: [`IDENTITY_MODEL.md`](../../../IDENTITY_MODEL.md).

Quick summary of how V4 surfaces identity:

- `authStatePublisher` is the single source of truth. States:
  - `.unauthenticated(cause: OSTError?)`
  - `.authenticated(OSTPatientId)`
  - `.lost(OSTError)`
- `OSTPatientId` always carries the **OneStep-internal patient UUID**, not
  the customer's id. Path A writes `.userId` on `/connect`; Path B/C
  writes `.clinicianPatientUUID` directly (host-supplied UUID).
- On `.OSTSessionExpired` (401 from the network layer), V4 calls
  `onAuthLost(.sessionExpired)` and then `logout()`. Hosts get a single
  callback to surface the error; the SDK takes care of state cleanup.

---

## 5. Persistence layout

(Authoritative table for each item is in IDENTITY_MODEL.md §3–§4.)

| Store | Items | Lifetime |
|---|---|---|
| **Keychain** | `.apiKey`, `.userId`, `.deviceId`, `.customerDistinctId`, `.clinicianPatientUUID`, `.ddApiKey` | Across reinstalls. Cleared on fresh-install detection (no `installationUUID` in UserDefaults) and on `logout()`. |
| **UserDefaults** | `wasConnectedLately`, `installationUUID`, `firstSeenDate`, `lastKnownSDKVersionCode`, `lastModifiedDateInApp`, `monitoringPreferenceV2`, `firebaseToken`, feature flags (`terminateBGRecording`, `terminateNetworkTraffic`, `remoteTroubleshootingMode`) | Wiped on reinstall by iOS. V4 logout only clears auth-relevant keys; non-auth keys (installation metadata, monitoring prefs scoped per device) are preserved. |
| **Core Data** (`SDKPersistencyLayer`) | Motion measurements, daily background walks, BG samples | Wiped on `logout()`. |
| **`HTTPCookieStorage.shared`** | Session cookies set by `/connect` (Path A) or by an external auth flow (Paths B/C) | Not cleared by SDK — let them expire / be overwritten. |

Path B/C reuses the existing `.clinicianPatientUUID` Keychain key for the
host-supplied patient UUID — it matches the semantic exactly (host
provides UUID, no `/connect` call) and avoids introducing a parallel key.

---

## 6. Background work

`BGTaskScheduler` requires task identifiers to be registered **before**
`application(_:didFinishLaunchingWithOptions:)` returns. Hosts must
therefore call:

```swift
OneStep.registerBGTasks()                           // synchronous
OneStep.initialize(onAuthLost: …, configuration: …) // before any setPatient
```

`registerBGTasks` is a static method on V4 that forwards to
`SDKBackgroundSchedulerService.registerTasks()`. Calling it after
`didFinishLaunching` has no effect — that is an Apple constraint, not an
SDK choice.

After a successful `setPatient`, V4's `performPostAuthenticationSetup`
runs:

1. Enable location updates (unless `avoidEnablingLocationServices` is
   set in `OSTConfiguration.additionalConfigurations`).
2. Fetch feature flags via `SDKNetworkService.getFeatures()`.
3. `SDKBackgroundSchedulerService.scheduleTasks()` (schedule actual
   background work).
4. Trigger initial `syncManager.syncAll(force: false)`.

Monitoring auto-activation runs on `UIApplication.willEnterForeground` and
`didEnterBackground` — if the user previously opted in and now has the
required permissions, `MonitoringService.optIn()` is called.

---

## 7. V4 → internal mapping (reference table)

| V4 public method | Internal services it composes |
|---|---|
| `OneStep.initialize` | `performSecurityMigration` → `registerLifecycleObservers` → register `OSTSessionExpired` observer → `performCommonInitialization` → `performSilentRestoreInitialization` |
| `OneStep.registerBGTasks` (static) | `SDKBackgroundSchedulerService.registerTasks()` |
| `setPatient(apiKey:customerPatientId:identityVerification:userAttributes:)` (Path A) | Session-reuse check → `SDKNetworkService.connect(SDKConnectUserRequest)` → `SDKCredentialsManager.storeCredentials` → `OSTKeychainManager.store` (apiKey, customerDistinctId) → `SDKUserDefaultsManager.setBool(wasConnectedLately)` → `applyUserAttributes` → `bindModules` → `MonitoringService.performEnrollmentOnSilentRestore` → `performPostAuthenticationSetup` |
| `setPatient(authPatientUuid:userAttributes:)` (Path B/C) | Same-UUID short-circuit → `OSTKeychainManager.store(.clinicianPatientUUID)` → `wasConnectedLately = true` → `applyUserAttributes` → `bindModules` → `performPostAuthenticationSetup` |
| `clearPatient()` | nil modules → state `.unauthenticated` |
| `logout()` | `Monitoring.optOut()` → state `.unauthenticated` → `wasConnectedLately = false` → `SDKNetworkClient.setPendingDisconnect` → `SDKNetworkService.disconnect()` → `OSTKeychainManager.clearAll()` → `SDKPersistencyLayer.deleteAll*` → `Scheduler.unscheduleTasks` → nil modules |
| `setAgent(agentUuid:)` | `OSTKeychainManager.store(.deviceId)` |
| `updateUserAttributes(_:)` | `PatientProfileDTO.from(...)` → `SDKNetworkService.updatePatientProfile` → `CachedUserProfile.*` |
| `sync()` | `DefaultSyncManager.syncAll(force: true)` |
| `updatePushToken(_:)` | `SDKUserDefaultsManager.setData(.firebaseToken)` + `SDKNetworkService.heartBeat` |
| `handleNotification(payload:)` | `SDKNetworkService.heartBeat(origin: "SilentPushV4")` |
| `version()` | `SDKDeviceUtils.getCurrentVersionName()` |
| `inAppPermissionsRequired()` | `SDKBackgroundEngine.sharedInstance.inAppPermissionsAuthorized()` (negated) + `avoidEnablingLocationServices` gate |
| `isBackgroundMonitoringActive()` | `Monitoring.runtimeState.isActive` |
| `motionLab()` | lazy `MotionLabService` |
| `monitoring()` | lazy `MonitoringService` |
| `insights()` | lazy `InsightsService` |

---

## 8. Coexistence with V2 facade

The released V2 `OneStep` class remains in the build. V4 is additive — it
declares its own facade and its own per-V4 types (`OSTPatientId`,
`OSTAuthState`, `OSTPatientScope`) but reuses every shared model
(`OSTError`, `OSTUserAttributes`, `OSTConfiguration`, `OSTEvent`,
`MotionLab` / `Monitoring` / `Insights` protocols, all DTOs and Core
Data entities).

During the transition both facades touch the same Keychain / UserDefaults
/ Core Data backing store. Don't run them simultaneously in the same
process — they share `SDKBackgroundSchedulerService` and lifecycle
observers. Pick one per host build.

When V4 ships, `OneStep.swift` / `OneStepProtocol.swift` will be removed
along with their tests and mocks. Until then, treat V4 as the design
target and `OneStep` as the maintenance baseline.

---

## 9. Open items / follow-ups

| # | Item | Notes |
|---|---|---|
| FU-1 | `OSTError.userInitiated` for explicit logout | Per IDENTITY_MODEL.md §9 — V4 currently emits `cause: nil` on logout, same compromise as V2. |
| FU-2 | Expose `MonitoringService.currentPreference` / `performEnrollmentOnSilentRestore` via the `Monitoring` protocol | V4 currently downcasts `_monitoring as? MonitoringService` in `autoActivateBackgroundMonitoringIfNeeded` and silent restore — same pattern as V2, but worth promoting. |
| FU-3 | Patient-scoped insights / motionLab in `OSTPatientScope` | Today the scope returns fresh `InsightsService` / `MotionLabService` instances; the patient pinning is convention rather than enforced. If clinician apps grow scoped queries, the services may need an explicit `for: OSTPatientId` parameter on their methods. |
| FU-4 | Remove `OneStepImpl.swift` / `OneStepNEW.swift` once V4 stabilises | Currently kept as commented references inside `NEW_API_SURFACE/`. |
| FU-5 | `OSTPatientScope` is currently non-Sendable | It owns reference-type services; revisit if we expose it across actor boundaries. |

---

## 10. Where to look next

- **Authentication / identity:** [`IDENTITY_MODEL.md`](../../../IDENTITY_MODEL.md)
- **Released V2 facade (maintenance reference):** `OneStepSDK/V2/OneStep.swift`,
  `OneStepSDK/V2/OneStepProtocol.swift`
- **V4 facade source:** `OneStepSDK/V2/NEW_API_SURFACE/OneStep.swift`
- **Module protocols:** `OneStepSDK/V2/MotionLab/MotionLab.swift`,
  `OneStepSDK/V2/Monitoring/Monitoring.swift`,
  `OneStepSDK/V2/Insights/Insights.swift`
- **Network entry points:** `OneStepSDK/Network/SDKNetworkService.swift`
  (`connect`, `disconnect`, `heartBeat`, `getFeatures`,
  `updatePatientProfile`)
- **Persistence:** `OneStepSDK/Persistence/SDKPersistencyLayer.swift`
- **Background tasks:** `OneStepSDK/Backgrounding/SDKBackgroundSchedulerService.swift`,
  `OneStepSDK/Backgrounding/SDKBackgroundEngine.swift`
