// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefreshControl",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RefreshControl",
            targets: ["RefreshControl"]),
    ],
    targets: [
        .target(
            name: "RefreshControl"),
        .testTarget(
            name: "RefreshControlTests",
            dependencies: ["RefreshControl"]),
    ]
)