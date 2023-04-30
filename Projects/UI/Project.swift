//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.ui.rawValue),
    targets: [
        .init(
            name: Module.ui.rawValue,
            dependencies: [
                .project(target: Module.utils.rawValue, path: Module.utils.path)
            ]
        )
    ]
)

let project = factory.makeProject()
