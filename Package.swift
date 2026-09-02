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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.2.1/OneStepSDK.xcframework.zip",
            checksum: "e0b7516efe8e041715d61ea6a8e00d584d22e88632ebd27ee36090eaf18e7e75"
        ),
    ]
)
