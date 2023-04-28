//
//  Project.swift
//  Manifests
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let targets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
                .feature(implements: .MyPage),
                .feature(implements: .Calendar),
                .feature(implements: .Todo),
                .feature(implements: .Memo),
                .domain
            ]
        )
    )
]

let project = Project.make(name: "Feature", targets: targets)
