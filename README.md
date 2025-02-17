# [OneStep](https://www.onestep.co/) Collect SDK for iOS

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://github.com/OneStepRND/onestep-uikit-ios-spm)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/OneStepRND/onestep-uikit-ios-spm)
[![Version](https://img.shields.io/badge/version-1.2.0.beta-blue.svg)](https://github.com/OneStepSDK/OneStepSDK/releases)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-green.svg)](https://github.com/OneStepRND/onestep-uikit-ios-spm)
![Commercial License](https://img.shields.io/badge/license-Commercial-green.svg)

## Table of Contents
1. [Introduction](#introduction)  
2. [Features](#features)  
3. [Requirements](#requirements)  
4. [Before You Begin](#before-you-begin)  
5. [Getting Started](#getting-started)  
6. [Installation](#installation)  
7. [Permissions & Background Modes](#permissions--background-modes)  
8. [Documentation](#documentation)  
9. [Support](#support)

## Introduction
The OneStep Collect SDK is a comprehensive solution for integrating advanced motion analysis capabilities into your iOS applications. It allows for real-time data collection, analysis, and insightful feedback based on motion data.

## Features

### 1. Real-time Motion Analysis
Capture and analyze motion data using your device's built-in sensors.

### 2. Background Monitoring
Continuously monitor and analyze motion data, even when the app is in the background.

### 3. OneStep AI Motion Engine
Leverage metadata, norms, and insights to enhance motion analysis and deliver actionable results.

### 4. Customizable UI Components
Easily integrate OneStep’s [pre-built UI components](https://github.com/OneStepRND/onestep-uikit-ios-spm) into your app.

### 5. Data Integration
Sync motion data with cloud services for comprehensive analysis and storage.

### 6. HealthKit Integration
Pairs Apple’s 24/7 activity tracking with OneStep’s deep gait analysis for a complete view of user mobility.

## Requirements
- iOS 16 or later
- Xcode 16 or later
- **HealthKit** capability
- **Background Execution** modes for background monitoring

## Before You Begin

### Obtaining Your API Credentials
You will need the following credentials from OneStep:
- **App ID** – Your application’s unique identifier  
- **API Key** – The key associated with your OneStep account  

These can be found in the OneStep back-office under **Developers > Settings**.

## Getting Started

### 1. Explore the Sample App
To see OneStep Collect in action, check out our sample apps in the GitHub repository:

- [OneStep UIKit pre-built UI/UX components](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/OneStepUIKitExample)
- [Background Monitoring](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/BackgroundSampleApp)
- [Build your own recording flow & Motion Insights](https://github.com/OneStepRND/onestep-sdk-ios-samples/tree/main/OneStepSDK_SampleApp)

### 2. Integrate Your API Key
In your app’s entry point (e.g., `AppDelegate` or equivalent), initialize the **OneStep SDK** as follows:

```swift
import OneStepSDK
        
// Replace with your own distinct user ID as needed
let distinctId = "SOME-UNIQUE-USER-ID"

// Initialize OneStep SDK
OSTSDKCore.shared.initialize(
    appId: "<YOUR-APP-ID-HERE>",
    apiKey: "<YOUR-API-KEY-HERE>",
    distinctId: distinctId,
    identityVerification: nil, // Implement in production for additional security
    configuration: OSTConfiguration(enableMonitoringFeature: true)
) { success in
    if success {
        print("SDK initialization succeeded")
        // opt-in background monitoring - it's your responsability to collect neccassary permissions
        OSTSDKCore.shared.registerBackgroundMonitoring()
    } else {
        print("SDK initialization failed")
    }
}

// register background tasks for continious background monitoring sync 
OSTSDKCore.shared.registerBGTasks()
```

### Installation
OneStep SDK for iOS can be installed through Swift Package Manager:
```bash
https://github.com/OneStepRND/onestep-sdk-ios
``` 

### Permissions & Background Modes
OneStep SDK needs permissions for **Motion & Fitness** and **Location** (Always & When In Use) to record user motion data accurately.

```xml
<key>NSMotionUsageDescription</key>
<string>Your Motion & Fitness usage description here</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Your location usage description here</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Your location usage description here</string>
```

Enable **Background Fetch** and **Location Updates** under Signing & Capabilities > Background Modes to support background (passive) monitoring.

![Screenshot 2025-02-17 at 10 16 34](https://github.com/user-attachments/assets/9bce8cbf-e9fc-4e10-9cc8-5d66f7496e02)

For enhanced background monitoring and daily steps coverage, we highly recommend enabling **HealthKit** in your project:

```xml
<key>NSHealthUpdateUsageDescription</key>
<string>Your explanation for why you need to update health data.</string>
<key>NSHealthShareUsageDescription</key>
<string>Your explanation for why you need to read health data.</string>
```

![Screenshot 2025-02-17 at 10 16 38](https://github.com/user-attachments/assets/3d5ffbf6-b0a2-4354-91af-fd65e81129c2)

## Documentation

For detailed technical information and guides, please refer to our official documentation in the OneStep back-office.

## Support

If you have any questions or issues:
- **Email**: [shahar@onestep.co](mailto:shahar@onestep.co)  
- Or open an [issue](https://github.com/OneStepRND/onestep-sdk-ios/issues) in this repository.

Happy building with OneStep Collect SDK for iOS!
