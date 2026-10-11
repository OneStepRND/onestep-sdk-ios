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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.7-core/OneStepSDK.xcframework.zip",
            checksum: "31c27e89dae507f44db2ee453e0d08a025059a2cc7454b41bf8ab349144a16ee"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.7-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "5203159877d83640617baa13aec57673f9ea85022ca805639d7bbd4efe17f4da"
        ),
    ]
)
