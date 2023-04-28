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
    .core(
        factory: .init(
            dependencies: [
                
            ]
        )
    )
]

let project = Project.make(name: "Core", targets: targets)
