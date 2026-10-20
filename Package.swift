// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDK",
    products: [
        .library(name: "OneStepSDK", targets: ["OneStepSDK"]),
        .library(name: "OneStepPrivateDataTransfer", targets: ["OneStepPrivateDataTransfer"]),
    ],
    targets: [
        .binaryTarget(
            name: "OneStepSDK",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.14-core/OneStepSDK.xcframework.zip",
            checksum: "9e43b9566791e7fb39381aabdbbe8ab17bdd31a16e69ebfc8dd165ce4efaf6a5"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.14-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "daeff841db6c22e5b298b1c5cde3549bc9b6cd9ef67dd5d2df12462b914e5fb9"
        ),
    ]
)
