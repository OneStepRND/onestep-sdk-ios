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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.3-rc1/OneStepSDK.xcframework.zip",
            checksum: "d6ccc18f9cb4a47942221240faa03f84b6124b1f677598490da32d5a2309c1fb"
        ),
    ]
)
