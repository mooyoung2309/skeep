//
//  Tag.swift
//  Core
//
//  Created by 송영모 on 2023/03/29.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct Tag: Equatable, Identifiable, Hashable {
    public var id: String
    public var title: String
    
    public init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
    }
    
    public func toRealm() -> TagRealm {
        return .init(id: self.id, title: self.title)
    }
    
    public static func fetch() -> [Tag] {
        let realm = try! Realm()
        let tags = realm.objects(TagRealm.self).map({ $0.toDomain() })
        
        return Array(tags)
    }
    
    public static func createOrUpdate(tag: Tag) {
        let realm = try! Realm()
        let tagRealm = tag.toRealm()
        
        try! realm.write {
            realm.add(tagRealm, update: .modified)
        }
    }
}

public class TagRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    
    convenience init(id: String, title: String) {
        self.init()
        
        self.id = id
        self.title = title
    }
    
    public func toDomain() -> Tag {
        return .init(id: self.id, title: self.title)
    }
}
// MARK: - Mock data

extension Tag {
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
