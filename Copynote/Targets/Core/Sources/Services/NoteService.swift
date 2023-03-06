//
//  NoteService.swift
//  Copynote
//
//  Created by 송영모 on 2023/03/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

protocol NoteServiceProtocol {
    func fetch() -> [Note]
    func fetch(id: String) -> Note?
    func createOrUpdate(note: Note)
    func delete(id: String)
}

public class NoteService {
    let realm = try? Realm()
    
    public init() { }
    
    func fetch() -> [Note] {
        if let objs = realm?.objects(NoteRealm.self).map({ $0.toDomain() }) {
            return Array(objs)
        } else {
            return []
        }
    }
    
    func fetch(id: String) -> Note? {
        return self.fetch().first(where: { $0.id == id })
    }
    
    func createOrUpdate(note: Note) {
        do {
            try realm?.write {
                realm?.add(note.toRealm(), update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func delete(id: String) {
        guard let obj = fetch(id: id)?.toRealm() else { return }
        
        do {
            try realm?.write {
                realm?.delete(obj)
            }
        } catch {
            print(error)
        }
    }
}
