//
//  Directory.swift
//  Core
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct Directory: Equatable, Identifiable, Hashable {
    public var id: String
    public var title: String
    
    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    public func toRealm() -> DirectoryRealm {
        return .init(id: self.id, title: self.title)
    }
}

public class DirectoryRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    
    convenience init(id: String, title: String) {
        self.init()
        
        self.id = id
        self.title = title
    }
    
    public func toDomain() -> Directory {
        return .init(id: self.id, title: self.title)
    }
}
// MARK: - Mock data

extension Directory {
    public static let mock = Self(
        id: UUID().uuidString,
        title: "테스트1"
    )
    
    public static let mocks = [
        Self(
            id: UUID().uuidString,
            title: "테스트2"
        ),
        Self(
            id: UUID().uuidString,
            title: "테스트3"
        ),
        Self(
            id: UUID().uuidString,
            title: "테스트4"
        ),
    ]
}
