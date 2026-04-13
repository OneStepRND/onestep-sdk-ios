# ``OneStepSDK/MotionLabConfig``

Configuration for supervised motion recording sessions.

## Overview

`MotionLabConfig` controls sensor sampling rates, quality thresholds, storage limits, and upload behavior for ``MotionLab`` recordings.

Apply a configuration before starting a session:

```swift
OneStep.shared.motionLab.updateConfiguration(.highQuality)
```

Or construct a custom configuration:

```swift
OneStep.shared.motionLab.updateConfiguration(MotionLabConfig(
    accelerometerSampleRate: 100.0,
    gyroscopeSampleRate: 100.0,
    requireGyroscope: true,
    autoUpload: true,
    autoAnalyze: true,
    maxRecordingDuration: 600,
    minRecordingDuration: 5,
    enableQualityChecks: true,
    minQualityThreshold: 0.7,
    provideRealTimeFeedback: true,
    storeRawData: true,
    maxLocalMeasurements: 100
))
```

## Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced quality and battery usage for everyday clinical use |
| `.highQuality` | Maximum sensor fidelity for detailed gait analysis |
| `.fast` | Reduced analysis latency; suitable for quick assessments |
| `.research` | Maximum data retention; stores full raw sensor streams |
| `.noGyroscope` | Accelerometer-only mode for devices without a gyroscope |

## Topics

### Presets

- ``MotionLabConfig/default``
- ``MotionLabConfig/highQuality``
- ``MotionLabConfig/fast``
- ``MotionLabConfig/research``
- ``MotionLabConfig/noGyroscope``

### Sensor Settings

- ``MotionLabConfig/accelerometerSampleRate``
- ``MotionLabConfig/gyroscopeSampleRate``
- ``MotionLabConfig/requireGyroscope``

### Recording Limits

- ``MotionLabConfig/maxRecordingDuration``
- ``MotionLabConfig/minRecordingDuration``
- ``MotionLabConfig/maxLocalMeasurements``

### Quality

- ``MotionLabConfig/enableQualityChecks``
- ``MotionLabConfig/minQualityThreshold``
- ``MotionLabConfig/provideRealTimeFeedback``

### Upload & Storage

- ``MotionLabConfig/autoUpload``
- ``MotionLabConfig/autoAnalyze``
- ``MotionLabConfig/storeRawData``
