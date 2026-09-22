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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.0/OneStepSDK.xcframework.zip",
            checksum: "cad04df389bb09d5c64dca0acab5badfe1800abb9839e10f3f3f8d67a5657232"
        ),
    ]
)
