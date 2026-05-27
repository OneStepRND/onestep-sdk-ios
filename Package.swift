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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.4-rc3/OneStepSDK.xcframework.zip",
            checksum: "930b1cc450c74f29ef606c8200e89c88d6ee009292caa21828513051396d9528"
        ),
    ]
)
