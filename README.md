# [OneStep](https://www.onestep.co/) Collect SDK for iOS

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://github.com/OneStepRND/onestep-sdk-ios)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/OneStepRND/onestep-sdk-ios)
[![Version](https://img.shields.io/badge/version-2.0.3-blue.svg)](https://github.com/OneStepRND/onestep-sdk-ios/releases)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-green.svg)](https://github.com/OneStepRND/onestep-sdk-ios)
![Commercial License](https://img.shields.io/badge/license-Commercial-green.svg)

## Table of Contents
1. [Introduction](#introduction)
2. [What's New in SDK 2.0](#whats-new-in-sdk-20)
3. [Features](#features)
4. [Requirements](#requirements)
5. [Before You Begin](#before-you-begin)
6. [Getting Started](#getting-started)
7. [Installation](#installation)
8. [Permissions & Background Modes](#permissions--background-modes)
9. [API Reference](#api-reference)
10. [Documentation](#documentation)
11. [Support](#support)

## Introduction
The OneStep Collect SDK is a comprehensive solution for integrating advanced motion analysis capabilities into your iOS applications. It enables real-time data collection, gait analysis, background passive monitoring, and AI-powered clinical insights.

> **SDK 2.0 is a breaking change** from all prior versions. The primary entry point has changed from `OSTSDKCore` to `OneStep` (initialized via static methods). See [Migration Guide](#migration-from-sdk-17x) below.

## What's New in SDK 2.0

### Breaking Changes
- **New entry point**: `OneStep` replaces `OSTSDKCore`. `OneStep.shared` is now a **static method** returning `Result<OneStep, OSTError>` (not a property). The SDK instance must be resolved once and cached.
- **New initialization**: `OneStep.initialize(onAuthLost:configuration:)` is **static** and replaces the old `initialize(appId:apiKey:distinctId:...)`. Credentials are no longer passed at init time.
- **New auth**: `await sdk.setPatient(apiKey:customerPatientId:identityVerification:)` (Path A) and `await sdk.setPatient(authPatientUuid:)` (Paths B/C) replace `identify(_:_:)` and `connectAsUser(_:_:)`.
- **New module system**: The three sub-systems are accessed as **methods** returning `Result`:
  - `sdk.motionLab() -> Result<MotionLab, OSTError>` — supervised/on-demand motion recording
  - `sdk.monitoring() -> Result<Monitoring, OSTError>` — passive background monitoring
  - `sdk.insights() -> Result<Insights, OSTError>` — gait analysis and clinical data
- **Static `registerBGTasks()`**: `OneStep.registerBGTasks()` is now a static method (was an instance method).
- **Background monitoring API**: `monitoring.enable(config:)` + `monitoring.optIn()` replace `registerBackgroundMonitoring()`
- **Auth state**: `sdk.authStateValue` / `sdk.authStatePublisher` emit `OSTIdentificationState` (`.unidentified`, `.identified(OSTPatientId)`, `.lost(OSTError)`). The old `state`/`statePublisher` with `OneStepState` is removed.
- **`logout()` is now async**: returns `Result<Void, OSTError>`
- **`sync()` is now async**: returns `Result<Void, OSTError>`
- **`getMeasurements` / `getMeasurement` are synchronous** (`throws`, not `async throws`)
- **User attributes**: Preferred path is `sdk.getPatientAdmin().updateUserAttributes(_:)` (async)

### New Features
- `Insights` protocol: trend analysis, fall-risk assessment, clinical report generation
- `StepBouts` protocol: per-bout step and gait data with statistics
- `MonitoringDailySummary`: richer daily aggregate with gait quality, active/sedentary minutes, and hourly step distribution
- `MotionLabConfig` presets: `.default`, `.highQuality`, `.fast`, `.research`, `.noGyroscope`
- `MonitoringConfig` presets: `.default`, `.highFrequency`, `.lowFrequency`, `.privacyFocused`, `.research`
- `DeviceCapabilities`: runtime check for gyroscope and sensor support
- `OSTAnalyserState`: granular upload/analysis pipeline state (uploading → queued → analyzing → completed)
- `MockOneStep`, `MockMotionLab`, `MockMonitoring`, `MockInsights`, `MockStepBouts`: full mock layer for unit testing
- `DailySummariesQuery`: filterable, sortable query API for daily summaries
- `OSTMockIMU`: inject raw IMU data for offline/simulation testing

---

## Features

### 1. Real-time Motion Analysis
Capture and analyze gait using the device's accelerometer and gyroscope. Supports walk, TUG, STS, 2MWT, 6MWT, ROM, stairs, and dual-task walk.

### 2. Background Passive Monitoring
Continuously collect and analyze step bouts and daily aggregates, even when the app is in the background.

### 3. OneStep AI Motion Engine
Leverage norms, parameter metadata, insights, and clinical comparisons to deliver actionable results.

### 4. Customizable UI Components
Integrate OneStep's [pre-built UI components](https://github.com/OneStepRND/onestep-uikit-ios-spm) into your app.

### 5. Clinical Insights & Trend Analysis
Generate clinical reports, assess fall risk, and track gait parameter trends over time via the `Insights` protocol.

### 6. HealthKit Integration
Pair Apple's 24/7 activity tracking with OneStep's deep gait analysis for complete mobility coverage.

---

## Requirements
- iOS 16 or later
- Xcode 16 or later
- **HealthKit** capability (recommended)
- **Background Execution** modes for passive background monitoring

---

## Before You Begin

### Obtaining Your Credentials
You will need an **API key** from OneStep. Contact your OneStep account manager or visit the OneStep back-office under **Developers > Settings**.

---

## Getting Started

### 1. Explore the Sample Apps
- [OneStep UIKit pre-built UI/UX components](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/OneStepUIKitExample)
- [Background Monitoring](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/BackgroundSampleApp)
- [Build your own recording flow & Motion Insights](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/OneStepSDK_SampleApp)

### 2. Initialize the SDK

SDK initialization is **static**. Call it at app launch, before any other SDK usage. The SDK instance must then be resolved from `OneStep.shared()` and cached — the recommended pattern is to hold `sdk`, `motionLab`, and `monitoring` as optional properties on your SDK wrapper class.

```swift
import OneStepSDK

// AppDelegate / @main App struct

// Step 1: Register background tasks (must be before app finishes launching)
OneStep.registerBGTasks()

// Step 2: Boot the SDK (static; safe to call on every launch)
OneStep.initialize(
    onAuthLost: { [weak self] error in
        // Called when the server session is lost — prompt user to log in again
    },
    configuration: OSTConfiguration()
)

// Step 3: Resolve and cache the SDK instance
guard case .success(let sdk) = OneStep.shared() else { return }
self.sdk = sdk
```

> **Important:** `OneStep.shared()` is a static **method** returning `Result<OneStep, OSTError>`, not a property. Resolve it once, store the result, and `guard let` from the cached reference on all subsequent calls.

### 3. Identify a User

After the user logs in, identify them so data is attributed correctly. Check for **silent restore** first — if credentials are already stored in the Keychain from a previous session, `authStateValue` will already be `.identified` and you can skip the `setPatient` call:

```swift
guard case .success(let sdk) = OneStep.shared() else { return }

// Check for silent restore (credentials already in Keychain)
if case .identified = sdk.authStateValue {
    // Already identified — resolve module references and continue
    self.motionLab = try? sdk.motionLab().get()
    self.monitoring = try? sdk.monitoring().get()
    return
}

// Path A: Customer-managed patient ID (most common)
let result = await sdk.setPatient(
    apiKey: "<YOUR-API-KEY>",
    customerPatientId: "unique-patient-id",
    identityVerification: hmacSignature   // nil in development
)

// Path B/C: Existing OneStep patient UUID (clinician / enterprise flows)
// let result = await sdk.setPatient(authPatientUuid: OSTPatientId(rawValue: "onestep-patient-uuid"))

switch result {
case .success:
    self.motionLab = try? sdk.motionLab().get()
    self.monitoring = try? sdk.monitoring().get()
case .failure(let error):
    print("Identification failed: \(error)")
}
```

### 4. Enable Background Monitoring

```swift
import OneStepSDK

guard case .success(let monitoring) = sdk.monitoring() else { return }

// Opt the user into passive background monitoring
monitoring.optIn()

// Enable monitoring with the default configuration
monitoring.enable(config: .default)

// Or customize:
monitoring.enable(config: MonitoringConfig(
    collectPedometer: true,
    collectMotionData: true,
    minWalkingDuration: 10,
    autoSync: true,
    enrollmentPolicy: .autoEnrollAfterAuth
))
```

Observe monitoring state changes reactively:

```swift
// Combine
monitoring.statePublisher
    .sink { state in
        switch state {
        case .active:               print("Monitoring active")
        case .blocked(let reasons): print("Blocked: \(reasons)")
        case .inactive:             print("Inactive")
        case .error(let err):       print("Error: \(err)")
        }
    }
    .store(in: &cancellables)

// Swift Concurrency
for await state in monitoring.stateStream {
    print("Monitoring state: \(state)")
}
```

### 5. Record a Walking Session

```swift
import OneStepSDK

guard case .success(let motionLab) = sdk.motionLab() else { return }
let recorder = motionLab.recorder

// Start recording a walk
recorder.start(
    activityType: .walk,
    duration: nil,                  // nil = manual stop
    userInputMetadata: OSTUserInputMetaData(
        note: "Post-therapy session",
        tags: ["therapy"],
        assistiveDevice: .none,
        levelOfAssistance: .independent
    ),
    customMetadata: nil
)

// Observe real-time step count
recorder.stepsCount
    .sink { count in print("Steps: \(count)") }
    .store(in: &cancellables)

// Stop and analyze
recorder.stop()
let measurement = await recorder.analyze()

if let measurement {
    print("Status: \(measurement.status)")
    print("Parameters: \(measurement.parameters ?? [:])")
}
```

### 6. Retrieve Measurements

`getMeasurements` and `getMeasurement` are **synchronous** (`throws`, not `async throws`):

```swift
guard case .success(let motionLab) = sdk.motionLab() else { return }

// All measurements (synchronous)
let measurements = try motionLab.getMeasurements(
    request: TimeRangedDataRequest(startTime: nil, endTime: nil)
)

// Single measurement by ID (synchronous)
let measurement = try motionLab.getMeasurement(id: someUUID)
```

### 7. Fetch Insights and Clinical Data

```swift
guard case .success(let insights) = sdk.insights() else { return }

// Get AI insights for a measurement
let measurementInsights = try await insights.getInsights(for: measurementId)

// Trend analysis for a gait parameter
let trend = try await insights.analyzeTrend(
    for: .walkingVelocity,
    from: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
    to: Date()
)
print("Trend: \(trend.trend), change: \(trend.percentageChange ?? 0)%")

// Fall risk assessment
guard case .success(let motionLab) = sdk.motionLab() else { return }
let measurements = try motionLab.getMeasurements(request: TimeRangedDataRequest(startTime: nil, endTime: nil))
let riskAssessment = try await insights.assessFallRisk(measurements: measurements)
print("Risk level: \(riskAssessment.riskLevel), score: \(riskAssessment.riskScore)")

// Clinical report
let report = try await insights.generateClinicalReport(
    measurementIds: measurementIds,
    includeComparisons: true
)
print(report.summary)
```

### 8. Query Step Bouts and Daily Summaries

```swift
guard case .success(let monitoring) = sdk.monitoring() else { return }

// Step bouts
let bouts = try await monitoring.stepBouts.getBouts(
    request: TimeRangedDataRequest(startTime: weekAgo, endTime: now)
)

let stats = try await monitoring.stepBouts.getStatistics(
    startDate: weekAgo,
    endDate: Date()
)
print("Total steps: \(stats.totalSteps), bouts: \(stats.boutCount)")

// Daily step counts
let dailyCounts = try await monitoring.stepBouts.getDailyStepCounts(
    startDate: monthAgo,
    endDate: Date()
)

// Aggregated background records
let records = await monitoring.dailyAggregatedBackgroundWalks(
    startTime: nil,
    endTime: nil
)
```

### 9. Handle Push Notifications

```swift
// In AppDelegate or UNUserNotificationCenterDelegate:
func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
) {
    if case .success(let sdk) = OneStep.shared() {
        sdk.handleNotification(response.notification.request.content.userInfo)
    }
    completionHandler()
}

// Update push token
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    if case .success(let sdk) = OneStep.shared() {
        sdk.updatePushToken(token)
    }
}
```

### 10. Observe Auth State

```swift
guard case .success(let sdk) = OneStep.shared() else { return }

// Current auth state (synchronous)
switch sdk.authStateValue {
case .unidentified:
    print("No user identified")
case .identified(let patientId):
    print("Identified as \(patientId.rawValue)")
case .lost(let error):
    print("Session lost: \(error)")
}

// Reactive (Combine)
sdk.authStatePublisher
    .sink { state in
        switch state {
        case .unidentified:             print("Waiting for identification")
        case .identified(let patientId): print("Identified: \(patientId.rawValue)")
        case .lost(let error):          print("Session lost: \(error)")
        }
    }
    .store(in: &cancellables)
```

### 11. Logout

`logout()` is **async** and returns `Result<Void, OSTError>`. It clears all stored credentials and session data:

```swift
guard case .success(let sdk) = OneStep.shared() else { return }
Task {
    _ = await sdk.logout()
}
```

---

## Migration from SDK 1.7.x

| SDK 1.7.x | SDK 2.0 |
|---|---|
| `OSTSDKCore.shared` (property) | `OneStep.shared()` (static method → `Result<OneStep, OSTError>`) |
| `initialize(appId:apiKey:distinctId:...) { }` | `OneStep.initialize(onAuthLost:configuration:)` (static) + `await sdk.setPatient(apiKey:customerPatientId:identityVerification:)` |
| `OSTSDKCore.shared.registerBGTasks()` | `OneStep.registerBGTasks()` (static) |
| `getRecordingService()` | `try? sdk.motionLab().get()` → `motionLab.recorder` |
| `readMotionMeasurements(startTime:endTime:)` | `try motionLab.getMeasurements(request:)` (synchronous) |
| `readMotionMeasurementById(uuid:)` | `try motionLab.getMeasurement(id:)` (synchronous, not async) |
| `deleteMotionMeasurement(by:)` | `await motionLab.deleteMeasurement(id:)` |
| `updateMotionMeasurement(uuid:userInputMetaData:)` | `await motionLab.updateMeasurement(id:userInputMetadata:)` |
| `registerBackgroundMonitoring()` | `try? sdk.monitoring().get()` → `monitoring.optIn()` + `monitoring.enable(config:)` |
| `unregisterBackgroundMonitoring()` | `monitoring.optOut()` |
| `dailyAggregatedBackgroundWalks(startTime:endTime:)` | `await monitoring.dailyAggregatedBackgroundWalks(startTime:endTime:)` |
| `getMotionDataService()` | `await insights.getMotionDataService()` (via `sdk.insights().get()`) |
| `updateUserAttributes(userAttributes:)` | `await sdk.getPatientAdmin().updateUserAttributes(_:)` (async, preferred) |
| `setDeviceToken(token:)` | `sdk.updatePushToken(_:)` |
| `disconnect()` | `await sdk.logout()` (async, returns `Result<Void, OSTError>`) |
| `handlePushNotification(data:)` | `sdk.handleNotification(_:)` (returns `Bool`) |
| `isInitialized()` | `if case .identified = sdk.authStateValue { … }` |
| `OSTSDKCore.shared.state` / `statePublisher` | `sdk.authStateValue` / `sdk.authStatePublisher` (`OSTIdentificationState`) |

---

## Installation

### Swift Package Manager (Recommended)

Add the following package URL in Xcode (**File > Add Package Dependencies…**):

```
https://github.com/OneStepRND/onestep-sdk-ios
```

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OneStepRND/onestep-sdk-ios", from: "2.0.0")
]
```

### CocoaPods

```ruby
pod 'OneStepSDK', '~> 2.0'
```

---

## Permissions & Background Modes

OneStep SDK requires **Motion & Fitness** permission to record user motion data.

```xml
<key>NSMotionUsageDescription</key>
<string>This app uses motion data to analyze your walking and mobility.</string>
```

For background monitoring, also add **Location** permissions:

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Your location is used to improve step detection accuracy.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Your location is used to improve step detection accuracy.</string>
```

Enable **Background Fetch** and **Background Processing** under **Signing & Capabilities > Background Modes**.

Register your background task identifier in `Info.plist`:

```xml
<key>BGTaskSchedulerPermittedIdentifiers</key>
<array>
    <string>co.onestep.bgsync</string>
</array>
```

For HealthKit (daily steps and walking bout coverage):

```xml
<key>NSHealthShareUsageDescription</key>
<string>OneStep reads step and mobility data to provide gait insights.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>OneStep may write processed mobility data to Health.</string>
```

---

## API Reference

### `OneStep` (Main Entry Point)

```swift
public final class OneStep {

    // MARK: - Static (call before resolving the instance)

    /// Boots the SDK. Call once at app launch. Returns .failure(.alreadyInitialized) on subsequent calls (safe to ignore).
    @discardableResult
    public static func initialize(
        onAuthLost: @escaping @Sendable (OSTError) -> Void,
        configuration: OSTConfiguration = OSTConfiguration()
    ) -> Result<Void, OSTError>

    /// Registers background task identifiers. Must be called before the app finishes launching.
    public static func registerBGTasks()

    /// Returns the initialized SDK instance. Returns .failure(.notInitialized) if initialize() was not called.
    public static func shared() -> Result<OneStep, OSTError>

    // MARK: - Authentication

    /// Identifies a patient using a customer-managed ID (Path A).
    @discardableResult
    public func setPatient(
        apiKey: String,
        customerPatientId: String,
        identityVerification: String?,
        userAttributes: (inout OSTUserAttributes) -> Void = { _ in }
    ) async -> Result<OSTPatientId, OSTError>

    /// Identifies a patient using an existing OneStep patient UUID (Paths B/C).
    @discardableResult
    public func setPatient(
        authPatientUuid: OSTPatientId,
        userAttributes: (inout OSTUserAttributes) -> Void = { _ in }
    ) async -> Result<Void, OSTError>

    /// Logs out the current user and clears all stored credentials and session data.
    @discardableResult
    public func logout() async -> Result<Void, OSTError>

    // MARK: - Auth State

    /// The current authentication state (synchronous).
    public var authStateValue: OSTIdentificationState { get }

    /// Combine publisher that emits `OSTIdentificationState` changes.
    public var authStatePublisher: AnyPublisher<OSTIdentificationState, Never> { get }

    /// Combine publisher that emits SDK analytics events.
    public var events: AnyPublisher<OSTEvent, Never> { get }

    // MARK: - Sub-Systems (available after identification)

    /// Returns the motion recording and measurement management module.
    public func motionLab() -> Result<MotionLab, OSTError>

    /// Returns the passive background monitoring module.
    public func monitoring() -> Result<Monitoring, OSTError>

    /// Returns the gait analysis, insights, and clinical reporting module.
    public func insights() -> Result<Insights, OSTError>

    // MARK: - Patient Admin

    /// Returns the patient admin interface for updating user attributes.
    public func getPatientAdmin() -> OSTPatientAdmin

    // MARK: - Utilities

    /// Registers an APNs push token for SDK-triggered notifications.
    public func updatePushToken(_ token: String)

    /// Handles an incoming SDK push notification payload. Returns true if handled by the SDK.
    @discardableResult
    public func handleNotification(_ userInfo: [AnyHashable: Any]) -> Bool

    /// Triggers a manual data sync to the OneStep cloud.
    @discardableResult
    public func sync() async -> Result<Void, OSTError>

    /// Returns true if background monitoring is currently running.
    public func isBackgroundMonitoringActive() -> Bool

    /// Returns true if in-app permissions (motion, location) still need to be requested.
    public func inAppPermissionsRequired() -> Bool

    /// Provides a Datadog agent UUID for observability (Paths B/C that have one).
    public func setAgent(agentUuid: String)
}
```

### `OSTPatientAdmin`

```swift
public class OSTPatientAdmin {
    /// Updates user profile attributes on the OneStep backend.
    @discardableResult
    public func updateUserAttributes(_ userAttributes: OSTUserAttributes) async -> Result<Void, OSTError>
}
```

### `MotionLab` Protocol

```swift
public protocol MotionLab {
    /// The recorder used to start, stop, and analyze motion sessions.
    var recorder: OSTRecorder { get }

    /// Updates the motion recording configuration.
    func updateConfiguration(_ config: MotionLabConfig)

    /// The current motion lab configuration.
    var configuration: MotionLabConfig { get }

    /// Returns all stored measurements matching the time range (synchronous).
    func getMeasurements(request: TimeRangedDataRequest) throws -> [OSTMotionMeasurement]

    /// Returns a single measurement by its UUID (synchronous).
    func getMeasurement(id: UUID) throws -> OSTMotionMeasurement?

    /// Permanently deletes a measurement.
    func deleteMeasurement(id: UUID) async throws

    /// Updates the user-provided metadata for a stored measurement.
    func updateMeasurement(id: UUID, userInputMetadata: OSTUserInputMetaData) async throws

    /// Updates the course length recorded for a timed-walk measurement.
    func updateCourseLength(id: UUID, length: OSTLength) async throws

    /// Re-submits a measurement for server-side analysis.
    func reanalyze(measurementId id: UUID) async throws

    /// Returns the maximum allowed recording duration in seconds.
    func getRecordingLimit() -> TimeInterval

    /// Checks device sensor availability and returns capability details.
    func checkDeviceCapabilities() async -> OSTResult<DeviceCapabilities>
}
```

### `OSTRecorder`

```swift
public class OSTRecorder: OSTRecorderProtocol {
    /// Combine publisher of the current recorder state.
    public var recorderState: AnyPublisher<OSTRecorderState, Never> { get }

    /// Combine publisher of the current analyzer state.
    public var analyzerState: AnyPublisher<OSTAnalyzerState, Never> { get }

    /// Combine publisher of the live step count during recording.
    public var stepsCount: AnyPublisher<Int, Never> { get }

    /// Starts a new motion recording session.
    public func start(
        activityType: OSTActivityType,
        duration: Int?,
        userInputMetadata: OSTUserInputMetaData?,
        customMetadata: [String: OSTMixedType]?
    )

    /// Stops recording and submits the session for upload and analysis.
    public func analyze() async -> OSTMotionMeasurement?

    /// Stops the active recording without submitting for analysis.
    public func stop()

    /// Resets recorder state to idle, discarding any unsaved data.
    public func reset()
}
```

### `Monitoring` Protocol

```swift
public protocol Monitoring {
    var runtimeState: MonitoringRuntimeState { get }
    var healthKit: Bool { get set }
    var statePublisher: AnyPublisher<MonitoringRuntimeState, Never> { get }
    var stateStream: AsyncStream<MonitoringRuntimeState> { get }
    var preference: MonitoringPreference { get }
    var configuration: MonitoringConfig { get }
    var stepBouts: any StepBouts { get }

    func fullBackgroundPermissions() -> Bool
    func optIn()
    func optOut()
    func enable(config: MonitoringConfig)
    func updateConfiguration(_ config: MonitoringConfig)
    func dailyAggregatedBackgroundWalks(startTime: Date?, endTime: Date?) async -> [OSTDailyAggregatedBackgroundRecord]
}
```

### `Insights` Protocol

```swift
public protocol Insights {
    func getMotionDataService() async -> any OSTMotionDataService
    func getInsights(for measurementId: UUID) async throws -> [OSTInsight]
    func getInsights(for measurementIds: [UUID]) async throws -> [UUID: [OSTInsight]]
    func analyzeTrend(for paramName: OSTParamName, from startDate: Date, to endDate: Date) async throws -> TrendAnalysis
    func assessFallRisk(measurements: [OSTMotionMeasurement]) async throws -> FallRiskAssessment
    func generateClinicalReport(measurementIds: [UUID], includeComparisons: Bool) async throws -> ClinicalReport
}
```

### Key Types

#### `OSTIdentificationState`
| Case | Description |
|------|-------------|
| `.unidentified` | No stored identity (fresh install or after logout) |
| `.identified(OSTPatientId)` | User identified; all modules available |
| `.lost(OSTError)` | Session was revoked server-side; re-identify required |

#### `OSTActivityType`
| Case | Description |
|------|-------------|
| `.walk` | Free walk |
| `.tug` | Timed Up and Go |
| `.sts` | Sit-to-Stand |
| `.sixMinWalk` | Six-Minute Walk Test |
| `.twoMinWalk` | Two-Minute Walk Test |
| `.stairs` | Stair climbing |
| `.dualTaskWalkSubtract` | Dual-task walk (cognitive) |
| `.romKneeFlexionPassive` | Passive knee flexion ROM |
| `.romKneeExtension` | Knee extension ROM |

#### `MonitoringRuntimeState`
| Case | Description |
|------|-------------|
| `.inactive` | Monitoring not started |
| `.active` | Monitoring running normally |
| `.blocked(reasons:)` | One or more `MonitoringBlocker` conditions present |
| `.error(Error)` | An unexpected error occurred |

---

## Documentation

For detailed integration guides and back-office configuration, visit the OneStep developer portal.

For Swift API documentation, build the DocC documentation catalog:

```bash
swift package generate-documentation
```

---

## Support

If you have any questions or issues:
- **Email**: [shahar@onestep.co](mailto:shahar@onestep.co)
- Open an [issue](https://github.com/OneStepRND/onestep-sdk-ios/issues) in this repository

Happy building with OneStep Collect SDK for iOS!
