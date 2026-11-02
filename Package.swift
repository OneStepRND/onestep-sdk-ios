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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.2/OneStepSDK.xcframework.zip",
            checksum: "cf2946931dbb87afa3e6d6dbe55e0a951e129fbb96364409f48e09b6315d0a11"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.2/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "c400a4f1ee2cbe9249eced00c030af4b20267a34e6d655e867be4ad03f7671c5"
        ),
    ]
)
