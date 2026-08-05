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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.1/OneStepSDK.xcframework.zip",
            checksum: "18a196a6bfe9bac24aef58440f1e943bb10a7108a3277dbc9819d46ba824d7ac"
        ),
    ]
)
