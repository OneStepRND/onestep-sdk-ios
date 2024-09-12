
# OneStepSDK for iOS

[![API](https://img.shields.io/badge/API-15%2B-brightgreen.svg)](https://developer.apple.com/documentation/ios-ipados-release-notes)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/OneStepSDK/OneStepSDK/releases)

The OneStep SDK is a comprehensive solution for integrating advanced motion analysis capabilities into your iOS applications. It allows for real-time data collection, analysis, and insightful feedback based on motion data, tailored to your app’s needs.

## Features

- **Real-time Motion Analysis:** Capture and analyze motion data using your device's built-in sensors.
- **Background Monitoring:** Continuously monitor and analyze motion data, even when the app is in the background.
- **Customizable UI Components:** Easily integrate OneStep’s pre-built UI components into your app.
- **Seamless Data Integration:** Sync motion data with cloud services for comprehensive analysis and storage.
- **Motion Insights:** Leverage metadata, norms, and insights to enhance motion analysis and deliver actionable results.

## Requirements

- iOS 15 or later
- Xcode 15 or later

## Installation

### Swift Package Manager

Add `https://github.com/OneStepRND/onestep-sdk-ios` as a Swift Package in your Xcode project.

## Getting Started

### Initializing the SDK

To start using the OneStep SDK, initialize it in your `AppDelegate` or equivalent entry point of your app:

```swift
import OneStepSDK

let connectionResult = await OSTSDKCore.shared.initialize(
    appId: "<YOUR-APP-ID-HERE>",
    apiKey: "<YOUR-API-KEY-HERE>",
    distinctId: "<A-UNIQUE-ID-FOR-CURRENT-USER-HERE>",
    identityVerification: nil,
    configuration: OSTConfiguration(enableMonitoringFeature: true)
)
```

### Real-time Motion Recording

To record motion data:

```swift
let recorder = OSTSDKCore.shared.getRecordingService()
recorder.start(activityType: .walk)
```

To stop and analyze the recording:

```swift
recorder.stop()
let analysisResult = await recorder.analyze()
```

### Background Monitoring

Enable background monitoring:

```swift
OSTSDKCore.shared.registerBackgroundMonitoring()
```

### Customization

The SDK provides several options for customizing the behavior, including data retention policies, user profile management, and more.
See the full documentation [here](https://www.onestep.co/).

## Example App

An example iOS app demonstrating the integration and usage of the OneStep SDK is available in the [OneStepSDK Sample App repository](https://github.com/OneStepRND/onestep-sdk-ios-samples). This app showcases:

- Real-time motion data recording and analysis
- Data enrichment with metadata, norms, and insights
- Backgroud monitoring
- OneStep UIKit pre-built UI/UX components

## Support

For support, additional information, or to report issues, please contact `shahar@onestep.co`.
