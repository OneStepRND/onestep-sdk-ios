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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.6/OneStepSDK.xcframework.zip",
            checksum: "ad5b4490fdf7ecce43e7dc81397a484ac080eba3895ffa71e71a1b80a367a089"
        ),
    ]
)
