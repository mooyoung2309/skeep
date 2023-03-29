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
    public var rgb: Int
    public var title: String
    public var content: String
    public var createDate: Date
    public var editDate: Date
    public var startDate: Date
    public var endDate: Date
    public var notificationDate: Date?
    public var weekdays: Int
    public var repeatStyle: RepeatStyle
    public var calendarStyle: CalendarStyle
    public var todoStyle: TodoStyle
    
    public init(
        id: String = UUID().uuidString,
        directory: Directory? = nil,
        rgb: Int = ColorPalette.default.color.rgb(),
        title: String = "",
        content: String = "",
        createDate: Date = Date(),
        editDate: Date = Date(),
        startDate: Date = Date(),
        endDate: Date = Date(),
        notificationDate: Date? = nil,
        weekdays: Int = 0,
        repeatStyle: RepeatStyle = .none,
        calendarStyle: CalendarStyle = .none,
        todoStyle: TodoStyle = .none
    ) {
        self.id = id
        self.directory = directory
        self.rgb = rgb
        self.title = title
        self.content = content
        self.createDate = createDate
        self.editDate = editDate
        self.startDate = startDate
        self.endDate = endDate
        self.notificationDate = notificationDate
        self.weekdays = weekdays
        self.repeatStyle = repeatStyle
        self.calendarStyle = calendarStyle
        self.todoStyle = todoStyle
    }
    
    public static func fetch(id: String) -> File? {
        let realm = try! Realm()
        
        return realm.objects(FileRealm.self).map({ $0.toDomain() }).first(where: { $0.id == id })
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
            rgb: rgb,
            title: title,
            content: content,
            createDate: createDate,
            editDate: editDate,
            startDate: startDate,
            endDate: endDate,
            notificationDate: notificationDate,
            weekdays: weekdays,
            repeatStyle: repeatStyle,
            calendarStyle: calendarStyle,
            toDoStyle: todoStyle
        )
    }
}

public class FileRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var directory: DirectoryRealm?
    @Persisted var rgb: Int
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var createDate: Date
    @Persisted var editDate: Date
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var notificationDate: Date?
    @Persisted var weekdays: Int
    @Persisted var repeatStyle: RepeatStyle
    @Persisted var calendarStyle: CalendarStyle
    @Persisted var todoStyle: TodoStyle
    
    convenience init(
        id: String,
        directory: DirectoryRealm?,
        rgb: Int,
        title: String,
        content: String,
        createDate: Date,
        editDate: Date,
        startDate: Date,
        endDate: Date,
        notificationDate: Date?,
        weekdays: Int,
        repeatStyle: RepeatStyle,
        calendarStyle: CalendarStyle,
        toDoStyle: TodoStyle
    ) {
        self.init()
        
        self.id = id
        self.directory = directory
        self.rgb = rgb
        self.title = title
        self.content = content
        self.createDate = createDate
        self.editDate = editDate
        self.startDate = startDate
        self.endDate = endDate
        self.notificationDate = notificationDate
        self.weekdays = weekdays
        self.repeatStyle = repeatStyle
        self.calendarStyle = calendarStyle
        self.todoStyle = toDoStyle
    }
    
    func toDomain() -> File {
        return .init(
            id: id,
            directory: directory?.toDomain(),
            rgb: rgb,
            title: title,
            content: content,
            createDate: createDate,
            editDate: editDate,
            startDate: startDate,
            endDate: endDate,
            notificationDate: notificationDate,
            weekdays: weekdays,
            repeatStyle: repeatStyle,
            calendarStyle: calendarStyle,
            todoStyle: todoStyle
        )
    }
}
// MARK: - Mock data

extension File {
    public static let mock = File(
        id: UUID().uuidString,
        rgb: ColorPalette.purple.color.rgb(),
        title: "테스트 1",
        content: "컨텐츠 1",
        createDate: Date(),
        editDate: Date(),
        calendarStyle: .default,
        todoStyle: .default
    )
    
    public static let mocks = [
        File(
            id: UUID().uuidString,
            rgb: ColorPalette.yellow.color.rgb(),
            title: "파일 1",
            content: "컨텐츠 1",
            createDate: Date(),
            editDate: Date(),
            calendarStyle: .default,
            todoStyle: .default
        ),
        File(
            id: UUID().uuidString,
            rgb: ColorPalette.red.color.rgb(),
            title: "파일 2",
            content: "컨텐츠 1",
            createDate: Date(),
            editDate: Date(),
            calendarStyle: .default,
            todoStyle: .default
        ),
        File(
            id: UUID().uuidString,
            rgb: ColorPalette.blue.color.rgb(),
            title: "파일 3",
            content: "컨텐츠 1",
            createDate: Date(),
            editDate: Date(),
            calendarStyle: .default,
            todoStyle: .default
        )
    ]
}
