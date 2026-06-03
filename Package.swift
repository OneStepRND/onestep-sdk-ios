// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDK",
    products: [
        .library(name: "OneStepSDK", targets: ["OneStepSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "OneStepSDK",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc3/OneStepSDK.xcframework.zip",
            checksum: "d20fa1c152eee3a0532e47c13c275372fd959c95f86a29b1457f76cd21e37ba0"
        ),
    ]
)
