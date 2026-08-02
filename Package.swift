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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.1-rc2/OneStepSDK.xcframework.zip",
            checksum: "8c5fe0cac45c593adcc1c97933b68bd2566c13dfe8b5a52fc8ea1eef45e40332"
        ),
    ]
)
