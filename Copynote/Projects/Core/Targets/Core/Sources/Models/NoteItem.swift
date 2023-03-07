//
//  Note.swift
//  Copynote
//
//  Created by 송영모 on 2023/03/04.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct NoteItem: Equatable, Identifiable {
    public var id: String
    public var tag: TagItem?
    public var title: String
    public var content: String
    
    public func toRealm() -> NoteRealm {
        return .init(id: id, tag: tag, title: title, content: content)
    }
    
    public static func == (lhs: NoteItem, rhs: NoteItem) -> Bool {
        return lhs.id == rhs.id
    }
}

public class NoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var tag: TagRealm?
    @Persisted var title: String
    @Persisted var content: String
    
    convenience init(id: String, tag: TagItem?, title: String, content: String) {
        self.init()
        
        self.id = id
        self.tag = tag?.toRealm()
        self.title = title
        self.content = content
    }
    
    func toDomain() -> NoteItem {
        return .init(id: id, tag: tag?.toDomain(), title: title, content: content)
    }
}

// MARK: - Mock data

extension NoteItem {
    static let mock = Self(
        id: UUID().uuidString,
        title: "테스트1",
        content: "컨텐츠1"
    )
    
    static let mocks = [
        Self(
            id: UUID().uuidString,
            title: "테스트2",
            content: "컨텐츠2"
        ),
        Self(
            id: UUID().uuidString,
            title: "테스트3",
            content: "컨텐츠3"
        ),
        Self(
            id: UUID().uuidString,
            title: "테스트4",
            content: "컨텐츠4"
        ),
    ]
}
