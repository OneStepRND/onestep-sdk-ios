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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.5-core/OneStepSDK.xcframework.zip",
            checksum: "04b5612f0d9413c65a43f87b81c4c02f144691689b89574b898e33c103da4e34"
        ),
    ]
)
