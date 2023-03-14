//
//  Project.swift
//  Manifests
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.feature.rawValue),
    targets: [
        .init(
            name: Module.feature.rawValue,
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path),
                .project(target: Module.ui.rawValue, path: Module.ui.path),
                .target(name: "HomeFeature")
            ]
        ),
        .init(
            name: "HomeFeature",
            dependencies: [
                .project(target: Module.core.rawValue, path: Module.core.path),
                .project(target: Module.ui.rawValue, path: Module.ui.path)
              ]
        )
    ]
)

let project = factory.makeProject()
