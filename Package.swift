// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Gestures",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Gestures", targets: ["Gestures"]),
    ],
    targets: [
        .target(name: "Gestures", dependencies: []),
    ]
)
