//
//  File.swift
//  Core
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct File: Equatable, Identifiable, Hashable {
    public var id: String
    public var directory: Directory?
    public var colorPalette: ColorPalette
    public var title: String
    public var content: String
    public var createDate: Date
    public var editDate: Date
    public var startDate: Date
    public var endDate: Date
    public var notificationDate: Date?
    public var calendarStyle: CalendarStyle
    public var toDoStyle: ToDoStyle
    
    public init(
        id: String = UUID().uuidString,
        directory: Directory? = nil,
        colorPalette: ColorPalette = .default,
        title: String = "",
        content: String = "",
        createDate: Date = Date(),
        editDate: Date = Date(),
        startDate: Date = Date(),
        endDate: Date = Date(),
        notificationDate: Date? = nil,
        calendarStyle: CalendarStyle = .hidden,
        toDoStyle: ToDoStyle = .hidden
    ) {
        self.id = id
        self.directory = directory
        self.colorPalette = colorPalette
        self.title = title
        self.content = content
        self.createDate = createDate
        self.editDate = editDate
        self.startDate = startDate
        self.endDate = endDate
        self.notificationDate = notificationDate
        self.calendarStyle = calendarStyle
        self.toDoStyle = toDoStyle
    }
    
    public static func fetch(directoryID: String? = nil) -> [File] {
        let realm = try! Realm()
        
        if let id = directoryID {
            return Array(realm.objects(FileRealm.self).map({ $0.toDomain() }).filter({ $0.directory?.id == id }))
        } else {
            return Array(realm.objects(FileRealm.self).map({ $0.toDomain() }))
        }
    }
    
    public static func createOrUpdate(file: File) {
        let realm = try! Realm()
        let fileRealm = file.toRealm()
        
        try! realm.write {
            realm.add(fileRealm, update: .modified)
        }
    }
    
    private func toRealm() -> FileRealm {
        return .init(
            id: id,
            directory: directory?.toRealm(),
            colorPalette: colorPalette,
            title: title,
            content: content,
            createDate: createDate,
            editDate: editDate,
            startDate: startDate,
            endDate: endDate,
            calendarStyle: calendarStyle,
            toDoStyle: toDoStyle
        )
    }
}

public class FileRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var directory: DirectoryRealm?
    @Persisted var colorPalette: ColorPalette
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var createDate: Date
    @Persisted var editDate: Date
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var notificationDate: Date?
    @Persisted var calendarStyle: CalendarStyle
    @Persisted var toDoStyle: ToDoStyle
    
    convenience init(
        id: String,
        directory: DirectoryRealm? = nil,
        colorPalette: ColorPalette,
        title: String,
        content: String,
        createDate: Date,
        editDate: Date,
        startDate: Date = Date(),
        endDate: Date = Date(),
        notificationDate: Date? = nil,
        calendarStyle: CalendarStyle,
        toDoStyle: ToDoStyle
    ) {
        self.init()
        
        self.id = id
        self.directory = directory
        self.colorPalette = colorPalette
        self.title = title
        self.content = content
        self.createDate = createDate
        self.editDate = editDate
        self.startDate = startDate
        self.endDate = endDate
        self.notificationDate = notificationDate
        self.calendarStyle = calendarStyle
        self.toDoStyle = toDoStyle
    }
    
    func toDomain() -> File {
        return .init(
            id: id,
            directory: directory?.toDomain(),
            colorPalette: colorPalette,
            title: title,
            content: content,
            createDate: createDate,
            editDate: editDate,
            startDate: startDate,
            endDate: endDate,
            calendarStyle: calendarStyle,
            toDoStyle: toDoStyle
        )
    }
}
// MARK: - Mock data

extension File {
    public static let mock = File(
        id: UUID().uuidString,
        colorPalette: .purple,
        title: "테스트 1",
        content: "컨텐츠 1",
        createDate: Date(),
        editDate: Date(),
        calendarStyle: .default,
        toDoStyle: .default
    )
    
    public static let mocks = [
        File(
            id: UUID().uuidString,
            colorPalette: .yellow,
            title: "파일 1",
            content: "컨텐츠 1",
            createDate: Date(),
            editDate: Date(),
            calendarStyle: .default,
            toDoStyle: .default
        ),
        File(
            id: UUID().uuidString,
            colorPalette: .red,
            title: "파일 2",
            content: "컨텐츠 1",
            createDate: Date(),
            editDate: Date(),
            calendarStyle: .default,
            toDoStyle: .default
        ),
        File(
            id: UUID().uuidString,
            colorPalette: .blue,
            title: "파일 3",
            content: "컨텐츠 1",
            createDate: Date(),
            editDate: Date(),
            calendarStyle: .default,
            toDoStyle: .default
        )
    ]
}
