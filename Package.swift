// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "clia",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.7.0")
    ],
    targets: [
        .executableTarget(
            name: "clia",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)
