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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.0/OneStepSDK.xcframework.zip",
            checksum: "257e27898832fc9dd9d84645123caf104da67fadbc5dc466ca4ffe9523bb0d4d"
        ),
    ]
)
