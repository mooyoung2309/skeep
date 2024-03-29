//
//  Modules.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

public enum ModulePath {
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
}

// MARK: AppModule

public extension ModulePath {
    enum App: String, CaseIterable {
        case IOS
        
        public static let name: String = "App"
    }
}


// MARK: FeatureModule
public extension ModulePath {
    enum Feature: String, CaseIterable {
        case Memo
        case Calendar
        case Todo
        case MyPage
        
        public static let name: String = "Feature"
    }
}

// MARK: DomainModule

public extension ModulePath {
    enum Domain: String, CaseIterable {
        case Health
        case Login
        
        public static let name: String = "Domain"
    }
}

// MARK: CoreModule

public extension ModulePath {
    enum Core: String, CaseIterable {
        case Network
        
        public static let name: String = "Core"
    }
}

// MARK: SharedModule

public extension ModulePath {
    enum Shared: String, CaseIterable {
        case DesignSystem
        case ThirdPartyLib
        
        public static let name: String = "Shared"
    }
}
