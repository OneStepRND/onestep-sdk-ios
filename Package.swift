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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.2.0/OneStepSDK.xcframework.zip",
            checksum: "0c943974100e43b4b77c758ac401f0704c1a2a7b6a11692e8f814980e502224b"
        ),
    ]
)
