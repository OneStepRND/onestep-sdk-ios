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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.7-rc2/OneStepSDK.xcframework.zip",
            checksum: "bef9802391d0c6773415147aaa04dfe1f4e5b07009c61a097835bfa09ca4ad58"
        ),
    ]
)
