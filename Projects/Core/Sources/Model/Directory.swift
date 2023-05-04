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
    public var order: Int
    
    public init(id: String = UUID().uuidString, title: String, order: Int) {
        self.id = id
        self.title = title
        self.order = order
    }
    
    public func toRealm() -> DirectoryRealm {
        return .init(id: self.id, title: self.title, order: self.order)
    }
    
    public static func fetch() -> [Directory] {
        let realm = try! Realm()
        let directories = realm.objects(DirectoryRealm.self).map({ $0.toDomain() })
        
        return Array(directories)
    }
    
    public static func createOrUpdate(directory: Directory) {
        let realm = try! Realm()
        let directoryRealm = directory.toRealm()
        
        try! realm.write {
            realm.add(directoryRealm, update: .modified)
        }
    }
}

public class DirectoryRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var order: Int
    
    convenience init(id: String, title: String, order: Int) {
        self.init()
        
        self.id = id
        self.title = title
        self.order = order
    }
    
    public func toDomain() -> Directory {
        return .init(id: self.id, title: self.title, order: self.order)
    }
}
// MARK: - Mock data

extension Directory {
    public static let mock = Self(
        id: UUID().uuidString,
        title: "테스트1",
        order: 1
    )
    
    public static let mocks = [
        Self(
            id: UUID().uuidString,
            title: "테스트2",
            order: 1
        ),
        Self(
            id: UUID().uuidString,
            title: "테스트3",
            order: 1
        ),
        Self(
            id: UUID().uuidString,
            title: "테스트4",
            order: 1
        ),
    ]
}
