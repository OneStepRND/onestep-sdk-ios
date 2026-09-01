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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.2.0-rc2/OneStepSDK.xcframework.zip",
            checksum: "b0f1e4dd9b0a3c7d3f4142e70aae33ea4f8c5555b4fa895006956159a927c523"
        ),
    ]
)
