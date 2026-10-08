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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.3/OneStepSDK.xcframework.zip",
            checksum: "509321025061fc91fa5d33f092317ca86a4a0c9ef93584bd673327a6dbf19378"
        ),
    ]
)
