# ``OneStepSDK/Monitoring``

Passive background monitoring, step bout collection, and daily activity summaries.

## Overview

Access `Monitoring` via `sdk.monitoring()`, which returns `Result<Monitoring, OSTError>`. Resolve it once after identification and cache the reference. It continuously collects walking bouts and pedometer data in the background and aggregates daily mobility metrics.

### Enabling Monitoring

```swift
guard case .success(let monitoring) = sdk.monitoring() else { return }

// Opt the user in (stores preference persistently)
monitoring.optIn()

// Enable with default config
monitoring.enable(config: .default)

// Or enable with a custom config
monitoring.enable(config: MonitoringConfig(
    collectPedometer: true,
    collectMotionData: true,
    minWalkingDuration: 10,
    autoSync: true,
    syncFrequencyHours: 4,
    enrollmentPolicy: .autoEnrollAfterAuth
))
```

### Observing State

```swift
// Combine
monitoring.statePublisher
    .sink { state in
        switch state {
        case .active:
            print("Monitoring is running")
        case .blocked(let reasons):
            for reason in reasons {
                print("Blocked: \(reason.displayDescription)")
                print("Action: \(reason.actionSuggestion)")
            }
        case .inactive, .error:
            break
        }
    }
    .store(in: &cancellables)

// Swift Concurrency
for await state in monitoring.stateStream {
    print(state)
}
```

### Querying Step Bouts

```swift
let bouts = try await monitoring.stepBouts.getBouts(
    request: TimeRangedDataRequest(
        startTime: Date().addingTimeInterval(-7 * 86400).timeIntervalSince1970,
        endTime: Date().timeIntervalSince1970
    )
)

let stats = try await monitoring.stepBouts.getStatistics(
    startDate: weekAgo,
    endDate: Date()
)
print("Total steps: \(stats.totalSteps), avg cadence: \(stats.averageCadence ?? 0) steps/min")
```

### Monitoring Blockers

When `runtimeState` is `.blocked`, each ``MonitoringBlocker`` case provides:
- `displayDescription`: user-friendly explanation
- `actionSuggestion`: how to resolve the issue
- `isUserResolvable`: whether the user can fix it themselves

## Topics

### Control

- ``Monitoring/optIn()``
- ``Monitoring/optOut()``
- ``Monitoring/enable(config:)``
- ``Monitoring/updateConfiguration(_:)``

### State

- ``Monitoring/runtimeState``
- ``Monitoring/statePublisher``
- ``Monitoring/stateStream``
- ``Monitoring/preference``
- ``Monitoring/configuration``
- ``Monitoring/healthKit``
- ``Monitoring/fullBackgroundPermissions()``

### Step Data

- ``Monitoring/stepBouts``
- ``Monitoring/dailyAggregatedBackgroundWalks(startTime:endTime:)``
