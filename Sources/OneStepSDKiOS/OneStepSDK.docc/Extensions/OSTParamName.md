# ``OneStepSDK/OSTParamName``

Gait and mobility parameter identifiers returned in ``OSTMotionMeasurement/parameters``.

## Overview

Use `OSTParamName.rawValue` as the key into `OSTMotionMeasurement.parameters`:

```swift
let velocity = measurement.parameters?[OSTParamName.walkingVelocity.rawValue]
let cadence  = measurement.parameters?[OSTParamName.walkingCadence.rawValue]
```

Use `OSTParamName` with ``OSTMotionDataService`` to look up normative data and display metadata:

```swift
let service = await OneStep.shared.insights.getMotionDataService()
let meta = service.getParameterMetadata(by: .walkingVelocity)
print("\(meta?.displayName ?? "") (\(meta?.units ?? ""))")

let norm = service.getNorm(by: .walkingVelocity)
let isNormal = service.isWithinNorm(param: .walkingVelocity, value: 1.2)
```

## Parameter Reference

### Walking Parameters
| Parameter | Description | Typical Units |
|-----------|-------------|---------------|
| `walkingCadence` | Steps per minute | steps/min |
| `walkingVelocity` | Average walking speed | m/s |
| `walkingStrideLength` | Average stride length | m |
| `walkingStepLength` | Average step length (both feet) | m |
| `walkingDoubleSupport` | % of gait cycle with both feet on ground | % |
| `walkingStance` | % of gait cycle in stance phase | % |
| `walkingConsistency` | Gait pattern consistency score | 0–100 |
| `walkingWalkScore` | Overall composite gait quality score | 0–100 |
| `walkingHipRange` | Hip range of motion during walking | degrees |
| `walkingBaseWidth` | Lateral distance between foot placements | m |

### TUG Parameters
| Parameter | Description |
|-----------|-------------|
| `tugDurationSeconds` | Total TUG test duration |
| `tugForwardSeconds` | Time walking forward to the marker |
| `tugBackwardSeconds` | Time walking back to the chair |
| `tugTurningSeconds` | Time spent turning at the marker |
| `tugSittingSeconds` | Time from turn completion to sitting |
| `tugStandingSeconds` | Time from sitting to first step |
| `tugDistanceMeters` | Distance to marker |

### Sit-to-Stand Parameters
| Parameter | Description |
|-----------|-------------|
| `stsRepetitionCount` | Number of completed repetitions |
| `stsRepetitionTime` | Average time per repetition |
| `stsRepetitionVar` | Variability in repetition times |
| `stsFatigue` | Fatigue index across repetitions |
| `stsAngle` | Trunk angle during transitions |

### Timed Walk Test Parameters
| Parameter | Description |
|-----------|-------------|
| `twoMinWalkDistance` | Distance covered in 2 minutes (m) |
| `sixMinWalkDistance` | Distance covered in 6 minutes (m) |
| `sixMinuteWalkLaps` | Number of laps completed |
| `walkCourseLength` | Configured course length |

### Range of Motion Parameters
| Parameter | Description |
|-----------|-------------|
| `rangeOfMotionAngle` | Generic ROM angle |
| `kneeFlexRangeOfMotionAngle` | Active knee flexion ROM |
| `kneeExtRangeOfMotionAngle` | Knee extension ROM |
| `kneeFlexPassiveRangeOfMotionAngle` | Passive knee flexion ROM |
| `hipExtRangeOfMotionAngle` | Hip extension ROM |
| `hipFlexRangeOfMotionAngle` | Hip flexion ROM |
| `hipAbdRangeOfMotionAngle` | Hip abduction ROM |
| `hipAddRangeOfMotionAngle` | Hip adduction ROM |
