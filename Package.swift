// swift-tools-version: 5.8.1

import PackageDescription

let package = Package(
    name: "ConventionalCommit",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "commit-msg",
            targets: ["Hook"]
        )
    ],
    targets: [
        .target(
            name: "ConventionalCommit",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        ),
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
        ),
        .testTarget(
            name: "HookTests"
        )
    ]
)
