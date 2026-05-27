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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.4-rc4/OneStepSDK.xcframework.zip",
            checksum: "a92103029be832df5e1b13a39ba9180ab16c54c9dbb053219dddcd6d095a90f9"
        ),
    ]
)
