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
        implements: .MyPage,
        factory: .init(
            dependencies: [
                .feature(interface: .MyPage),
                .domain(implements: .Task)
            ]
        )
    ),
    .feature(
        interface: .MyPage,
        factory: .init()
    )
]

let project = Project.make(name: "FeatureMyPage", targets: targets)
