// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneStepSDKiOS",
    products: [
        .library(
            name: "OneStepSDKiOS",
            targets: ["OneStepSDKiOS", "OneStepSDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/lynixliu/SwiftAvroCore", from: "0.0.0")
    ],
    targets: [
        .target(
            name: "OneStepSDKiOS",
            dependencies: ["OneStepSDK", .product(name: "SwiftAvroCore", package: "SwiftAvroCore")]
        ),
        .binaryTarget(name: "OneStepSDK", path: "Frameworks/OneStepSDK.xcframework"),
    ]
)
