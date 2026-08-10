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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.2-rc3/OneStepSDK.xcframework.zip",
            checksum: "f1c8574cb68fdc2ce74f76dfbb912bb9484ff1d233e3996630a7ca979e29d497"
        ),
    ]
)
