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
                .target(name: "ReusableUI"),
                .target(name: "HomeUI")
            ]
        ),
        .init(
            name: "ReusableUI",
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path)
              ]
        ),
        .init(
            name: "HomeUI",
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path)
              ]
        )
    ]
)

let project = factory.makeProject()
