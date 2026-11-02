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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.2-core/OneStepSDK.xcframework.zip",
            checksum: "6bdeee3a99f3b7627badaddecb1a69e5b054df01b1b931e5aac15fbd2b5ec187"
        ),
    ]
)
