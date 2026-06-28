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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.9/OneStepSDK.xcframework.zip",
            checksum: "437abfccb8789f7b7d22bcc1175c5804ad18b27109e542e07d08aebfdaa7bb9c"
        ),
    ]
)
