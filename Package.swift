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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.4-core/OneStepSDK.xcframework.zip",
            checksum: "161c4def6a6b5bcb0baedbae9f1123d5ba019e5683e0bf1d6311d2bfa19750f4"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.4-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "219096a81c111a4d39335350f47eddf55d2bd20789d8fc8619670d7ce9f8a80b"
        ),
    ]
)
