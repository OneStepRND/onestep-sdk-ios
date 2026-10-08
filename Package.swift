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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.3-core/OneStepSDK.xcframework.zip",
            checksum: "a877c3bfc8e66247cdd35287e453c3e2aa6326b3acf796fc436d840703955603"
        ),
    ]
)
