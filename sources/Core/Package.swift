// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.62.2")
    ],
    targets: [
        .target(
            name: "Core",
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        )
    ]
)
