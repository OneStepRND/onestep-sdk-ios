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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.11-core/OneStepSDK.xcframework.zip",
            checksum: "7e67ca25f3ea050cf04c2018795f8bf147408916b444bbabdd871baf2cd3f6f5"
        ),
    ]
)
