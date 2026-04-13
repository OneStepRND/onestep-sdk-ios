# Mock Objects

Full mock implementations for unit testing without a real SDK session.

## Overview

SDK 2.0 ships a complete mock layer so you can write unit and UI tests without initializing the real SDK, making network calls, or using real sensors.

All mock classes conform to the same protocols as the real implementations:
- ``MockOneStep`` → ``OneStepProtocol``
- ``MockMotionLab`` → ``MotionLab``
- ``MockMonitoring`` → ``Monitoring``
- ``MockInsights`` → ``Insights``
- ``MockStepBouts`` → ``StepBouts``

### Setting Up a Mock Environment

```swift
import OneStepSDK
import XCTest

final class MyViewModelTests: XCTestCase {

    var sut: MyViewModel!
    var mockSDK: MockOneStep!

    override func setUp() {
        // Pre-populate with sample measurements
        let sampleMeasurement = OSTMotionMeasurement(
            id: UUID(),
            status: .ANALYZED,
            timestamp: Date(),
            type: OSTActivityType.walk.rawValue,
            parameters: [
                OSTParamName.walkingVelocity.rawValue: 1.2,
                OSTParamName.walkingCadence.rawValue: 108.0
            ]
        )

        let mockMotionLab = MockMotionLab(sampleMeasurements: [sampleMeasurement])
        let mockMonitoring = MockMonitoring(initialState: .active)
        let mockInsights = MockInsights()

        mockSDK = MockOneStep(
            mockMotionLab: mockMotionLab,
            mockMonitoring: mockMonitoring,
            mockInsights: mockInsights,
            initialState: .identified(userId: "test-user-001")
        )

        sut = MyViewModel(sdk: mockSDK)
    }

    func testMeasurementQuery() throws {
        let measurements = try mockSDK.motionLab.getMeasurements(
            request: TimeRangedDataRequest(startTime: nil, endTime: nil)
        )
        XCTAssertEqual(measurements.count, 1)
        XCTAssertEqual(measurements.first?.parameters?[OSTParamName.walkingVelocity.rawValue], 1.2)
    }

    func testMonitoringBlockedState() {
        let mockMonitoring = MockMonitoring(initialState: .blocked(reasons: [.permissionsRequired]))
        mockSDK = MockOneStep(mockMonitoring: mockMonitoring)
        XCTAssertTrue(mockSDK.monitoring.runtimeState.isBlocked)
    }
}
```

### Simulating State Changes

```swift
// Change mock monitoring state mid-test
let mockMonitoring = MockMonitoring(initialState: .inactive)
mockMonitoring.setMockState(.active)

// Change mock SDK state mid-test
let mockOneStep = MockOneStep(initialState: .ready)
mockOneStep.setMockState(.identified(userId: "new-user"))
```

### Testing with Raw IMU Data

Use ``OSTMockIMU`` to inject raw sensor data for offline analysis testing:

```swift
let mockIMU = OSTMockIMU(
    accelerometerX: [0.1, 0.2, ...],
    accelerometerY: [0.0, 0.1, ...],
    accelerometerZ: [9.8, 9.8, ...],
    sampleRate: 100.0
)

try mockIMU.validate()   // throws OSTMockIMU.ValidationError if arrays are malformed
```

## Topics

### Mock Classes

- ``MockOneStep``
- ``MockMotionLab``
- ``MockMonitoring``
- ``MockInsights``
- ``MockStepBouts``

### IMU Injection

- ``OSTMockIMU``
- ``OSTMockIMU/validate()``
- ``OSTMockIMU/ValidationError``
