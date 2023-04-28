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
    .shared(
        factory: .init(
            dependencies: [
                .shared(implements: .ThirdPartyLib)
            ]
        )
    )
]

let project = Project.make(
    name: "Shared",
    targets: targets
)
