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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.6/OneStepSDK.xcframework.zip",
            checksum: "081c4cb72ff44189d4cec5ae103bcd37c70e870c716931568b0b191a471c1400"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.6/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "9bc2b42bf5a36954fc5c248322126774a03bcc1f703de9ecf55cda79567db4ef"
        ),
    ]
)
