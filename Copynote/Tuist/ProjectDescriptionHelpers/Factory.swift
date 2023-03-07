//
//  Factory.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescription

public protocol ProjectFactory {
    var project: ProjectItem { get }
    var targets: [TargetItem] { get }
    
    func make() -> Project
}

extension ProjectFactory {
    func make() -> Project {
        return .init(
            name: project.name,
            organizationName: project.organizationName,
            settings: project.settings,
            targets: targets.map { item in
                return Target.make(
                    appName: project.organizationName,
                    targetName: item.name,
                    platform: item.platform,
                    product: item.product,
                    deploymentTarget: item.deploymentTarget,
                    infoPlist: item.infoPlist,
                    dependencies: item.dependencies
                )
            }
        )
    }
}

// MARK: ProjectItem
/// project info model
///
public struct ProjectItem {
    var name: String
    var organizationName: String
    var settings: Settings
    
    public init(name: String, organizationName: String, settings: Settings) {
        self.name = name
        self.organizationName = organizationName
        self.settings = settings
    }
}

// MARK: TargetItem
/// target info model
///
public struct TargetItem {
    var name: String
    var platform: Platform
    var product: Product
    var deploymentTarget: DeploymentTarget
    var infoPlist: InfoPlist
    var dependencies: [TargetDependency]
}
