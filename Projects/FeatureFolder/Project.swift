//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/15.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.featureFolder.rawValue),
    targets: [
        .init(
            name: Module.featureFolder.rawValue,
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path),
                .project(target: Module.ui.rawValue, path: Module.ui.path),
                .project(target: Module.utils.rawValue, path: Module.utils.path)
            ]
        )
    ]
)

let project = factory.makeProject()
