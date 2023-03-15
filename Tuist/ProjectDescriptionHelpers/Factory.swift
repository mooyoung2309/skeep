//
//  Factory.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescription

public struct ProjectFactory {
    var project: ProjectItem
    var targets: [TargetItem]
    
    public init(project: ProjectItem, targets: [TargetItem]) {
        self.project = project
        self.targets = targets
    }
    
    public func makeProject() -> Project {
        return .init(
            name: project.name,
            organizationName: project.organizationName,
            packages: project.packages,
            settings: project.settings,
            targets: targets.map { item in
                return Target.make(
                    appName: project.organizationName,
                    targetName: item.name,
                    platform: item.platform,
                    product: item.product,
                    deploymentTarget: item.deploymentTarget,
                    havResource: item.havResource,
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
    var packages: [Package]
    var settings: Settings
    
    public init(
        name: String,
        organizationName: String = "Copynote",
        packages: [Package] = [],
        settings: Settings = .settings()
    ) {
        self.name = name
        self.organizationName = organizationName
        self.packages = packages
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
    var havResource: Bool
    var dependencies: [TargetDependency]
    
    public init(
        name: String,
        platform: Platform = .iOS,
        product: Product = .framework,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: [.iphone]),
        infoPlist: InfoPlist = .default,
        havResource: Bool = false,
        dependencies: [TargetDependency] = []
    ) {
        self.name = name
        self.platform = platform
        self.product = product
        self.deploymentTarget = deploymentTarget
        self.infoPlist = infoPlist
        self.havResource = havResource
        self.dependencies = dependencies
    }
}
