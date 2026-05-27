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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc1/OneStepSDK.xcframework.zip",
            checksum: "a6f6b88da163b10d8b0e4c47392d86b7c9e8f9649a9d588efdb9c9a468e9b6c2"
        ),
    ]
)
