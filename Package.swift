// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDK",
    products: [
        .library(name: "OneStepSDK", targets: ["OneStepSDK"]),
        .library(name: "OneStepPrivateDataTransfer", targets: ["OneStepPrivateDataTransfer"]),
    ],
    targets: [
        .binaryTarget(
            name: "OneStepSDK",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.13-core/OneStepSDK.xcframework.zip",
            checksum: "a3577b5b2ede9faaab8dbcc735701a289daef52f02433f0401667befd647798a"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.13-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "c70cf69d9551156344d81f16bfd3d0545b2f3ca7eec77977b5c97c33e37ca93a"
        ),
    ]
)
