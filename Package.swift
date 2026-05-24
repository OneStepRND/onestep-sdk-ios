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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.4-rc1/OneStepSDK.xcframework.zip",
            checksum: "c257df02243715fec5d117e9a4763e944b71f2c01e8d14432141bde07db78a37"
        ),
    ]
)
