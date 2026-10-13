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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.11-core/OneStepSDK.xcframework.zip",
            checksum: "f77569f6fab96495a47984e9a6ae05359146ef322f46c8db77695dd81c78355c"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.11-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "acc5f0045ce08df6fd99d9e2c88a1c66676a2e857828bf960ecbce9b7dae102a"
        ),
    ]
)
