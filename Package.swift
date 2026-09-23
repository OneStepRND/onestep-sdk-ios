// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDK",
    products: [
        .library(name: "OneStepSDK", targets: ["OneStepSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "OneStepSDK",
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.1/OneStepSDK.xcframework.zip",
            checksum: "54af1ca31770ad02bc82ef62731c7fbc33426e70e2b4bd9bd49541fbffd0aa80"
        ),
    ]
)
