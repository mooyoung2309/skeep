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
        implements: .Calendar,
        factory: .init(
            dependencies: [
                .feature(interface: .Calendar),
                .domain(implements: .Task)
            ]
        )
    ),
    .feature(
        interface: .Calendar,
        factory: .init()
    )
]

let project = Project.make(name: "FeatureCalendar", targets: targets)
