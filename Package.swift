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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.3-rc3/OneStepSDK.xcframework.zip",
            checksum: "ef06ea5e1e8f6f9f37708263927477730df0eb711fbed93b84a5b79c36171cf3"
        ),
    ]
)
