//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/04/28.
//

import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let targets: [Target] = [
    .shared(
        implements: .ThirdPartyLib,
        factory: .init(
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "RealmSwift")
            ]
        )
    )
]

let project = Project.make(
    name: "SharedThirdPartyLib",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.51.0")),
        .remote(url: "https://github.com/realm/realm-swift.git", requirement: .upToNextMajor(from: "10.31.0"))
    ],
    targets: targets
)
