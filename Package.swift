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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.5/OneStepSDK.xcframework.zip",
            checksum: "86a31bbb7f4f20c9f98c64ea5ad175976fde8607eb8dc8d330299aaa653fc06a"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.5/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "aa062616a5bb144890d94b3f8bfc3c9e0c9c9df9bdc246872f2d4971353323a6"
        ),
    ]
)
