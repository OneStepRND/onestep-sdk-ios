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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.0-rc1/OneStepSDK.xcframework.zip",
            checksum: "e40d9c5c478dfcaa4a978aa773468ce7f9afc3c8b88c78ae28dd5d94079efa19"
        ),
    ]
)
