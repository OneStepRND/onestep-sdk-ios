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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.2.2-rc2/OneStepSDK.xcframework.zip",
            checksum: "0f4858999669501cd6591041d55e75ee44c56c72f01164e6056d1e8f6d1a031a"
        ),
    ]
)
