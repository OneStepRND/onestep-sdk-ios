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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.6-core/OneStepSDK.xcframework.zip",
            checksum: "7856e4c73c1ad39bdf5cdae241d8f922f23aaf3ff4493dc532f31cf5eb191e8f"
        ),
    ]
)
