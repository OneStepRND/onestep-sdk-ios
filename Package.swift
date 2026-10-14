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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.12/OneStepSDK.xcframework.zip",
            checksum: "0ac8f213bb255a88f23a9d0d605cc6f155ca238c7528053f349117c79b0c1681"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.12/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "dbac0858cce30c8742b62c3fe97798cc16a68abd40f8904bd57c7c8bedea79d7"
        ),
    ]
)
