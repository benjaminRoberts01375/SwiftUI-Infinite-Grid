// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfiniteGrid",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17)],
    products: [
        .library(
            name: "InfiniteGrid",
            targets: ["InfiniteGrid"]),
    ],
    targets: [
        .target(
            name: "InfiniteGrid",
            dependencies: []),
        .testTarget(
            name: "InfiniteGridTests",
            dependencies: ["InfiniteGrid"]),
    ]
)
