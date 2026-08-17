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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.4/OneStepSDK.xcframework.zip",
            checksum: "76a994d4f29e69db7bf41c9f9e9a8df3775a38c8baea1d7a1fa7eef3b3a85aa6"
        ),
    ]
)
