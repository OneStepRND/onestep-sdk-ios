# ``OneStepSDK/OSTMotionMeasurement``

A recorded and analyzed motion session.

## Overview

`OSTMotionMeasurement` is the primary data model returned after a recording session is analyzed. It contains:
- A unique `id` (UUID) for the measurement
- The activity `type` string (matches ``OSTActivityType/rawValue``)
- A `timestamp` indicating when the session started
- A `status` indicating whether analysis has completed
- A `parameters` dictionary mapping ``OSTParamName`` raw values to `Double` results
- Optional `metadata` with clinical annotations, course length, and assistive device used
- Optional `parameter_arrays` for time-series data (e.g., stride-by-stride cadence)

```swift
let measurements = try OneStep.shared.motionLab.getMeasurements(
    request: TimeRangedDataRequest(startTime: nil, endTime: nil)
)

for m in measurements where m.status == .ANALYZED {
    let velocity = m.parameters?[OSTParamName.walkingVelocity.rawValue]
    let cadence  = m.parameters?[OSTParamName.walkingCadence.rawValue]
    print("Walk on \(m.timestamp): \(velocity ?? 0) m/s, \(cadence ?? 0) steps/min")
}
```

### Status Lifecycle

```
NOT_SYNCED → SYNCED → ANALYZED
```

A measurement is `NOT_SYNCED` immediately after `recorder.stop()`. Once uploaded it becomes `SYNCED`. After server analysis completes it becomes `ANALYZED` and `parameters` is populated.

### Re-analysis

If analysis fails or you want to reprocess with updated algorithms, call:

```swift
try await OneStep.shared.motionLab.reanalyze(measurementId: measurement.id)
```

## Topics

### Identity

- ``OSTMotionMeasurement/id``
- ``OSTMotionMeasurement/type``
- ``OSTMotionMeasurement/timestamp``

### Status & Results

- ``OSTMotionMeasurement/status``
- ``OSTMotionMeasurement/result_state``
- ``OSTMotionMeasurement/parameters``
- ``OSTMotionMeasurement/parameter_arrays``
- ``OSTMotionMeasurement/error``

### Metadata

- ``OSTMotionMeasurement/metadata``
- ``OSTMotionMeasurement/custom_metadata``
