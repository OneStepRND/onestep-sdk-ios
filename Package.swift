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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.9-rc4/OneStepSDK.xcframework.zip",
            checksum: "473dda4529b6d16ef5575d3ceb9ccee6618894fcc17e24e86be53bf4b010e7fc"
        ),
    ]
)
