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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.7/OneStepSDK.xcframework.zip",
            checksum: "0b9d252d2a83601a4c9b5524fc2578628cd75326c2f8cd5bbb398bd659e9b600"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.7/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "c7ea788e476cac6755ff13511fde3c1bd82500b3a2f9b25de81c91be6a6b8844"
        ),
    ]
)
