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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.11/OneStepSDK.xcframework.zip",
            checksum: "78fa7d51e77e90a65c2591f2e8b6aae2d1e6c544ac949a1bd931d4c406df61db"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.11/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "70c375df72dbe5850ab1435323d78d7ca070d168cd0db4cd3e3c402786a8358b"
        ),
    ]
)
