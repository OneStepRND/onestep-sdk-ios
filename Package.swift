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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.11-rc1/OneStepSDK.xcframework.zip",
            checksum: "68c5db2ac486b35071cd0e74ab8efb88176acb67826b51a1e2c2711078da37ca"
        ),
    ]
)
