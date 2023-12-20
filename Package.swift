// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseAuthentication",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "FirebaseAuthentication",
            targets: ["FirebaseAuthentication"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: Version("10.0.0"))),
        .package(url: "https://github.com/google/GoogleSignIn-iOS", .upToNextMajor(from: Version("7.0.0"))),
    ],
    targets: [
        .target(
            name: "FirebaseAuthentication",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS")
            ]
        ),
        .testTarget(
            name: "FirebaseAuthenticationTests",
            dependencies: ["FirebaseAuthentication"]),
    ]
)
