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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.0-core/OneStepSDK.xcframework.zip",
            checksum: "5d0f5b28cf96a6c9784dc34a0ad89b143092072c69440555e2aded45e6f675ad"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.0-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "74b628e5851053f589ea2687a3403c8e871aa6144f2c116df5aa465a5d95f6f5"
        ),
    ]
)
