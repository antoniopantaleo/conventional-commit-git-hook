// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ConventionalCommit",
    platforms: [.macOS(.v11)],
    products: [
        .executable(
            name: "commit-msg",
            targets: ["Hook"]
        )
    ],
    targets: [
        .target(name: "ConventionalCommit"),
        .testTarget(
            name: "ConventionalCommitTests",
            dependencies: [
                .target(name: "ConventionalCommit")
            ]
        ),
        .executableTarget(
            name: "Hook",
            dependencies: [
                .target(name: "ConventionalCommit")
            ]
        )
    ]
)
