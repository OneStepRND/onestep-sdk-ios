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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.18/OneStepSDK.xcframework.zip",
            checksum: "e9da82a5179cbe36d12ec7f2fecbe8b239e675b3cbe8b02dc52f04b5bde591c2"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.18/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "c62c6f1e768a5469f093493df9d1cfccbd07bd19da08884827d2d74b04086d82"
        ),
    ]
)
