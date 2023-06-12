// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCAssetsGenerator",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/xnth97/AssetKit.git", from: "1.2.0")
    ],
    targets: [
        .executableTarget(
            name: "XCAssetsGenerator",
            dependencies: [
                .byName(name: "AssetKit")
            ]
        )
    ]
)
