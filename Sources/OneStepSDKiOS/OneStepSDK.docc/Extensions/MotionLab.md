# ``OneStepSDK/MotionLab``

Supervised, on-demand motion recording and measurement management.

## Overview

Access `MotionLab` via `sdk.motionLab()`, which returns `Result<MotionLab, OSTError>`. Resolve it once after identification and cache the reference. Use it to:
- Start and stop supervised recording sessions via ``MotionLab/recorder``
- Query, update, delete, and re-analyze stored measurements
- Configure sensor sampling rates and quality thresholds via ``MotionLabConfig``

### Recording a Session

```swift
guard case .success(let lab) = sdk.motionLab() else { return }
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
    customMetadata: ["clinician_id": .string("dr-smith")]
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

### Querying Measurements

`getMeasurements(request:)` and `getMeasurement(id:)` are **synchronous** (`throws`, not `async throws`):

```swift
// All measurements (synchronous)
let all = try lab.getMeasurements(
    request: TimeRangedDataRequest(startTime: nil, endTime: nil)
)

// Single measurement by ID (synchronous)
let m = try lab.getMeasurement(id: someUUID)

// Update, delete, re-analyze are async
try await lab.updateMeasurement(id: uuid, userInputMetadata: meta)
try await lab.deleteMeasurement(id: uuid)
try await lab.reanalyze(measurementId: uuid)
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
