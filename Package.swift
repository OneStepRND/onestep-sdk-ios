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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.7-rc4/OneStepSDK.xcframework.zip",
            checksum: "3bdf19679eaba8d2a10e006d01494a5da323a70a59cd48deff230e794c79b930"
        ),
    ]
)
