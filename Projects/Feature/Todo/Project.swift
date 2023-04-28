//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/04/28.
//

import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let targets: [Target] = [
    .feature(
        implements: .Todo,
        factory: .init(
            dependencies: [
                .feature(interface: .Todo),
                .domain(implements: .Task)
            ]
        )
    ),
    .feature(
        interface: .Todo,
        factory: .init()
    )
]

let project = Project.make(name: "FeatureTodo", targets: targets)
