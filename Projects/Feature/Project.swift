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
                .project(target: Module.featureHome.rawValue, path: Module.featureHome.path)
            ]
        )
    ]
)

let project = factory.makeProject()
