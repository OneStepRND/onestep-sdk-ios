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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc2/OneStepSDK.xcframework.zip",
            checksum: "517b9fbecab99156c791c083f6f46c7dfefe866ada71820f448f44c4a93d9ae0"
        ),
    ]
)
