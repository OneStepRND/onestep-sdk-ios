# ``OneStepSDK``

Integrate AI-powered gait analysis and passive motion monitoring into your iOS app.

## Overview

The OneStep Collect SDK (v2.0) provides three core capabilities accessible through the ``OneStep`` class:

- **``MotionLab``** — Supervised, on-demand motion recording and measurement management.
- **``Monitoring``** — Passive background monitoring, step bouts, and daily summaries.
- **``Insights``** — AI-powered gait insights, trend analysis, fall risk assessment, and clinical reports.

### Quick Start

```swift
import OneStepSDK

// 1. Register background tasks and boot the SDK at app launch (static calls)
OneStep.registerBGTasks()
OneStep.initialize(onAuthLost: { _ in }, configuration: OSTConfiguration())

// 2. Resolve and cache the SDK instance
guard case .success(let sdk) = OneStep.shared() else { return }

// 3. Identify the user after login (check for silent restore first)
if case .identified = sdk.authStateValue {
    // Already restored from Keychain
} else {
    _ = await sdk.setPatient(apiKey: "<YOUR-API-KEY>", customerPatientId: "user-123", identityVerification: nil)
}

// 4. Enable background monitoring
if case .success(let monitoring) = sdk.monitoring() {
    monitoring.optIn()
    monitoring.enable(config: .default)
}

// 5. Record a walk
if case .success(let motionLab) = sdk.motionLab() {
    let recorder = motionLab.recorder
    recorder.start(activityType: .walk, duration: nil, userInputMetadata: nil, customMetadata: nil)
    recorder.stop()
    let measurement = await recorder.analyze()
}
```

## Topics

### Entry Point

- ``OneStep``
- ``OneStepProtocol``
- ``OSTIdentificationState``
- ``OSTPatientId``
- ``OSTConfiguration``

### Patient Admin

- ``OSTPatientAdmin``

### Motion Recording

- ``MotionLab``
- ``OSTRecorder``
- ``OSTRecorderProtocol``
- ``OSTActivityType``
- ``OSTRecorderState``
- ``OSTAnalyzerState``
- ``OSTAnalyserState``
- ``AnalysisStage``
- ``MotionLabConfig``
- ``DeviceCapabilities``
- ``OSTMockIMU``

### Measurements

- ``OSTMotionMeasurement``
- ``OSTMotionMeasurementStatus``
- ``OSTResultState``
- ``OSTMeasurementMetadata``
- ``OSTMeasurementError``
- ``OSTUserInputMetaData``
- ``TimeRangedDataRequest``

### Background Monitoring

- ``Monitoring``
- ``MonitoringConfig``
- ``MonitoringRuntimeState``
- ``MonitoringPreference``
- ``MonitoringBlocker``
- ``MonitoringDailySummary``
- ``StepBouts``
- ``StepBout``
- ``StepStatistics``
- ``StepSource``
- ``OSTDailyAggregatedBackgroundRecord``
- ``DailySummariesQuery``

### Insights & Clinical Data

- ``Insights``
- ``OSTInsight``
- ``OSTInsightType``
- ``OSTIntentType``
- ``TrendAnalysis``
- ``FallRiskAssessment``
- ``ClinicalReport``
- ``NormativeComparison``

### Gait Parameters

- ``OSTParamName``
- ``OSTParameterMetadata``
- ``OSTMotionDataService``
- ``OSTNorm``
- ``NormSegment``
- ``OSTDiscreteColor``
- ``DiscreteColor``

### User Profile

- ``OSTUserAttributes``
- ``OSTSurgeryType``
- ``OSTSurgerySide``
- ``OSTAssistiveDevice``
- ``OSTLevelOfAssistance``
- ``OSTWalkCourseLength``
- ``OSTLength``

### Events & Notifications

- ``OSTEvent``
- ``OSTNotificationConfig``

### Errors

- ``OSTError``
- ``OSTAnalyserError``
- ``OSTResult``

### Mock Objects (Testing)

- ``MockOneStep``
- ``MockMotionLab``
- ``MockMonitoring``
- ``MockInsights``
- ``MockStepBouts``

### Utilities

- ``OSTMixedType``
- ``AnyCodable``
- ``SortOrder``
- ``OSTAnalyticsHandler``
