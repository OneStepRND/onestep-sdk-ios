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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.19-core/OneStepSDK.xcframework.zip",
            checksum: "3543b6784c0c403f7fcaec0ba0990b292c7c516d683e5c2819e890fc4b51e487"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.19-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "f2f431501264c7a4ac43166eea076842e897356af5d361cd34300daa1c9f87a1"
        ),
    ]
)
