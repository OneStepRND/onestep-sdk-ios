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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.1/OneStepSDK.xcframework.zip",
            checksum: "d631d5aa8ecaf6a067feae6dbdcd5d73e9e7b6162974681b8974d3033809a672"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.1/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "874ba9ed7d96a81ff9cd408659188722e11be5d368d34c65b93ad6554aca5b9a"
        ),
    ]
)
