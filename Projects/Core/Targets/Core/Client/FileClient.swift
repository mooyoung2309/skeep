//
//  FileClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Utils

import ComposableArchitecture

public struct FileClient {
    public var fetchFiles: (String?) -> [File]
    public var fetchCalendarFiles: (Date) -> [CalendarFile]
    public var fetchToDoFiles: (Date) -> [ToDoFile]
    public var createOrUpdateFile: (File) -> ()
}

extension FileClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchFiles: { _ in return File.mocks },
        fetchCalendarFiles: { _ in return CalendarFile.mocks },
        fetchToDoFiles: { _ in return ToDoFile.mocks },
        createOrUpdateFile: { _ in }
    )
    
    public static let testValue = Self(
        fetchFiles: unimplemented("\(Self.self).fetchFiles"),
        fetchCalendarFiles: unimplemented("\(Self.self).fetchCalendarFiles"),
        fetchToDoFiles: unimplemented("\(Self.self).fetchToDoFiles"),
        createOrUpdateFile: unimplemented("\(Self.self).fetchCalendarFiles")
    )
}

extension DependencyValues {
    public var fileClient: FileClient {
        get { self[FileClient.self] }
        set { self[FileClient.self] = newValue }
    }
}

extension FileClient: DependencyKey {
    public static let liveValue = FileClient(
        fetchFiles: { id in
            if let id = id {
                return File.fetch(directoryID: id)
            } else {
                return File.fetch()
            }
        },
        fetchCalendarFiles: { date in
            let dates = date.monthDates()
            let files = File.fetch().filter({ $0.calendarStyle.isShow })
            let calendarFiles = dates.map({ date in
                let filterdFiles = files.filter({ date.isDate(inSameDayAs: $0.startDate) })
                return CalendarFile(id: UUID().uuidString, date: date, files: filterdFiles)
            })
            
            return calendarFiles
        },
        fetchToDoFiles: { date in
            let dates = date.weekDates()
            let files = File.fetch().filter({ $0.toDoStyle.isShow })
            let toDoFiles = dates.map({ date in
                let filterdFiles = files.filter({ date.isDate(inSameDayAs: $0.startDate) })
                return ToDoFile(id: UUID().uuidString, date: date, files: filterdFiles)
            })
            return toDoFiles
        },
        createOrUpdateFile: { file in
            File.createOrUpdate(file: file)
        }
    )
}
