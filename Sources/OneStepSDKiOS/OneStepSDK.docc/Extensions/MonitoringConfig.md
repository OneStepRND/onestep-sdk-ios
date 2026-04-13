# ``OneStepSDK/MonitoringConfig``

Configuration for passive background monitoring behavior.

## Overview

`MonitoringConfig` controls how the SDK collects walking bouts in the background, how often data is synced, and how the monitoring enrollment policy is applied.

```swift
OneStep.shared.monitoring.enable(config: .default)

// Or build a custom configuration
OneStep.shared.monitoring.enable(config: MonitoringConfig(
    collectPedometer: true,
    collectMotionData: true,
    minWalkingDuration: 15,
    autoSync: true,
    syncFrequencyHours: 6,
    maxLocalStorageMB: 200,
    autoAnalyze: true,
    minStepsForAnalysis: 20,
    notifyOnStatus: false,
    notifyDailySummary: true,
    dailySummaryHour: 21,
    anonymizeLocation: true,
    localRetentionDays: 90,
    enrollmentPolicy: .explicitOptInRequired
))
```

### Enrollment Policy

- `.autoEnrollAfterAuth` — Monitoring starts automatically once the user is identified.
- `.explicitOptInRequired` — The user must explicitly call `monitoring.optIn()` before monitoring begins.

## Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced data collection and sync for everyday use |
| `.highFrequency` | More frequent syncs; higher battery usage |
| `.lowFrequency` | Infrequent syncs; minimal battery impact |
| `.privacyFocused` | Location anonymized, reduced data retention, opt-in required |
| `.research` | Maximum data collection, long local retention |

## Topics

### Presets

- ``MonitoringConfig/default``
- ``MonitoringConfig/highFrequency``
- ``MonitoringConfig/lowFrequency``
- ``MonitoringConfig/privacyFocused``
- ``MonitoringConfig/research``

### Data Collection

- ``MonitoringConfig/collectPedometer``
- ``MonitoringConfig/collectMotionData``
- ``MonitoringConfig/minWalkingDuration``
- ``MonitoringConfig/minStepsForAnalysis``

### Sync

- ``MonitoringConfig/autoSync``
- ``MonitoringConfig/syncFrequencyHours``
- ``MonitoringConfig/autoAnalyze``

### Storage

- ``MonitoringConfig/maxLocalStorageMB``
- ``MonitoringConfig/localRetentionDays``
- ``MonitoringConfig/anonymizeLocation``

### Notifications

- ``MonitoringConfig/notifyOnStatus``
- ``MonitoringConfig/notifyDailySummary``
- ``MonitoringConfig/dailySummaryHour``

### Enrollment

- ``MonitoringConfig/enrollmentPolicy``
- ``MonitoringConfig/EnrollmentPolicy``
