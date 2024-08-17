// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../Networking")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Networking"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]),
    ]
)
