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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.14-hotfix1-core/OneStepSDK.xcframework.zip",
            checksum: "1c6182bb7fcdfed4f4bcee0b5ec566137ebf4d7ab384bbc827cbab87c1fd234d"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.14-hotfix1-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "6138f9df69dd576b02fef7e13ddf1dbaa36254e6dd9fbb1d4c5bc98a6720064e"
        ),
    ]
)
