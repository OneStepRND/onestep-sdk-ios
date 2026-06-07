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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc4/OneStepSDK.xcframework.zip",
            checksum: "76c289f01d5c35a08cbf3879c2b79dc7a5d5711024a2869093e829ff9b71df2b"
        ),
    ]
)
