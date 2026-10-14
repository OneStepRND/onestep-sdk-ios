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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.0/OneStepSDK.xcframework.zip",
            checksum: "d7ed59c18c830a82a1354d0991f0019484dbeb52cba393841a4f9f3fa47af2c4"
        ),
        .binaryTarget(
            name: "OneStepPrivateDataTransfer",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.0/OneStepPrivateDataTransfer.xcframework.zip",
            checksum: "66e13b28a38aa090bf53df336f8c3b64407b04e00de12054cf2313f172a4b931"
        ),
    ]
)
