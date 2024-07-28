// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "About",
            targets: ["About"]),
        .library(
            name: "Setup",
            targets: ["Setup"]),
        .library(
            name: "Feed",
            targets: ["Feed"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(url: "https://github.com/nmdias/FeedKit", exact: "9.1.2"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.55.1")
    ],
    targets: [
        .target(
            name: "About",
            dependencies: [
                "Core"
            ],
            path: "Sources/Features/About",
            resources: [
                .process("Data/Licenses.plist")
            ],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .target(
            name: "Setup",
            dependencies: [
                "Core"
            ],
            path: "Sources/Features/Setup",
            resources: [
                .copy("Data/sources.json"),
            ],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .target(
            name: "Feed",
            dependencies: [
                "Core",
                "FeedKit"
            ],
            path: "Sources/Features/Feed",
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .testTarget(
            name: "FeedTests",
            dependencies: ["Feed"],
            path: "Tests/Features/Feed"
        )
    ]
)
