# ``OneStepSDK/OneStep``

The main entry point for the OneStep Collect SDK.

## Overview

`OneStep` is initialized via the static `OneStep.initialize(onAuthLost:configuration:)` method and retrieved via `OneStep.shared()`, which returns a `Result<OneStep, OSTError>`. It orchestrates SDK initialization, user identification, and provides access to the three core sub-systems:

- ``OneStep/motionLab()`` — Supervised motion recording
- ``OneStep/monitoring()`` — Passive background monitoring
- ``OneStep/insights()`` — AI analysis and clinical insights

### Initialization Lifecycle

```swift
// App launch — AppDelegate or @main App struct

// 1. Register background tasks (must be before app finishes launching)
OneStep.registerBGTasks()

// 2. Boot the SDK (static call; safe to call on every launch)
OneStep.initialize(
    onAuthLost: { error in /* handle session loss */ },
    configuration: OSTConfiguration()
)

// 3. Resolve and cache the SDK instance
guard case .success(let sdk) = OneStep.shared() else { return }

// 4. Cache module references (available after identification)
// var sdk: OneStep?
// var motionLab: MotionLab?
// var monitoring: Monitoring?

// Check for silent restore (credentials already in Keychain)
if case .identified = sdk.authStateValue {
    // User already identified — modules are ready
    motionLab = try? sdk.motionLab().get()
    monitoring = try? sdk.monitoring().get()
} else {
    // After user signs in, identify them:
    // Path A — customer-managed patient ID
    let result = await sdk.setPatient(
        apiKey: "<YOUR-API-KEY>",
        customerPatientId: "user-id-123",
        identityVerification: hmacSignature  // nil in development
    )
    if case .success = result {
        motionLab = try? sdk.motionLab().get()
        monitoring = try? sdk.monitoring().get()
    }
}

// Observe auth state
sdk.authStatePublisher
    .sink { state in print("Auth state: \(state)") }
    .store(in: &cancellables)
```

### State Machine

```
unidentified → identified(OSTPatientId)
             ↘ lost(OSTError)
```

Call `OneStep.initialize(onAuthLost:configuration:)` to boot the SDK, then `sdk.setPatient(...)` to reach `.identified`. On subsequent launches, silent restore transitions directly to `.identified` if credentials are present in the Keychain.

`OSTIdentificationState` cases:
- `.unidentified` — no stored identity (fresh install or after logout)
- `.identified(OSTPatientId)` — user identified; modules available
- `.lost(OSTError)` — session was revoked server-side

## Topics

### Initialization

- ``OneStep/initialize(onAuthLost:configuration:)``
- ``OneStep/registerBGTasks()``
- ``OneStep/shared()``

### Authentication

- ``OneStep/setPatient(apiKey:customerPatientId:identityVerification:userAttributes:)``
- ``OneStep/setPatient(authPatientUuid:userAttributes:)``
- ``OneStep/logout()``
- ``OneStep/getPatientAdmin()``

### Auth State

- ``OneStep/authStateValue``
- ``OneStep/authStatePublisher``
- ``OneStep/events``
- ``OneStep/configuration``

### Sub-Systems

- ``OneStep/motionLab()``
- ``OneStep/monitoring()``
- ``OneStep/insights()``

### Utilities

- ``OneStep/updatePushToken(_:)``
- ``OneStep/handleNotification(_:)``
- ``OneStep/sync()``
- ``OneStep/setAgent(agentUuid:)``
- ``OneStep/isBackgroundMonitoringActive()``
- ``OneStep/inAppPermissionsRequired()``
