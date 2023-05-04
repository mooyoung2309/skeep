//
//  Environment.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "Skeep"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
        public static let bundlePrefix = "com.annapo.skeep"
    }
}
