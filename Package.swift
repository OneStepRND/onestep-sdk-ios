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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.5/OneStepSDK.xcframework.zip",
            checksum: "b3d4934402b3700ad602119e702aa818e84948923188ee9fa69ea07fd6b63ef1"
        ),
    ]
)
