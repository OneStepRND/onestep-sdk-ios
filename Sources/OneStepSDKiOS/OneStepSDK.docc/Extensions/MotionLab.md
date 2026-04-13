# ``OneStepSDK/MotionLab``

Supervised, on-demand motion recording and measurement management.

## Overview

Access `MotionLab` via `OneStep.shared.motionLab`. Use it to:
- Start and stop supervised recording sessions via ``MotionLab/recorder``
- Query, update, delete, and re-analyze stored measurements
- Configure sensor sampling rates and quality thresholds via ``MotionLabConfig``

### Recording a Session

```swift
let lab = OneStep.shared.motionLab
let recorder = lab.recorder

// Start a TUG test
recorder.start(
    activityType: .tug,
    duration: nil,
    userInputMetadata: OSTUserInputMetaData(
        note: "Pre-operative assessment",
        tags: ["pre-op"],
        assistiveDevice: .cane,
        levelOfAssistance: .minimalAssistence
    ),
    customMetadata: ["clinician_id": .string("dr-smith")],
    enhancedMode: false
)

// Observe live steps
recorder.stepsCount
    .sink { count in updateStepLabel(count) }
    .store(in: &cancellables)

// Stop and analyze
recorder.stop()
if let result = await recorder.analyze() {
    print("Walking velocity: \(result.parameters?["walkingVelocity"] ?? 0) m/s")
}
```

### Configuration Presets

```swift
// High-fidelity research recording
lab.updateConfiguration(.research)

// Devices without gyroscope
lab.updateConfiguration(.noGyroscope)
```

### Device Capability Check

```swift
let capabilities = await lab.checkDeviceCapabilities()
switch capabilities {
case .success(let caps):
    print("Gyroscope: \(caps.hasGyroscope), support: \(caps.supportLevel)")
case .failure(let error):
    print("Check failed: \(error)")
}
```

## Topics

### Recording

- ``MotionLab/recorder``
- ``MotionLab/getRecordingLimit()``

### Measurements

- ``MotionLab/getMeasurements(request:)``
- ``MotionLab/getMeasurement(id:)``
- ``MotionLab/deleteMeasurement(id:)``
- ``MotionLab/updateMeasurement(id:userInputMetadata:)``
- ``MotionLab/updateCourseLength(id:length:)``
- ``MotionLab/reanalyze(measurementId:)``

### Configuration

- ``MotionLab/configuration``
- ``MotionLab/updateConfiguration(_:)``
- ``MotionLab/checkDeviceCapabilities()``
