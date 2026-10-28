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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.19/OneStepSDK.xcframework.zip",
            checksum: "c38c742bf62807abfa1cea17d5b592312d97f9a4c4f4b3fd37464efebe3656cf"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.19/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "0e97c5145f319a432cd46b4709fce52ab7d7a41d3b5d2caae5bcda2c444b0529"
        ),
    ]
)
