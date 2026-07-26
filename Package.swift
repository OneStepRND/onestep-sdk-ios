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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.0-rc3/OneStepSDK.xcframework.zip",
            checksum: "c2750b63c30ed0924e798ff7b3fa2fc746798f814bc32fb55a86cb27b8a23779"
        ),
    ]
)
