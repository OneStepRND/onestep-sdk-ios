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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.4/OneStepSDK.xcframework.zip",
            checksum: "9e6805cd9c9dc2a8402d225c72e641fc8bcca5132f16e0465cfb8d1af5add57a"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.4/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "3a379c64d8c65864f8a329d104fa1948b8ef7b3685c81c4e9a4ad7da08e1a60c"
        ),
    ]
)
