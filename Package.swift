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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.3-rc1/OneStepSDK.xcframework.zip",
            checksum: "1a1d5ca9122f15b97b1073d75a98e3d20f3649449985433f922bb4085c56f80d"
        ),
    ]
)
