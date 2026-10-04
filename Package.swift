// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "AppDiscoverySDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "AppDiscoverySDK", targets: ["AppDiscoverySDK"])
    ],
    targets: [
        .binaryTarget(
            name: "AppDiscoverySDK",
            url: "https://github.com/appdiscoverysdk/appdiscovery-ios/releases/download/1.0.0/AppDiscoverySDK.xcframework.zip",
            checksum: "42d4c0bc37c27621b6999424d86bb6dca83d9ceafe66c4c43d8f16dcdf104b5a"
        )
    ]
)
