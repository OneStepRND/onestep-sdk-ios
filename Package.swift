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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.10-core/OneStepSDK.xcframework.zip",
            checksum: "6c2daaf5a830afa14ceb3e5ab9a173e59489e507ac03deda795235c8710a1049"
        ),
    ]
)
