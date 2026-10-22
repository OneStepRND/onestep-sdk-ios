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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.15-core/OneStepSDK.xcframework.zip",
            checksum: "b4d1466cee385a23d5073695b8bc042ffece5aa039c825909675e7afe7f22dfb"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.15-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "49e125d6e728e41cbe6c0f74e152155d00a95a0598c1f83e55b79f10c271cc31"
        ),
    ]
)
