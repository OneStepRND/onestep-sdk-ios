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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.2-rc4/OneStepSDK.xcframework.zip",
            checksum: "480e2a720e4d0797a5560943daec358cfe02418e2b26b3afaa72006b77424899"
        ),
    ]
)
