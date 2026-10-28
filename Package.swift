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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.21/OneStepSDK.xcframework.zip",
            checksum: "a9f1bc27f17f5588d13dba5a26d2eb9de0d7f3a2be442b97ab1b49c109a49ac1"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.21/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "55a496911e48968536de210d36bd232b8d46e9245c8001fd788886bb65d88ef0"
        ),
    ]
)
