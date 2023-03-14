//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.core.rawValue),
    targets: [
        .init(
            name: Module.core.rawValue,
            dependencies: [
                .project(target: Module.network.rawValue, path: Module.network.path),
            ]
        )
    ]
)

let project = factory.makeProject()
