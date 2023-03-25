//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/26.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.featureAccount.rawValue),
    targets: [
        .init(
            name: Module.featureAccount.rawValue,
            dependencies: [
                .project(target: Module.featureCommon.rawValue, path: Module.featureCommon.path),
            ]
        )
    ]
)

let project = factory.makeProject()
