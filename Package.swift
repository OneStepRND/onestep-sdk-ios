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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.14/OneStepSDK.xcframework.zip",
            checksum: "6043c2fcb50ef6671d84646a8d386f238d1a5d21b8b5c9d144fef2c87991b8c9"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.14/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "6df2dc8a1c06bd442519dabe25cfedaa951c8f52b05b82e805bc20d36861bc66"
        ),
    ]
)
