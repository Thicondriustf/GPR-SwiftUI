// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkingLayer",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NetworkingLayer",
            targets: ["NetworkingLayer"]),
    ],
    targets: [
        .target(
            name: "NetworkingLayer",
            dependencies: []),
        .testTarget(
            name: "NetworkingLayerTests",
            dependencies: ["NetworkingLayer"]),
    ]
)
