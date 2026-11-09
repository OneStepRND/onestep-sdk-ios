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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.4/OneStepSDK.xcframework.zip",
            checksum: "65a7de13cd6f5f901ebf2274ea36ac75e89285de16ff31183054c8e00b449bf5"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.4/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "d0459dd80eb0ac0369cdff16597386cd3600328e8087c4eb12825607a136d3d2"
        ),
    ]
)
