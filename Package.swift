// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDK",
    products: [
        .library(name: "OneStepSDK", targets: ["OneStepSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "OneStepSDK",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.12-core/OneStepSDK.xcframework.zip",
            checksum: "501ba0ca32d4093d63b168e1e4d39329b531ad2d7f1659b91e992196911bcf95"
        ),
    ]
)
