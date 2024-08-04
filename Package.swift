// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDK",
    products: [
        .library(
            name: "OneStepSDK",
            targets: ["OneStepSDK", "OneStep_iOS_SDK"])
    ],
    targets: [
        .target(
            name: "OneStepSDK"),
        .binaryTarget(name: "OneStep_iOS_SDK", path: "Frameworks/OneStep_iOS_SDK.xcframework"),
    ]
)
