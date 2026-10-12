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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.8/OneStepSDK.xcframework.zip",
            checksum: "c9e971c8b4c231cdbcd68ef01f190dfca477f2e1fb0845c4c5ba11c35c0d0a13"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.8/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "2f4f01ef75e7926337b7531515652b6b9efed706c04bcb8929af98b43dc4bb65"
        ),
    ]
)
