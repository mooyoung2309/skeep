//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let targets: [Target] = [
    .app(
        implements: .IOS,
        factory: .init(
            dependencies: [
                .feature
            ]
        )
    )
]

let project = Project.make(name: "App", targets: targets)
