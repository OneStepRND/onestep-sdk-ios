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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.10/OneStepSDK.xcframework.zip",
            checksum: "838ec89c11fdbed8afad6068aebbec6cb6d184b30c6c1ea1fcc2c51d61d9fe69"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.10/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "8a4bb4774075e794a99acd9ba03ca6fe01f0b1d05cb6312b7834e4379a81e5e7"
        ),
    ]
)
