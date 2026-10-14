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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.12-core/OneStepSDK.xcframework.zip",
            checksum: "f7e112f3bb3c6447b1cdcf615e24c3cbe232b080929c14d4b8be81940fcc8ac2"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.12-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "60e799d70f3a5aaa031b41886299f4ab1bce1e705c601cae386322b9276cdd01"
        ),
    ]
)
