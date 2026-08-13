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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.3-rc4/OneStepSDK.xcframework.zip",
            checksum: "27d54c1c9fb0f760fdaccb35add2bb34876a219b70c8a82485c65357755cf8a5"
        ),
    ]
)
