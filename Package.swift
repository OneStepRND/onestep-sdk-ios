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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.8-rc1/OneStepSDK.xcframework.zip",
            checksum: "9e2cc63d959d80a53483fd061727cd5664ff264ece49e419c89dbba1e245ae87"
        ),
    ]
)
