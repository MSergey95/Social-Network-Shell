// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Navigation 2",
    platforms: [
        .iOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/netology-code/iosint-homeworks.git", from: "2.2.0")
    ],
    targets: [
        .target(
            name: "Navigation 2",
            dependencies: ["iOSIntPackage"]),
        .testTarget(
            name: "Navigation 2Tests",
            dependencies: ["Navigation 2"]),
    ]
)