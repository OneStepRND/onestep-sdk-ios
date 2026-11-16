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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.7-core/OneStepSDK.xcframework.zip",
            checksum: "1448195e3e29cd9c32dbc6ea5972482f0d18925cfbf17ccb3c48002612c5c8f4"
        ),
    ]
)
