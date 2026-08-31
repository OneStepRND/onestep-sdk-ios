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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.2.0-rc1/OneStepSDK.xcframework.zip",
            checksum: "d5d0313da4eb3594598e2e0c7c1a50579935d49fc3237a82eee58fc107404cac"
        ),
    ]
)
