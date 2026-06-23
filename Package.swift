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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.9-rc1/OneStepSDK.xcframework.zip",
            checksum: "7f03245a28743fdc4d1dd050ce6a9c26a1ac5cb79ad622269e17b4981b4b2cb8"
        ),
    ]
)
