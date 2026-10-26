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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.18-core/OneStepSDK.xcframework.zip",
            checksum: "8e01790efcb175bbc7c852a273ec8b7eb8351b1c643fd08ccae780e2449303e6"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.18-core/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "8c92231dce9891e1d556c7d01b1624c8673df7fce6fd5f7fb7cd88b948bdc0ed"
        ),
    ]
)
