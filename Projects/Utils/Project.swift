//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(
        name: Module.utils.rawValue,
        packages: [
            .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.51.0")),
            .remote(url: "https://github.com/realm/realm-swift.git", requirement: .upToNextMajor(from: "10.31.0"))
        ]
    ),
    targets: [
        .init(
            name: Module.utils.rawValue,
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "RealmSwift")
            ]
        )
    ]
)

let project = factory.makeProject()
