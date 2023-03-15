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
                .project(target: Module.featureFolder.rawValue, path: Module.featureFolder.path),
                .project(target: Module.featureCalendar.rawValue, path: Module.featureCalendar.path),
                .project(target: Module.featureList.rawValue, path: Module.featureList.path)
            ]
        )
    ]
)

let project = factory.makeProject()
