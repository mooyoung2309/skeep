//
//  File.swift
//  Core
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct File {
    public var id: String
    public var directory: Directory?
    public var colorPalette: ColorPalette
    public var title: String
    public var content: String
    public var created: Date
    public var edited: Date
    public var calendared: Date?
    
    public init(id: String, colorPalette: ColorPalette, directory: Directory? = nil, title: String, content: String, created: Date, edited: Date, calendared: Date?) {
        self.id = id
        self.directory = directory
        self.colorPalette = colorPalette
        self.title = title
        self.content = content
        self.created = created
        self.edited = edited
        self.calendared = calendared
    }
    
    public func toRealm() -> FileRealm {
        return .init(id: self.id, directory: self.directory, title: self.title, content: self.content, created: self.created, edited: self.edited)
    }
}

public class FileRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var directory: DirectoryRealm?
    @Persisted var colorPalette: ColorPalette
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var created: Date
    @Persisted var edited: Date
    @Persisted var calendared: Date
    
    convenience init(id: String, directory: Directory?, title: String, content: String, created: Date, edited: Date) {
        self.init()
        
        self.id = id
        self.directory = directory?.toRealm()
        self.title = title
        self.content = content
        self.created = created
        self.edited = edited
    }
    
    public func toDomain() -> File {
        return .init(id: self.id, colorPalette: self.colorPalette, title: self.title, content: self.content, created: self.created, edited: self.edited, calendared: self.calendared)
    }
}
// MARK: - Mock data

extension File {
    public static let mock = Self(
        id: UUID().uuidString,
        colorPalette: .indigo,
        title: "테스트 1",
        content: "테스트 1",
        created: Date(),
        edited: Date(),
        calendared: Date()
    )
    
    public static let mocks = [
        Self(
            id: UUID().uuidString,
            colorPalette: .clear,
            title: "테스트 2",
            content: "테스트 2",
            created: Date(),
            edited: Date(),
            calendared: nil
        ),
        Self(
            id: UUID().uuidString,
            colorPalette: .pink,
            title: "테스트 2",
            content: "테스트 2",
            created: Date(),
            edited: Date(),
            calendared: nil
        ),
        Self(
            id: UUID().uuidString,
            colorPalette: .purple,
            title: "테스트 2",
            content: "테스트 2",
            created: Date(),
            edited: Date(),
            calendared: nil
        )
    ]
}
