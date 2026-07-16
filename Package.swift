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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.13/OneStepSDK.xcframework.zip",
            checksum: "e2e328296bb8befbab1afc3a3dd6d314ab97c9cad8c2298cee77ba25efbcc721"
        ),
    ]
)
