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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.16/OneStepSDK.xcframework.zip",
            checksum: "896eec40000df4b5540a328ada4e4327d52cb55b76cf5a691399ffc276493ea8"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.16/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "d07dbc6bd9d6ebba63de1980aa5f9dfaa94a6fdac0a8893e5d543d718eba35dc"
        ),
    ]
)
