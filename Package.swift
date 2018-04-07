// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Harvey",
    products: [
        .library(
            name: "Harvey",
            targets: ["Harvey"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.3"))
    ],
    targets: [
        .target(
            name: "Harvey",
            dependencies: []),
        .testTarget(
            name: "HarveyTests",
            dependencies: [
                "Harvey",
                "Quick",
                "Nimble"
            ]),
    ]
)
