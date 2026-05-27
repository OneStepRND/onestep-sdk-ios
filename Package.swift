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
            url: "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/2.0.4-rc4/OneStepSDK.xcframework.zip",
            checksum: "8c00e2defb6b95e8ad5000eea4a81a7bdaf9d92a442e0aad8e723e622f858a2f"
        ),
    ]
)
