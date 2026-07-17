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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.0-rc1/OneStepSDK.xcframework.zip",
            checksum: "6402629c013d07a0554eaa6c878b7bd411b1d72faf2f11a40a00af7013417490"
        ),
    ]
)
