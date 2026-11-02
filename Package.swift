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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.1-core/OneStepSDK.xcframework.zip",
            checksum: "b373410fec4914a6ab149b3fb959a9d7efcd8b6cab70450c0cfc1559736b3e88"
        ),
    ]
)
