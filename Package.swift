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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.5/OneStepSDK.xcframework.zip",
            checksum: "4498ce954f7c18e000361b0174b85453a59cb831b350fe8d94f29f78ef6f0b54"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.5/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "f51e48ae5b7decb04cb643d323cf9b85b6c4c9973ae2cfe367d5caa116530b24"
        ),
    ]
)
