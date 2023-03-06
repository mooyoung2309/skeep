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
    
    static func fetch() -> [Note] {
        if let objs = try? Realm().objects(NoteRealm.self).map({ $0.toDomain() }) {
            return Array(objs)
        } else {
            return []
        }
    }
    
    static func fetch(id: String) -> Note? {
        return self.fetch().first(where: { $0.id == id })
    }
    
    static func createOrUpdate(note: Note) {
        do {
            let realm = try? Realm()
            
            try realm?.write {
                realm?.add(note.toRealm(), update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    static func delete(id: String) {
        let realm = try? Realm()
        
        guard let obj = fetch(id: id)?.toRealm() else { return }
        
        do {
            let realm = try? Realm()
            
            try realm?.write {
                realm?.delete(obj)
            }
        } catch {
            print(error)
        }
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
