# [OneStep](https://www.onestep.co/) Collect SDK for iOS

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://github.com/OneStepRND/onestep-sdk-ios)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/OneStepRND/onestep-sdk-ios)
[![Version](https://img.shields.io/badge/version-2.0-blue.svg)](https://github.com/OneStepRND/onestep-sdk-ios/releases)
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

> **SDK 2.0 is a breaking change** from all prior versions. The primary entry point has changed from `OSTSDKCore` to `OneStep.shared`. See [Migration Guide](#migration-from-sdk-17x) below.

## What's New in SDK 2.0

### Breaking Changes
- **New primary class**: `OneStep.shared` replaces `OSTSDKCore.shared`
- **New initialization**: `initialize(clientToken:configuration:)` + `identify(_:_:)` / `connectAsUser(_:_:configuration:)` replace the old combined `initialize(appId:apiKey:distinctId:...)` flow
- **New module system**: The SDK surface is now organized into three sub-protocols accessed via `OneStep.shared`:
  - `motionLab` — supervised/on-demand motion recording
  - `monitoring` — passive background monitoring
  - `insights` — gait analysis and clinical data
- **Background monitoring API**: `monitoring.enable(config:)` + `monitoring.optIn()` replace `registerBackgroundMonitoring()`
- **Recording API**: Accessed via `OneStep.shared.motionLab.recorder` instead of `OSTSDKCore.shared.getRecordingService()`
- **Async/await throughout**: All data-fetching methods are now `async throws`
- **Result type**: `OSTResult<T>` wraps success/failure where applicable

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
You will need a **client token** from OneStep. This replaces the previous App ID + API Key pair used in SDK 1.x.

Contact your OneStep account manager or visit the OneStep back-office under **Developers > Settings**.

---

## Getting Started

### 1. Explore the Sample Apps
- [OneStep UIKit pre-built UI/UX components](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/OneStepUIKitExample)
- [Background Monitoring](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/BackgroundSampleApp)
- [Build your own recording flow & Motion Insights](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/OneStepSDK_SampleApp)

### 2. Initialize the SDK

In your app's entry point (e.g. `@main` App struct, `AppDelegate`, or `application(_:didFinishLaunchingWithOptions:)`):

```swift
import OneStepSDK

// Step 1: Initialize with your client token (call once at app launch)
OneStep.shared.initialize(clientToken: "<YOUR-CLIENT-TOKEN>")

// Step 2: Register background task identifiers (must be called before app finishes launching)
OneStep.shared.registerBGTasks()
```

### 3. Identify a User

After the user logs in, identify them so data is attributed correctly:

```swift
// Option A: Simple identify (no server-side identity verification)
let result = await OneStep.shared.identify("unique-user-id", nil)

// Option B: Identify with HMAC identity verification (recommended for production)
let result = await OneStep.shared.identify("unique-user-id", hmacSignature)

// Option C: Connect using a JWT (clinician / enterprise flows)
let result = await OneStep.shared.connectAsUser("unique-user-id", jwtToken)

switch result {
case .success:
    print("User identified successfully")
case .failure(let reason):
    print("Identification failed: \(reason)")
}
```

### 4. Enable Background Monitoring

```swift
import OneStepSDK

// Opt the user into passive background monitoring
OneStep.shared.monitoring.optIn()

// Enable monitoring with the default configuration
OneStep.shared.monitoring.enable(config: .default)

// Or customize:
OneStep.shared.monitoring.enable(config: MonitoringConfig(
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
OneStep.shared.monitoring.statePublisher
    .sink { state in
        switch state {
        case .active:           print("Monitoring active")
        case .blocked(let reasons): print("Blocked: \(reasons)")
        case .inactive:         print("Inactive")
        case .error(let err):   print("Error: \(err)")
        }
    }
    .store(in: &cancellables)

// Swift Concurrency
for await state in OneStep.shared.monitoring.stateStream {
    print("Monitoring state: \(state)")
}
```

### 5. Record a Walking Session

```swift
import OneStepSDK

let recorder = OneStep.shared.motionLab.recorder

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
    customMetadata: nil,
    enhancedMode: false
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

```swift
let measurements = try OneStep.shared.motionLab.getMeasurements(
    request: TimeRangedDataRequest(startTime: nil, endTime: nil)
)

// Or fetch a single measurement by ID
let measurement = try await OneStep.shared.motionLab.getMeasurement(id: someUUID)
```

### 7. Fetch Insights and Clinical Data

```swift
let insights = OneStep.shared.insights

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
// Step bouts
let bouts = try await OneStep.shared.monitoring.stepBouts.getBouts(
    request: TimeRangedDataRequest(startTime: weekAgo, endTime: now)
)

let stats = try await OneStep.shared.monitoring.stepBouts.getStatistics(
    startDate: weekAgo,
    endDate: Date()
)
print("Total steps: \(stats.totalSteps), bouts: \(stats.boutCount)")

// Daily step counts
let dailyCounts = try await OneStep.shared.monitoring.stepBouts.getDailyStepCounts(
    startDate: monthAgo,
    endDate: Date()
)

// Aggregated background records
let records = await OneStep.shared.monitoring.dailyAggregatedBackgroundWalks(
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
    let handled = OneStep.shared.handleNotification(response.notification.request.content.userInfo)
    completionHandler()
}

// Update push token
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    OneStep.shared.updatePushToken(token)
}
```

### 10. Observe SDK State

```swift
// Current state
print(OneStep.shared.state)

// Reactive
OneStep.shared.statePublisher
    .sink { state in
        switch state {
        case .uninitialized: break
        case .ready:         print("SDK ready — waiting for user identification")
        case .identified(let userId): print("Identified as \(userId)")
        case .error(let code, let msg): print("Error \(code): \(msg)")
        }
    }
    .store(in: &cancellables)
```

---

## Migration from SDK 1.7.x

| SDK 1.7.x | SDK 2.0 |
|---|---|
| `OSTSDKCore.shared` | `OneStep.shared` |
| `initialize(appId:apiKey:distinctId:...) { }` | `initialize(clientToken:)` + `await identify(_:_:)` |
| `getRecordingService()` | `motionLab.recorder` |
| `readMotionMeasurements(startTime:endTime:)` | `motionLab.getMeasurements(request:)` |
| `readMotionMeasurementById(uuid:)` | `await motionLab.getMeasurement(id:)` |
| `deleteMotionMeasurement(by:)` | `await motionLab.deleteMeasurement(id:)` |
| `updateMotionMeasurement(uuid:userInputMetaData:)` | `await motionLab.updateMeasurement(id:userInputMetadata:)` |
| `registerBackgroundMonitoring()` | `monitoring.optIn()` + `monitoring.enable(config:)` |
| `unregisterBackgroundMonitoring()` | `monitoring.optOut()` |
| `dailyAggregatedBackgroundWalks(startTime:endTime:)` | `await monitoring.dailyAggregatedBackgroundWalks(startTime:endTime:)` |
| `getMotionDataService()` | `await insights.getMotionDataService()` |
| `updateUserAttributes(userAttributes:)` | `updateUserAttributes(_:)` |
| `setDeviceToken(token:)` | `updatePushToken(_:)` |
| `disconnect()` | `logout()` |
| `handlePushNotification(data:)` | `handleNotification(_:)` (returns `Bool`) |

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
@available(iOS 15.0, *)
public final class OneStep: OneStepProtocol {
    /// The singleton SDK instance.
    public static let shared: OneStep

    /// Initializes the SDK. Call once at app launch before any other SDK calls.
    /// - Parameters:
    ///   - clientToken: Your OneStep client token. If nil, the SDK reads from configuration.
    ///   - configuration: Optional `OSTConfiguration` for advanced settings.
    public func initialize(clientToken: String? = nil, configuration: OSTConfiguration = OSTConfiguration())

    /// Registers background task identifiers. Must be called before the app finishes launching.
    public func registerBGTasks()

    /// Identifies the current user. Call after authentication.
    /// - Parameters:
    ///   - userId: A stable, unique identifier for the user.
    ///   - identityVerification: HMAC signature for server-side verification (nil in development).
    /// - Returns: `IdentifyResult.success` or `.failure(reason:)`.
    public func identify(_ userId: String, _ identityVerification: String?) async -> IdentifyResult

    /// Connects as a user using a signed JWT (clinician/enterprise flows).
    /// - Parameters:
    ///   - userId: A stable, unique identifier for the user.
    ///   - jwt: A signed JWT from your backend.
    ///   - configuration: Optional `OSTConfiguration`.
    /// - Returns: `IdentifyResult.success` or `.failure(reason:)`.
    public func connectAsUser(_ userId: String, _ jwt: String, configuration: OSTConfiguration = OSTConfiguration()) async -> IdentifyResult

    /// Logs out the current user and clears session state.
    public func logout()

    /// The current SDK lifecycle state.
    public var state: OneStepState { get }

    /// Combine publisher that emits `OneStepState` changes.
    public var statePublisher: AnyPublisher<OneStepState, Never> { get }

    /// Combine publisher that emits SDK analytics events.
    public var events: AnyPublisher<OSTEvent, Never> { get }

    /// The active SDK configuration.
    public var configuration: OSTConfiguration? { get }

    /// Minimum step count required before a recording is eligible for analysis.
    public var minStepsForAnalysis: Int

    /// Returns true if background monitoring is currently running.
    public func isBackgroundMonitoringActive() -> Bool

    /// Returns true if in-app permissions (motion, location) still need to be requested.
    public func inAppPermissionsRequired() -> Bool

    /// Updates user profile attributes.
    /// - Parameter userAttributes: The `OSTUserAttributes` to apply.
    public func updateUserAttributes(_ userAttributes: OSTUserAttributes)

    /// Registers an APNs push token for SDK-triggered notifications.
    /// - Parameter token: The hex-encoded device token string.
    public func updatePushToken(_ token: String)

    /// Handles an incoming SDK push notification payload.
    /// - Parameter userInfo: The notification's `userInfo` dictionary.
    /// - Returns: `true` if the notification was handled by the SDK.
    @discardableResult
    public func handleNotification(_ userInfo: [AnyHashable: Any]) -> Bool

    /// Triggers a manual data sync to the OneStep cloud.
    /// - Returns: `true` if sync completed successfully.
    public func sync() async -> Bool

    /// The motion recording and measurement management interface.
    public var motionLab: any MotionLab { get }

    /// The passive background monitoring interface.
    public var monitoring: any Monitoring { get }

    /// The gait analysis, insights, and clinical reporting interface.
    public var insights: any Insights { get }
}
```

### `MotionLab` Protocol

```swift
public protocol MotionLab {
    /// The shared recorder used to start, stop, and analyze motion sessions.
    var recorder: OSTRecorder { get }

    /// Updates the motion recording configuration.
    func updateConfiguration(_ config: MotionLabConfig)

    /// The current motion lab configuration.
    var configuration: MotionLabConfig { get }

    /// Returns all stored measurements matching the time range.
    /// - Parameter request: Time range filter (nil bounds = unbounded).
    /// - Throws: `OSTError` on data access failure.
    func getMeasurements(request: TimeRangedDataRequest) throws -> [OSTMotionMeasurement]

    /// Returns a single measurement by its UUID.
    func getMeasurement(id: UUID) async throws -> OSTMotionMeasurement?

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
    /// - Parameters:
    ///   - activityType: The type of activity to record (`.walk`, `.tug`, `.sts`, etc.).
    ///   - duration: Fixed duration in seconds, or nil for manual stop.
    ///   - userInputMetadata: Optional user-provided annotations.
    ///   - customMetadata: Arbitrary key-value metadata attached to the measurement.
    ///   - enhancedMode: When true, enables higher-fidelity sensor sampling.
    public func start(
        activityType: OSTActivityType,
        duration: Int?,
        userInputMetadata: OSTUserInputMetaData?,
        customMetadata: [String: OSTMixedType]?,
        enhancedMode: Bool
    )

    /// Stops recording and submits the session for upload and analysis.
    /// - Returns: The resulting `OSTMotionMeasurement`, or nil if analysis failed.
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
    /// The current runtime state of background monitoring.
    var runtimeState: MonitoringRuntimeState { get }

    /// Whether HealthKit data collection is enabled.
    var healthKit: Bool { get set }

    /// Combine publisher of monitoring state changes.
    var statePublisher: AnyPublisher<MonitoringRuntimeState, Never> { get }

    /// AsyncStream of monitoring state changes.
    var stateStream: AsyncStream<MonitoringRuntimeState> { get }

    /// The user's opt-in/opt-out preference.
    var preference: MonitoringPreference { get }

    /// The active monitoring configuration.
    var configuration: MonitoringConfig { get }

    /// Access to step bout data and daily step statistics.
    var stepBouts: any StepBouts { get }

    /// Returns true if all required background permissions have been granted.
    func fullBackgroundPermissions() -> Bool

    /// Opts the user into passive background monitoring.
    func optIn()

    /// Opts the user out of passive background monitoring.
    func optOut()

    /// Activates monitoring with the given configuration.
    func enable(config: MonitoringConfig)

    /// Updates the monitoring configuration at runtime.
    func updateConfiguration(_ config: MonitoringConfig)

    /// Returns aggregated daily background walk records for the given time range.
    func dailyAggregatedBackgroundWalks(startTime: Date?, endTime: Date?) async -> [OSTDailyAggregatedBackgroundRecord]
}
```

### `Insights` Protocol

```swift
public protocol Insights {
    /// Returns the motion data service for norm lookup and parameter metadata.
    func getMotionDataService() async -> any OSTMotionDataService

    /// Returns AI-generated insights for a single measurement.
    /// - Throws: `OSTError` if the measurement is not found or network fails.
    func getInsights(for measurementId: UUID) async throws -> [OSTInsight]

    /// Returns AI-generated insights for multiple measurements.
    func getInsights(for measurementIds: [UUID]) async throws -> [UUID: [OSTInsight]]

    /// Analyzes the trend of a gait parameter over a date range.
    /// - Parameters:
    ///   - paramName: The parameter to analyze (e.g., `.walkingVelocity`).
    ///   - startDate: Start of the analysis window.
    ///   - endDate: End of the analysis window.
    /// - Returns: A `TrendAnalysis` with direction, significance, and percent change.
    func analyzeTrend(for paramName: OSTParamName, from startDate: Date, to endDate: Date) async throws -> TrendAnalysis

    /// Assesses fall risk from a collection of measurements.
    /// - Returns: A `FallRiskAssessment` with risk level, score, and recommendations.
    func assessFallRisk(measurements: [OSTMotionMeasurement]) async throws -> FallRiskAssessment

    /// Generates a clinical-grade report for the given measurement IDs.
    /// - Parameters:
    ///   - measurementIds: Measurements to include in the report.
    ///   - includeComparisons: When true, normative comparisons are included.
    /// - Returns: A `ClinicalReport` with summary, key parameters, and recommendations.
    func generateClinicalReport(measurementIds: [UUID], includeComparisons: Bool) async throws -> ClinicalReport
}
```

### Key Enumerations

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

#### `OneStepState`
| Case | Description |
|------|-------------|
| `.uninitialized` | `initialize()` has not been called |
| `.ready` | Initialized but no user identified |
| `.identified(userId:)` | User identified; SDK fully operational |
| `.error(code:message:)` | Initialization or auth failure |

#### `MonitoringRuntimeState`
| Case | Description |
|------|-------------|
| `.inactive` | Monitoring not started |
| `.active` | Monitoring running normally |
| `.blocked(reasons:)` | One or more `MonitoringBlocker` conditions present |
| `.error(Error)` | An unexpected error occurred |

#### `IdentifyResult`
| Case | Description |
|------|-------------|
| `.success` | User identified successfully |
| `.failure(reason:)` | See `IdentifyFailureReason` for detail |

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
