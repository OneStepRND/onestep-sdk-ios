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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.7-rc1/OneStepSDK.xcframework.zip",
            checksum: "d4e6f5913602874eae6626d0b7a4ed916de6f1b156b10cadb7dcffea28ecb64e"
        ),
    ]
)
