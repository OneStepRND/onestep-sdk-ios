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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.5-rc6/OneStepSDK.xcframework.zip",
            checksum: "c4ab88649618d09d0ee454931c2feef543a6d3297c118e80e218b0eb43a7db3e"
        ),
    ]
)
