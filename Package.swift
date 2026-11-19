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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.9-core/OneStepSDK.xcframework.zip",
            checksum: "0380f354f91c60d6887fa185415f71c26f822bd21b414ff92b1a429044086b39"
        ),
    ]
)
