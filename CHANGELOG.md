## OneStep iOS SDK 2.0.12
###### Release Date: 2026-07-12

### 🐛 Bug Fixes & Reliability

* **Accurate recording duration**: a completed recording's duration is now rounded to the nearest second instead of being rounded down, so a full 30-second recording is reported as 30s (previously 29s) in summaries and stored data.

---

## OneStep iOS SDK 2.0.11
###### Release Date: 2026-07-08

### 🐛 Bug Fixes & Reliability

* **Thread-safety hardening**: reworked the internal locking around recording and shared state to remove data races under concurrent access.

---

## OneStep iOS SDK 2.0.10
###### Release Date: 2026-07-01

### 🛠️ Distribution Changes

* **Maintenance release**: version alignment with OneStepUIKit 2.0.10. No functional SDK changes.

---

## OneStep iOS SDK 2.0.9
###### Release Date: 2026-06-28

### 🪄 New Features

* **Static Balance Test**: added the `static_balance_test` activity type.
* **Configurable log ingestion**: host apps can opt out of SDK log ingestion via a feature flag and set their own logging identity.

### 🐛 Bug Fixes & Reliability

* **Host-app stability**: removed internal crash-inducing trap sites so SDK errors no longer bring down the host app.
* **Recording resilience**: measurements stay alive when the app is backgrounded or the device locks mid-recording, and truncated/incomplete recordings are discarded rather than saved.
* **Offline self-report**: STS rep-count and TUG duration edits made while offline are queued and synced automatically on reconnect.

---

## OneStep iOS SDK 2.0.8
###### Release Date: 2026-06-23

### 🐛 Bug Fixes & Reliability

* **Correct API base URL**: the default API host is restored to `app.onestep.co`, fixing failed requests for patient and App Clip consumers; expired-session (401) recovery is now non-destructive.
* **Offline recording resilience**: recordings survive a mid-session loss of connectivity — the measurement is kept alive, reported as saved-pending-sync, and reconciled into the local store once uploaded and analyzed.
* **Recording lifecycle**: a recording now finishes before it is persisted, and stale auto-stop timers are re-armed correctly.
* **Quieter offline logging**: expected read-back misses and connectivity-related upload retries no longer emit noisy error logs.

### 🔧 API Adjustments

* **Self-report scoping**: the self-report endpoint (STS reps / TUG duration) is now correctly scoped to the target patient.

---

## OneStep iOS SDK 2.0.6
###### Release Date: 2026-06-11

### 🐛 Bug Fixes & Reliability

* **Recording start/stop hardening**: a new recording now serializes behind the previous stop's cleanup, and stale auto-stop timers are invalidated — preventing a start from racing a still-finishing stop.
* **Wire datetime format**: server-bound datetimes are emitted as naive UTC (no trailing `Z`), matching backend expectations.
* **Offline & localization fixes**: quieter offline logging, and correct date formatting on Arabic-locale devices.
* **Norms with partial surgery context**: `getNorms` now sends surgery context when only the surgery type is known.

### 🔒 Privacy

* **Profile data moved to the Keychain**: patient names are no longer persisted on device, and the remaining personal profile fields are write-only and stored in the Keychain.

### 📚 Documentation

* **Published API documentation**: a DocC documentation site now covers the SDK's public API surface.

---

## OneStep iOS SDK 2.0.5
###### Release Date: 2026-06-08

### 🪄 New Features

* **`motionLab.fetchMeasurement(id:)`**: fetch a single measurement from the server and upsert it into the local store by UUID.
* **Multi-patient clinician support**: `withPatient` and `setPatient(authPatientUuid:)` are now public, and `OSTPatientScope` is `Sendable`.
* **Profile metadata APIs**: `getUserAttributes` and `updateCustomMetadata` are now exposed on the facade and the patient scope.
* **Clinician self-report APIs**: STS / TUG self-report endpoints, with patient-scoped recorder identity.
* **Swift 6 strict-concurrency host support**: `@MainActor` setup and a `Sendable` facade — the SDK builds cleanly for hosts using Swift 6 strict concurrency.

### 🐛 Bug Fixes & Reliability

* **Background-sync overhaul**: actor-based sync coordination, a HealthKit step-count wake source, watchdog-stopped background recordings, a single upload path, and cancellation-aware background tasks for more reliable background capture.
* **Memory & stability fix** for background-sample processing (ported from the 1.6.7 hotfix line).
* **Bounded in-app foreground data flow**: metadata-only reads and more efficient upserts.
* **Background recordings capture walks, not arbitrary motion** (walk gate on by default).

---

## OneStep iOS SDK 2.0.3
###### Release Date: 2026-05-24

### 🪄 New Features

