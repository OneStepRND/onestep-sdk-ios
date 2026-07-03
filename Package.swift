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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.11-rc2/OneStepSDK.xcframework.zip",
            checksum: "319e1f49641b206d5f1fae85ec16035923f2dfe155ad5147cc7b9b2985c5974c"
        ),
    ]
)
