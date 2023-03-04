//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2022/12/29.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.51.0"))
])

let crt = CarthageDependencies([
    .github(path: "realm/realm-swift", requirement: .exact("10.31.0"))
])

let dependencies = Dependencies(
    carthage: crt,
    swiftPackageManager: spm,
    platforms: [.iOS]
)