* **Patient administration API** (`PatientAdmin`): new sub-protocol accessed as `OneStep.shared.patientAdmin`, providing patient lifecycle operations for clinician-facing integrations. See `OSTPatientAdmin` for the full surface.
* **Session expiry handling**: SDK now logs the user out automatically when a backend call returns HTTP 401, surfacing a clean unauthenticated state instead of silently retrying.

### 🛠️ Distribution Changes

* **Product renamed**: `OneStepSDKiOS` → `OneStepSDK`. Update your `.product(name: "OneStepSDKiOS", package: "onestep-sdk-ios")` reference to `.product(name: "OneStepSDK", package: "onestep-sdk-ios")`. The `import OneStepSDK` statement is unchanged.
* **Framework now downloaded on resolve**: `Package.swift` switched to a URL-based `binaryTarget`. SwiftPM downloads `OneStepSDK.xcframework.zip` from the GitHub Release on first resolve and verifies it via SHA-256 checksum.

---

## OneStep iOS SDK 2.0.2
###### Release Date: 2026-05-11

### 🔧 API Adjustments

* **Removed `enhancedMode` from the public recording API**: `MotionLab.recorder.startRecording(...)` no longer accepts an `enhancedMode` parameter. Enhanced-mode behavior is now controlled internally based on `MotionLabConfig`. Consumers should remove any `enhancedMode:` arguments from their call sites.

### 📚 Documentation

* Migration guides V1 → V2 published.

---

## OneStep iOS SDK 2.0.1
###### Release Date: 2026-05-11

### 🐛 Bug Fixes

* **Walking-bout duration truncation**: fixed an integer truncation in HealthKit step-bout ingestion that caused `duration_ms` values to be rounded to whole seconds. Bouts are now reported with full millisecond precision, and instantaneous (zero-duration) samples are skipped.
* **History tab sync**: cleared the cached last-modified date on identify so the history view re-syncs measurements from the server on first launch after sign-in, instead of showing stale local-only data.

### 🔧 API Adjustments

* `isIdentified` now returns `false` (rather than throwing) when the SDK is not in an identified state, matching the documented contract.

---

## OneStep iOS SDK 2.0
###### Release Date: 2025-04-13

### ⚠️ Breaking Changes

This is a **major version** with a completely redesigned public API. Migration from SDK 1.7.x is required.

* **Primary entry point changed**: `OSTSDKCore.shared` (property) → `OneStep.shared()` (static method returning `Result<OneStep, OSTError>`)
* **Initialization changed**: The combined `initialize(appId:apiKey:distinctId:...) { }` is replaced by:
  1. `OneStep.initialize(onAuthLost:configuration:)` — **static**, called at app launch, no credentials
  2. `await sdk.setPatient(apiKey:customerPatientId:identityVerification:)` — called after user login (Path A); or `await sdk.setPatient(authPatientUuid:)` for Paths B/C
* **`registerBGTasks()` is now static**: `OneStep.registerBGTasks()` (was an instance method on `OSTSDKCore.shared`)
* **API is now organized into sub-protocols** accessed as **methods** (not properties) returning `Result`:
  - `sdk.motionLab() -> Result<MotionLab, OSTError>` — supervised/on-demand motion recording and measurement management
  - `sdk.monitoring() -> Result<Monitoring, OSTError>` — passive background monitoring and step bouts
  - `sdk.insights() -> Result<Insights, OSTError>` — AI gait analysis, trend analysis, fall risk, and clinical reports
* **Recording access changed**: `getRecordingService()` → `try? sdk.motionLab().get()` → `motionLab.recorder`
* **Measurement queries are synchronous**: `readMotionMeasurements(startTime:endTime:)` → `try motionLab.getMeasurements(request:)`; `readMotionMeasurementById(uuid:)` → `try motionLab.getMeasurement(id:)` (synchronous `throws`, not `async throws`)
* **Background monitoring changed**: `registerBackgroundMonitoring()` → `monitoring.optIn()` + `monitoring.enable(config:)`; `unregisterBackgroundMonitoring()` → `monitoring.optOut()`
* **Auth state changed**: `state` / `statePublisher` with `OneStepState` → `authStateValue` / `authStatePublisher` with `OSTIdentificationState` (`.unidentified`, `.identified(OSTPatientId)`, `.lost(OSTError)`)
* **`logout()` is now async**: returns `Result<Void, OSTError>`
* **`sync()` is now async**: returns `Result<Void, OSTError>`
* **Other renames**:
  - `disconnect()` → `await sdk.logout()`
  - `updateUserAttributes(userAttributes:)` → `await sdk.getPatientAdmin().updateUserAttributes(_:)` (preferred)
  - `setDeviceToken(token:)` → `sdk.updatePushToken(_:)`
  - `handlePushNotification(data:)` → `sdk.handleNotification(_:)` (now returns `Bool`)
  - `deleteMotionMeasurement(by:)` → `await motionLab.deleteMeasurement(id:)`
  - `updateMotionMeasurement(uuid:userInputMetaData:)` → `await motionLab.updateMeasurement(id:userInputMetadata:)`
  - `dailyAggregatedBackgroundWalks(startTime:endTime:)` moved to `monitoring`
  - `getMotionDataService()` moved to `insights`

