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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.21-core/OneStepSDK.xcframework.zip",
            checksum: "e00cc84bef5bb0133d22e951562825364d2771ab680c3a1ce3186742d0887697"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.21-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "ce922204f93cedfe1916a086b60ae9f1fe07d18deb23317de1782d7d1b2a51f8"
        ),
    ]
)
