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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.10/OneStepSDK.xcframework.zip",
            checksum: "32bc373edc749ecc3225db5d044d96a6460553e412bd7c53851d9f4f31fd59f3"
        ),
    ]
)
