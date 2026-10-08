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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.5-core/OneStepSDK.xcframework.zip",
            checksum: "b4750d1023846ff20adb582f6713b1aeb7e8d0747cc0263ca14f3c67296368ee"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.5-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "0ecad6ae6cf042dc0b68426a3ed1e4b6c183c9384c64cb445774414d6ab53426"
        ),
    ]
)
