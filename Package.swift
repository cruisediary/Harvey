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
        .package(url: "https://github.com/sunshinejr/Quick.git", .branch("fix/spm_swift4")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.2"))
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
