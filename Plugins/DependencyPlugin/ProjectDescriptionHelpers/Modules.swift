//
//  Modules.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

// MARK: AppModule

public enum AppModule: String, CaseIterable {
    public static let name: String = "App"

    case IOS
}

// MARK: FeatureModule

public enum FeatureModule: String, CaseIterable {
    public static let name: String = "Feature"

    case Memo
    case Calendar
    case Todo
    case MyPage
}

// MARK: DomainModule

public enum DomainModule: String, CaseIterable {
    public static let name: String = "Domain"

    case Task
}

// MARK: CoreModule

public enum CoreModule: String, CaseIterable {
    public static let name: String = "Core"

    case Model
}

// MARK: SharedModule

public enum SharedModule: String, CaseIterable {
    public static let name: String = "Shared"

    case ThirdPartyLib
}
