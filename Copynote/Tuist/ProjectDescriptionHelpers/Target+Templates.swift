//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescription

extension Target {
    static func make(
        appName: String,
        targetName: String,
        platform: Platform,
        product: Product,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        dependencies: [TargetDependency]) -> Target {
            return Target(
                name: targetName,
                platform: platform,
                product: product,
                bundleId: "com.annapo.\(appName).\(targetName)",
                deploymentTarget: deploymentTarget,
                infoPlist: infoPlist,
                sources: ["Targets/\(targetName)/Sources/**"],
                resources: ["Targets/\(targetName)/Resources/**"],
                dependencies: dependencies,
                settings: .settings(base: .init())
            )
        }
}
