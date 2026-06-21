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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.8-rc2/OneStepSDK.xcframework.zip",
            checksum: "82489ca5fbefcf4d6fa25ac0cceb811c50987999e1d9cbbfe14882bf39813cb4"
        ),
    ]
)
