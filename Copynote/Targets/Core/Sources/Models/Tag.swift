//
//  Tag.swift
//  Copynote
//
//  Created by 송영모 on 2023/03/04.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

struct Tag {
    var id: String = UUID().uuidString
    var title: String = ""
    var colorHex: String = ""
    
    func toRealm() -> TagRealm {
        return .init(id: id, title: title, colorHex: colorHex)
    }
}

class TagRealm: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String = ""
    @Persisted var colorHex: String = ""
    
    init(id: String, title: String, colorHex: String) {
        self.id = id
        self.title = title
        self.colorHex = colorHex
    }
    
    func toDomain() -> Tag {
        return .init(id: id, title: title, colorHex: colorHex)
    }
}
