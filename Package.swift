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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.1-rc1/OneStepSDK.xcframework.zip",
            checksum: "a34387284e7a18e3e3b22cefaf3bae8cda2782ce0a99b579c1d49b9d830ac1ee"
        ),
    ]
)
