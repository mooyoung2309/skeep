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
        implements: .Memo,
        factory: .init(
            dependencies: [
                .feature(interface: .Memo),
                .domain(implements: .Task)
            ]
        )
    ),
    .feature(
        interface: .Memo,
        factory: .init()
    )
]

let project = Project.make(name: "FeatureMemo", targets: targets)
