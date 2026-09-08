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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.0-rc1/OneStepSDK.xcframework.zip",
            checksum: "32d38f16a15e0320a62c7e742017fdc5dbd2f6f1e50ce721dc6f64fef3b97b82"
        ),
    ]
)
