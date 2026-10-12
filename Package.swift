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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.8-core/OneStepSDK.xcframework.zip",
            checksum: "1feda259de97932e310c192c538ad8beb795c268468f54ae6cb7d0b0631f5616"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.8-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "cfd36b10de2e5c1fc4e91d68cd2bf83ebdea663f46351b426bfb5ffbac71361d"
        ),
    ]
)
