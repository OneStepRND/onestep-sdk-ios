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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.6/OneStepSDK.xcframework.zip",
            checksum: "76414754115ffa1914347302d3cd0f35be72bf4aba68b3231094f02f89b4de74"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.6/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "780c450800113c00d4bdf3f55fc0aea710ad38e7012fda2cb4e88dbb6abf82d2"
        ),
    ]
)
