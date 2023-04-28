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
    .domain(
        implements: .Task,
        factory: .init(
            dependencies: [
                .domain(interface: .Task)
            ]
        )
    ),
    .domain(
        interface: .Task,
        factory: .init()
    )
]

let project = Project.make(name: "DomainTask", targets: targets)
