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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.3/OneStepSDK.xcframework.zip",
            checksum: "548db49f567c3ab9a16e6cffcf07b44cea1fb9c046a2258c55510d5bf4bf0fec"
        ),
    ]
)
