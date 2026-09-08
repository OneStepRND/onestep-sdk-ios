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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.0-rc4/OneStepSDK.xcframework.zip",
            checksum: "ace52077f72daf9d4ba00dc346846fd7abfa4bc09bf8a234165e4cbda22ed2c4"
        ),
    ]
)
