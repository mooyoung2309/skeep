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
                .project(target: Module.core.rawValue, path: Module.core.path),
                .target(name: "Extension"),
                .target(name: "View")
            ]
        ),
        .init(
            name: "Extension",
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path)
              ]
        ),
        .init(
            name: "View",
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path)
              ]
        )
    ]
)

let project = factory.makeProject()
