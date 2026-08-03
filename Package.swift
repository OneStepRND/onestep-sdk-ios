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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.1-rc3/OneStepSDK.xcframework.zip",
            checksum: "a4eb8e9bf2fa35623d6ce7171390c2134c764f4127fafa94297c39957a22ff49"
        ),
    ]
)
