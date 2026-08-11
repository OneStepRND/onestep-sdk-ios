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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.1.2/OneStepSDK.xcframework.zip",
            checksum: "0944658740b76eb73ad092b352616b924b07ff4e3a2b53415591eaef3d4b953c"
        ),
    ]
)
