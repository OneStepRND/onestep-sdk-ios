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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc2/OneStepSDK.xcframework.zip",
            checksum: "dc0addeb8a81d962652d9bbf802f0ba25d2919e79f13cd1a9d9c114cabd9d88b"
        ),
    ]
)
