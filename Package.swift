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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.0-rc2/OneStepSDK.xcframework.zip",
            checksum: "a9b20c114f67d99d491c804364d9cac4040c0462f776c474977a7791e1cd7525"
        ),
    ]
)
