//
//  Note.swift
//  Core
//
//  Created by 송영모 on 2023/03/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct Note: Equatable, Identifiable {
    public var id: String
    public var tag: Tag?
    public var title: String
    public var content: String
    
    public init(id: String, tag: Tag? = nil, title: String, content: String) {
        self.id = id
        self.tag = tag
        self.title = title
        self.content = content
    }
    
    public func toRealm() -> NoteRealm {
        return .init(id: id, tag: tag, title: title, content: content)
    }
    
    public static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
}

public class NoteRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var tag: TagRealm?
    @Persisted var title: String
    @Persisted var content: String
    
    convenience init(id: String, tag: Tag?, title: String, content: String) {
        self.init()
        
        self.id = id
        self.tag = tag?.toRealm()
        self.title = title
        self.content = content
    }
    
    func toDomain() -> Note {
        return .init(id: id, tag: tag?.toDomain(), title: title, content: content)
    }
}

// MARK: - Mock data

extension Note {
    public static let mock = Self(
        id: UUID().uuidString,
        tag: Tag.mock,
        title: "테스트1",
        content: "컨텐츠1"
    )
    
    public static let mocks = [
        Self(
            id: UUID().uuidString,
            tag: Tag.mock,
            title: "테스트2",
            content: "컨텐츠2"
        ),
        Self(
            id: UUID().uuidString,
            tag: Tag.mock,
            title: "테스트3",
            content: "컨텐츠3"
        ),
        Self(
            id: UUID().uuidString,
            tag: Tag.mock,
            title: "테스트4",
            content: "컨텐츠4"
        ),
    ]
}
