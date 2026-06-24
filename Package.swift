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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.9-rc2/OneStepSDK.xcframework.zip",
            checksum: "f2517335fc0aa656480c61b5f3ecb9fc3f847d6086a79c928d9c751508303cb4"
        ),
    ]
)
