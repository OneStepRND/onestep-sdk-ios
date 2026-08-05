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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.1-rc5/OneStepSDK.xcframework.zip",
            checksum: "ac4a24bfc73e17e874d898503d97daa97a85d268bc55a126a0e1429edfeb1733"
        ),
    ]
)
