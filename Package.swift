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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.0-rc5/OneStepSDK.xcframework.zip",
            checksum: "436bae64ab01a6cddecfd9b807414d57a186825c5c05024eb34ad86ed2c5d007"
        ),
    ]
)
