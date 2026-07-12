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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.12/OneStepSDK.xcframework.zip",
            checksum: "7108f5b02abec31fc9908c9ae5fd85b07433dc2ce381435af20a7dfc42761b6f"
        ),
    ]
)
