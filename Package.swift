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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.4-core/OneStepSDK.xcframework.zip",
            checksum: "79fa049eec55c77e47352564b123cdf8378b478d5ab982e013150e13557a38ed"
        ),
    ]
)
