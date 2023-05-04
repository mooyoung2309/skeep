import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name,
    targets: [
        .feature(
            factory: .init(
                dependencies: [
                    .feature(implements: .Memo),
                    .feature(implements: .Todo),
                    .feature(implements: .Calendar),
                    .feature(implements: .MyPage),
                    .domain
                ]
            )
        )
    ]
)


////
////  Project.swift
////  ProjectDescriptionHelpers
////
////  Created by 송영모 on 2023/04/24.
////
//
//import ProjectDescription
//import ProjectDescriptionHelpers
//import DependencyPlugin
//
//let targets: [Target] = [
//    .feature(
//        factory: .init(
//            dependencies: [
//                .domain,
//                .feature(implements: .Memo),
//                .feature(implements: .Calendar),
//                .feature(implements: .Todo),
//                .feature(implements: .MyPage),
//            ]
//        )
//    )
//]
//
//let project: Project = .makeModule(
//    name: "Feature",
//    targets: targets
//)
