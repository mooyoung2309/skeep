//
//  Note.swift
//  Copynote
//
//  Created by 송영모 on 2023/03/04.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct Note: Equatable {
    var id: String = UUID().uuidString
    var tag: Tag = .init()
    var title: String = ""
    var content: String = ""
    
    func toRealm() -> NoteRealm {
        return .init(id: id, tag: tag, title: title, content: content)
    }
    
    public static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
}

public class NoteRealm: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var tag: TagRealm = .init()
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    
    init(id: String, tag: Tag, title: String, content: String) {
        self.id = id
        self.tag = tag.toRealm()
        self.title = title
        self.content = content
    }
    
    func toDomain() -> Note {
        return .init(id: id, tag: tag.toDomain(), title: title, content: content)
    }
}
