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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.17/OneStepSDK.xcframework.zip",
            checksum: "f156a7f2c075b94199d24ad820012d3f104ec6fae23ffc5ebb75c17580e8ac7f"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.17/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "92bc0db4d2612ade6fc3e6556824ea24158f39e5f892edc717c8571eef0882be"
        ),
    ]
)
