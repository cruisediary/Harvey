// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Harvey",
    products: [
        .library(
            name: "Harvey",
            targets: ["Harvey"]),
    ],
    targets: [
        .target(
            name: "Harvey",
            dependencies: []),
        .testTarget(
            name: "HarveyTests",
            dependencies: ["Harvey"]),
    ]
)
