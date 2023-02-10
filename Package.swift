// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MeilisearchNIO",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "MeilisearchNIO",
      targets: ["MeilisearchNIO"])
  ],
  dependencies: [
    .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.13.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "MeilisearchNIO",
      dependencies: [
        .product(name: "AsyncHTTPClient", package: "async-http-client")
      ]
    ),
    .testTarget(
      name: "MeilisearchNIOTests",
      dependencies: ["MeilisearchNIO"]),
  ]
)
