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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc5/OneStepSDK.xcframework.zip",
            checksum: "ae7a19352d79089a4e3e33d51e58b2df6ca03062b6d2f1da3d4981b626e2c3a9"
        ),
    ]
)
