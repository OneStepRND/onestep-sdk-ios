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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.22-core/OneStepSDK.xcframework.zip",
            checksum: "98fb06e51e63ad8ce35693f06da518ed8450dc528d3d95da1b21ebbf166c0d2a"
        ),
    ]
)
