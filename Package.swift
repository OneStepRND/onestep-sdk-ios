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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.2-rc5/OneStepSDK.xcframework.zip",
            checksum: "905528b4e0545f44adb715337fa45446f9ee30749533f8887d991dd6c33117fa"
        ),
    ]
)
