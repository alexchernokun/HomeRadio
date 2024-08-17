// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioPlayer",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RadioPlayer",
            targets: ["RadioPlayer"]),
    ],
    dependencies: [
        .package(path: "../AppLogger")
    ],
    targets: [
        .target(
            name: "RadioPlayer",
            dependencies: ["AppLogger"]
        ),
        .testTarget(
            name: "RadioPlayerTests",
            dependencies: ["RadioPlayer"]),
    ]
)
