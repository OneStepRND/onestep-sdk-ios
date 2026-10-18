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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.13/OneStepSDK.xcframework.zip",
            checksum: "1e28c9b2b09a42bccf9de2c631d5bd42a7a06588742fc6c9bb2ee67f6fb2115c"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.13/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "d9b8958c8d070c2a843ac0cd948c13ba2dc0459b1544b8978f2ad1f5086ec8ea"
        ),
    ]
)
