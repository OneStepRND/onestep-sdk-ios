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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.6-rc1/OneStepSDK.xcframework.zip",
            checksum: "81e94d0707c26408978f72b65a2bc63cca296b99f1e28c55be78d3b02285055a"
        ),
    ]
)
