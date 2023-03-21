//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/15.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.featureToDo.rawValue),
    targets: [
        .init(
            name: Module.featureToDo.rawValue,
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path),
                .project(target: Module.ui.rawValue, path: Module.ui.path)
            ]
        )
    ]
)

let project = factory.makeProject()
