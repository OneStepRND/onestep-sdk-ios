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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.0-rc1/OneStepSDK.xcframework.zip",
            checksum: "8f80de119358ed0f46e1e3e0743d2e91bdd9265da24e16c1c0ce20d39e1164f7"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.0-rc1/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "98b8d0729698f4eddcf7962854c2c02646d11dd013f3ee411648c153df69f8d3"
        ),
    ]
)
