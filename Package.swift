// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDKiOS",
    products: [
        .library(
            name: "OneStepSDKiOS",
            targets: ["OneStepSDKiOS", "OneStepSDK"])
    ],
    targets: [
        .target(name: "OneStepSDKiOS"),
        .binaryTarget(name: "OneStepSDK", path: "Frameworks/OneStepSDK.xcframework"),
    ]
)
