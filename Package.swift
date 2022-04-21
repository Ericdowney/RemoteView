// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteView",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RemoteView",
            targets: ["RemoteView"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Flight-School/AnyCodable",
            from: "0.6.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RemoteView",
            dependencies: ["AnyCodable"]),
        .testTarget(
            name: "RemoteViewTests",
            dependencies: ["RemoteView"]),
    ]
)
