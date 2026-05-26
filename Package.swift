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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.4-rc2/OneStepSDK.xcframework.zip",
            checksum: "1987574804c09d83e7375bb942ca85cb67a994a636ee8687b05d4e766d3db4d0"
        ),
    ]
)
