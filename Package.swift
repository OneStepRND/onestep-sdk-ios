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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.8-rc3/OneStepSDK.xcframework.zip",
            checksum: "7fa9109da22cbdcc97c7b597e955a12ec3f502fac1fc746733b574674b049921"
        ),
    ]
)
