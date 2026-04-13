# ``OneStepSDK/OneStep``

The main entry point for the OneStep Collect SDK.

## Overview

`OneStep` is a singleton class accessed via `OneStep.shared`. It orchestrates SDK initialization, user identification, and provides access to the three core sub-systems:

- ``OneStep/motionLab`` — Supervised motion recording
- ``OneStep/monitoring`` — Passive background monitoring
- ``OneStep/insights`` — AI analysis and clinical insights

### Initialization Lifecycle

```swift
// App launch — AppDelegate or @main App struct
OneStep.shared.initialize(clientToken: "<YOUR-CLIENT-TOKEN>")
OneStep.shared.registerBGTasks()   // must be called before app finishes launching

// After user authentication
let result = await OneStep.shared.identify("user-id-123", nil)
guard case .success = result else { return }

// Observe state
OneStep.shared.statePublisher
    .sink { state in print("SDK state: \(state)") }
    .store(in: &cancellables)
```

### State Machine

```
uninitialized → ready → identified(userId:)
                      ↘ error(code:message:)
```

Call ``OneStep/initialize(clientToken:configuration:)`` to reach `.ready`,
then ``OneStep/identify(_:_:)`` or ``OneStep/connectAsUser(_:_:configuration:)`` to reach `.identified`.

## Topics

### Initialization

- ``OneStep/initialize(clientToken:configuration:)``
- ``OneStep/registerBGTasks()``

### Authentication

- ``OneStep/identify(_:_:)``
- ``OneStep/connectAsUser(_:_:configuration:)``
- ``OneStep/logout()``

### State

- ``OneStep/state``
- ``OneStep/statePublisher``
- ``OneStep/events``
- ``OneStep/configuration``

### Sub-Systems

- ``OneStep/motionLab``
- ``OneStep/monitoring``
- ``OneStep/insights``

### Utilities

- ``OneStep/updateUserAttributes(_:)``
- ``OneStep/updatePushToken(_:)``
- ``OneStep/handleNotification(_:)``
- ``OneStep/sync()``
- ``OneStep/isBackgroundMonitoringActive()``
- ``OneStep/inAppPermissionsRequired()``
- ``OneStep/minStepsForAnalysis``
