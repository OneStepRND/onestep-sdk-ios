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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.9-rc3/OneStepSDK.xcframework.zip",
            checksum: "a9856650ccf7e7d666d56c26039d36c55824859e658bb6f362f8384cf838532b"
        ),
    ]
)
