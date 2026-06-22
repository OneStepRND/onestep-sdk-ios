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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.8-rc4/OneStepSDK.xcframework.zip",
            checksum: "2eddf9ed21bed453cf841e51ca0d17f3ba7ab36fa54e95351358ecaf717b24b6"
        ),
    ]
)
