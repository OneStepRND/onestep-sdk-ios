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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.9/OneStepSDK.xcframework.zip",
            checksum: "2f19dfbb7938cc51f5b499cd79460ca20a81f16d0654698c0751df7f1b6bb580"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.9/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "6aa5c7f6e903554341f8d897bd587e6f5615c04003edca3519ae4e0708e51140"
        ),
    ]
)
