//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/05/04.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.domain.rawValue),
    targets: [
        .init(
            name: Module.domain.rawValue,
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path)
            ]
        )
    ]
)

let project = factory.makeProject()
