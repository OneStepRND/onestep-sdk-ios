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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.2.2-rc1/OneStepSDK.xcframework.zip",
            checksum: "5ce6bcc07bae221576b1b84eecde24d4b6629d855c1df4736d60d50644d3f014"
        ),
    ]
)
