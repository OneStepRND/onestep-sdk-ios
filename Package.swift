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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.11-rc3/OneStepSDK.xcframework.zip",
            checksum: "f3ae905102351df301b665c17f0ce1a471ebdec09cacf5acc02a1fca84340e61"
        ),
    ]
)