### 🪄 New Features

* **`Insights` protocol**: trend analysis (`analyzeTrend(for:from:to:)`), fall risk assessment (`assessFallRisk(measurements:)`), and clinical report generation (`generateClinicalReport(measurementIds:includeComparisons:)`)
* **`StepBouts` protocol**: per-bout gait data (cadence, speed, step length, stride length, variability, quality score) with aggregated `StepStatistics` and daily step counts
* **`MonitoringDailySummary`**: richer daily aggregate including gait variability, gait quality score, active/sedentary minutes, hourly step distribution, and baseline comparison
* **`MotionLabConfig`** with built-in presets: `.default`, `.highQuality`, `.fast`, `.research`, `.noGyroscope`
* **`MonitoringConfig`** with built-in presets: `.default`, `.highFrequency`, `.lowFrequency`, `.privacyFocused`, `.research`; new `enrollmentPolicy` property (`.autoEnrollAfterAuth` / `.explicitOptInRequired`)
* **`DeviceCapabilities`**: runtime sensor capability check via `motionLab.checkDeviceCapabilities()`
* **`OSTAnalyserState`**: granular upload/analysis pipeline state (`uploading → queued → analyzing(stage:) → completed → error`)
* **`AnalysisStage`**: six analysis pipeline stages (`preprocessing`, `eventDetection`, `temporalAnalysis`, `spatialAnalysis`, `clinicalScoring`, `finalization`), each with a `progress` and `displayName`
* **`OSTResult<T>`**: type-safe success/failure result wrapper
* **`DailySummariesQuery`**: filterable and sortable query builder for daily summaries, with convenience factories (`.lastDays(_:)`, `.thisWeek()`, `.thisMonth()`, `.highActivityDays(in:)`)
* **`OSTMockIMU`**: inject raw IMU sensor arrays for offline and simulation testing
* **Full mock layer** for unit testing: `MockOneStep`, `MockMotionLab`, `MockMonitoring`, `MockInsights`, `MockStepBouts`
* **`MonitoringBlocker`**: exhaustive set of reasons monitoring may be blocked, each with `displayDescription`, `actionSuggestion`, and `isUserResolvable`
* **`OSTNotificationConfig`**: fine-grained control over which SDK events trigger push notifications
* **`OSTLevelOfAssistance`** and **`OSTAssistiveDevice`** now used in `OSTUserInputMetaData` for richer clinical context
* **`OSTKeychainManager`** keychain key `appId` renamed to `apiKey` (internal)
* **`NSNotification.Name.OSTSessionExpired`**: posted when the user's server session expires

### 🪄 Activity Types Added

* `.twoMinWalk` — Two-Minute Walk Test (2MWT)
* `.stairs` — Stair climbing

---

## OneStep iOS SDK 1.7.1
###### Release Date: 2025-03-04

### 🪄 Enhancements and fixes
* Additional initialization log output for diagnostics

---

## OneStep iOS SDK 1.7.0
###### Release Date: 2025-03-01

### 🪄 New Features
* Two-Minute Walk Test (2MWT) activity type
* Long Walk / extended walking session support

---

## OneStep iOS SDK 1.2.0-rc
###### Release Date: 2025-02-13

### ⚠️ SDK interface changes
* **HealthKit Capability:** The HealthKit capability must be enabled. It is recommended to request authorization for at least step count to ensure compatibility with OneStep features.
* **Background Tasks:** To enable background data sync, add the **"Background Fetch"** execution mode and register `"co.onestep.bgsync"` under **BGTaskSchedulerPermittedIdentifiers** in your app's `Info.plist`.

### 🪄 Enhancements and fixes
* Data is now synced in the background (under certain constraints), reducing delays caused by waiting for the next app launch.
* HealthKit Integration: for daily step counter, walking bouts (experimental), and daily mobility parameters.
* Data sync strategy and background monitoring intensity are now configurable.

---

## OneStep iOS SDK 1.1.0
###### Release Date: 2024-10-08

### ⚠️ SDK interface changes
* SDK initialization changed from async function to a regular function with completion handler
* `OSTMotionMeasurement` — some integer values changed to enums for clearer code
* `ReadMotionMeasurements` — added the ability to specify time scope via `startTime` and `endTime` parameters
* Moved to use UUIDs in all interface functions

### 🪄 Enhancements and fixes
* Fixed foreground recording possible start issue when a background recording is in progress
* Prevent possible sync parallel execution

---

## OneStep iOS SDK 1.0.0
###### Release Date: 2024-08-29

* Initial release
