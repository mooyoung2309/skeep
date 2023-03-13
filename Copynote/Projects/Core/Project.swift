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
                .project(target: Module.utils.rawValue, path: Module.utils.path),
                .target(name: "Extension"),
                .target(name: "Client"),
                .target(name: "Model")
            ]
        ),
        .init(
            name: "Extension",
            dependencies: [
                .project(target: Module.utils.rawValue, path: Module.utils.path)
              ]
        ),
        .init(
            name: "Client",
            dependencies: [
                .project(target: Module.utils.rawValue, path: Module.utils.path)
              ]
        ),
        .init(
            name: "Model",
            dependencies: [
                .project(target: Module.utils.rawValue, path: Module.utils.path)
            ]
        )
    ]
)

let project = factory.makeProject()
