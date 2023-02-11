// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "meilisearch-nio-examples",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "VaporApp",
      targets: ["VaporApp"]
    ),
    .executable(name: "RunVapor", targets: ["RunVapor"]),
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    // in real-world projects this would be
    // .package(url: "https://github.com/kaishin/meilisearch-nio.git", from: "1.0.0")
    .package(name: "meilisearch-nio", path: "../"),
  ],
  targets: [
    .target(
      name: "VaporApp",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "MeilisearchNIO", package: "meilisearch-nio")
      ],
      swiftSettings: [
        .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
      ]
    ),
    .executableTarget(name: "RunVapor", dependencies: [.target(name: "VaporApp")]),
  ]
)
