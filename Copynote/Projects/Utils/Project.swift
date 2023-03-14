//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.utils.rawValue),
    targets: [
        .init(
            name: Module.utils.rawValue,
            dependencies: [
                .external(name: "Realm"),
                .external(name: "RealmSwift"),
                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)

let project = factory.makeProject()
