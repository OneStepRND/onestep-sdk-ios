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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.4.8-core/OneStepSDK.xcframework.zip",
            checksum: "89832eff16f41ec05cf031543701a48e1699094bda2150ba6c366cabfb68fc4a"
        ),
    ]
)
