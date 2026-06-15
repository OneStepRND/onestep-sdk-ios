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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.7-rc2/OneStepSDK.xcframework.zip",
            checksum: "d06557974c9d1a2549049f60ffaee3c34bb136a1c366dfdcaf5915c7a47ec4bb"
        ),
    ]
)
