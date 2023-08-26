// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Composer",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "Composer", targets: ["Composer"]),
        .library(name: "ComposerCombine", targets: ["ComposerCombine"]),
    ],
    dependencies: [], 
    targets: [
        .target(name: "Composer", dependencies: []),
        .testTarget(name: "ComposerTests", dependencies: ["Composer"]),

        .target(name: "ComposerCombine", dependencies: [.init(stringLiteral: "Composer")]),
    ],
    swiftLanguageVersions: [.v5]
)
