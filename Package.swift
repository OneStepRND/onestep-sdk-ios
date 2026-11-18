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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.8/OneStepSDK.xcframework.zip",
            checksum: "95fb75b672d20d2355909de1c7ceea3d82c23f8d3a14df6d46a7a509d9ccc9c2"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.8/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "185e3499d3a839ca973a0a1466e4c575030779e2ccadce50ae12b351f9d03ad2"
        ),
    ]
)
