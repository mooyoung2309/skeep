//
//  Module.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescription

public enum Module: String, CaseIterable {
    case application = "Application"
    case feature = "Feature"
    case domain = "Domain"
//    case featureMemo = "FeatureMemo"
//    case featureCalendar = "FeatureCalendar"
//    case featureTodo = "FeatureTodo"
//    case featureAccount = "FeatureAccount"
//    case featureCommon = "FeatureCommon"
    case core = "Core"
    case ui = "UI"
    case utils = "Utils"
    
    public var path: Path {
        return .relativeToRoot("Projects/\(self.rawValue)")
    }
}
