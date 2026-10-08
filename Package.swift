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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.6-core/OneStepSDK.xcframework.zip",
            checksum: "bfa57dd5bb744b79e5f36f21f270c4ae79da77b8c2c59d82f7f8137b0a069d0f"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.6-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "7c9c10d4395d1ea3513bb517820f1afe1291755cde46b04442185cd323e98dc1"
        ),
    ]
)
