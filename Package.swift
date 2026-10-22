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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.15/OneStepSDK.xcframework.zip",
            checksum: "aff5e8936fae1f38f95540db4277d1cea139d84461e09b6e4dba6d12490eb4c1"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.15/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "f2be016478af6f870f429db9307daad75cbdfe67246e8c29cfa6626833e256dc"
        ),
    ]
)
