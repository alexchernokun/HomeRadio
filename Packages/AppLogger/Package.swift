// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppLogger",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "AppLogger",
            targets: ["AppLogger"]),
    ],
    targets: [
        .target(
            name: "AppLogger"),
        .testTarget(
            name: "AppLoggerTests",
            dependencies: ["AppLogger"]),
    ]
)
