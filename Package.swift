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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.3.3-rc1/OneStepSDK.xcframework.zip",
            checksum: "e3d7c6c76ca0372248a51340f37636a80d03c96a799f9e9fe75e84258b4daa84"
        ),
    ]
)
