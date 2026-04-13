# ``OneStepSDK``

Integrate AI-powered gait analysis and passive motion monitoring into your iOS app.

## Overview

The OneStep Collect SDK (v2.0) provides three core capabilities accessible through the ``OneStep/shared`` singleton:

- **``MotionLab``** — Supervised, on-demand motion recording and measurement management.
- **``Monitoring``** — Passive background monitoring, step bouts, and daily summaries.
- **``Insights``** — AI-powered gait insights, trend analysis, fall risk assessment, and clinical reports.

### Quick Start

```swift
import OneStepSDK

// 1. Initialize at app launch
OneStep.shared.initialize(clientToken: "<YOUR-CLIENT-TOKEN>")
OneStep.shared.registerBGTasks()

// 2. Identify the user after login
let result = await OneStep.shared.identify("user-123", nil)

// 3. Enable background monitoring
OneStep.shared.monitoring.optIn()
OneStep.shared.monitoring.enable(config: .default)

// 4. Record a walk
let recorder = OneStep.shared.motionLab.recorder
recorder.start(activityType: .walk, duration: nil, userInputMetadata: nil, customMetadata: nil, enhancedMode: false)
recorder.stop()
let measurement = await recorder.analyze()
```

## Topics

### Entry Point

- ``OneStep``
- ``OneStepProtocol``
- ``OneStepState``
- ``OSTConfiguration``

### Authentication

- ``IdentifyResult``
- ``IdentifyFailureReason``

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
