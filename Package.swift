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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.6-rc2/OneStepSDK.xcframework.zip",
            checksum: "54d7da4de834f0fca9f307f04be1f6d571bfe2bf8d26e72a96b8139a878bbe30"
        ),
    ]
)
