## OneStep iOS SDK 2.0
###### Release Date: 2025-04-13

### ⚠️ Breaking Changes

This is a **major version** with a completely redesigned public API. Migration from SDK 1.7.x is required.

* **Primary entry point changed**: `OSTSDKCore.shared` → `OneStep.shared`
* **Initialization changed**: The combined `initialize(appId:apiKey:distinctId:...) { }` is replaced by:
  1. `OneStep.shared.initialize(clientToken:configuration:)` — called at app launch
  2. `await OneStep.shared.identify(_:_:)` or `await OneStep.shared.connectAsUser(_:_:configuration:)` — called after user login
* **API is now organized into sub-protocols** accessed as properties on `OneStep.shared`:
  - `motionLab` (`MotionLab`) — supervised/on-demand motion recording and measurement management
  - `monitoring` (`Monitoring`) — passive background monitoring and step bouts
  - `insights` (`Insights`) — AI gait analysis, trend analysis, fall risk, and clinical reports
* **Recording access changed**: `getRecordingService()` → `motionLab.recorder`
* **Measurement queries changed**: synchronous `readMotionMeasurements(startTime:endTime:)` → `try motionLab.getMeasurements(request:)` / `try await motionLab.getMeasurement(id:)`
* **Background monitoring changed**: `registerBackgroundMonitoring()` → `monitoring.optIn()` + `monitoring.enable(config:)`; `unregisterBackgroundMonitoring()` → `monitoring.optOut()`
* **Other renames**:
  - `disconnect()` → `logout()`
  - `updateUserAttributes(userAttributes:)` → `updateUserAttributes(_:)`
  - `setDeviceToken(token:)` → `updatePushToken(_:)`
  - `handlePushNotification(data:)` → `handleNotification(_:)` (now returns `Bool`)
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
