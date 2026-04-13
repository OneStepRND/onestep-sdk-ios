# ``OneStepSDK/OSTActivityType``

Supported motion activity types for recording sessions.

## Overview

Pass an `OSTActivityType` to ``OSTRecorder/start(activityType:duration:userInputMetadata:customMetadata:enhancedMode:)`` to configure what kind of clinical assessment is being performed.

Each activity type maps to a distinct analysis pipeline on the OneStep server and produces a different set of ``OSTParamName`` output parameters.

```swift
// Record a Six-Minute Walk Test
recorder.start(activityType: .sixMinWalk, duration: 360, ...)

// Record a Timed Up and Go
recorder.start(activityType: .tug, duration: nil, ...)

// Record Sit-to-Stand repetitions
recorder.start(activityType: .sts, duration: nil, ...)
```

## Activity Type Reference

| Case | Description | Key Output Parameters |
|------|-------------|----------------------|
| `.walk` | Free walk | `walkingVelocity`, `walkingCadence`, `walkingStrideLength`, `walkingWalkScore` |
| `.tug` | Timed Up and Go | `tugDurationSeconds`, `tugForwardSeconds`, `tugTurningSeconds` |
| `.sts` | Sit-to-Stand | `stsRepetitionCount`, `stsRepetitionTime`, `stsFatigue` |
| `.sixMinWalk` | Six-Minute Walk Test | `sixMinWalkDistance`, `sixMinuteWalkLaps` |
| `.twoMinWalk` | Two-Minute Walk Test | `twoMinWalkDistance` |
| `.stairs` | Stair climbing | Cadence, timing parameters |
| `.dualTaskWalkSubtract` | Dual-task walk (cognitive) | Walk + cognitive performance parameters |
| `.romKneeFlexionPassive` | Passive knee flexion ROM | `kneeFlexPassiveRangeOfMotionAngle` |
| `.romKneeExtension` | Knee extension ROM | `kneeExtRangeOfMotionAngle` |

Use `OSTActivityType.isHallwaySupported` and `OSTActivityType.minimumHallwayLength` to determine space requirements before starting a timed-walk test.

## Topics

### Cases

- ``OSTActivityType/walk``
- ``OSTActivityType/tug``
- ``OSTActivityType/sts``
- ``OSTActivityType/sixMinWalk``
- ``OSTActivityType/twoMinWalk``
- ``OSTActivityType/stairs``
- ``OSTActivityType/dualTaskWalkSubtract``
- ``OSTActivityType/romKneeFlexionPassive``
- ``OSTActivityType/romKneeExtension``
