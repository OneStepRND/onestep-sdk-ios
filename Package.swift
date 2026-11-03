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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.3-core/OneStepSDK.xcframework.zip",
            checksum: "ddab4bc5f2e43bd81828d675388bcfb1b2fee97cfb9cea538eed2ab17f2da203"
        ),
    ]
)
