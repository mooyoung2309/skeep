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
    public var fetchFile: (String) -> File?
    public var fetchFiles: (String?) -> [File]
    public var fetchCalendarFiles: (Date) -> [CalendarFile]
    public var fetchTodoFiles: (Date) -> [TodoFile]
    public var createOrUpdateFile: (File) -> ()
}

extension FileClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchFile: { _ in return File.mock },
        fetchFiles: { _ in return File.mocks },
        fetchCalendarFiles: { _ in return CalendarFile.mocks },
        fetchTodoFiles: { _ in return TodoFile.mocks },
        createOrUpdateFile: { _ in }
    )
    
    public static let testValue = Self(
        fetchFile: unimplemented("\(Self.self).fethFile"),
        fetchFiles: unimplemented("\(Self.self).fetchFiles"),
        fetchCalendarFiles: unimplemented("\(Self.self).fetchCalendarFiles"),
        fetchTodoFiles: unimplemented("\(Self.self).fetchTodoFiles"),
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
        fetchFile: { id in
            return File.fetch(id: id)
        },
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
            var calendarFiles = dates.map({ date in
                return CalendarFile(id: UUID().uuidString, date: date, files: [])
            })
            
            for (i, calendarFile) in calendarFiles.enumerated() {
                let filteredFiles = files.filter({
                    calendarFile.date.isDate(start: $0.startDate, end: $0.endDate) ||
                    ($0.repeatStyle != .none && calendarFile.date < $0.repeatFinishDate && calendarFile.date > $0.startDate) && (
                        ($0.repeatStyle == .daily && WeekdayManager.toWeekdays(uint8: .init($0.weekdays)).contains(calendarFile.date.weekday)) ||
                        ($0.repeatStyle == .weekly && calendarFile.date.weekday == $0.startDate.weekday) ||
                        ($0.repeatStyle == .monthly && calendarFile.date.day == $0.startDate.day) ||
                        ($0.repeatStyle == .yearly && calendarFile.date.month == $0.startDate.month && calendarFile.date.day == $0.startDate.day)
                    )
                })
                
                calendarFiles[safe: i]?.files.append(contentsOf: filteredFiles)
                
                for (j, file) in filteredFiles.prefix(3).enumerated() {
                    if file.startDate.isDate(inSameDayAs: calendarFile.date) || (file.repeatStyle != .none && calendarFile.date < file.repeatFinishDate) {
                        for k in i..<(i + file.startDate.day(to: file.endDate)) {
                            calendarFiles[safe: k]?.appendVisiableFiles(visiableFile: file, index: j)
                        }
                    }
                }
            }
            
            return calendarFiles
        },
        fetchTodoFiles: { date in
            let dates = date.weekDates()
            let files = File.fetch().filter({ $0.todoStyle.isShow })
            let todoFiles = dates.map({ date in
                let filterdFiles = files.filter({ date.isDate(start: $0.startDate, end: $0.endDate) })
                return TodoFile(id: UUID().uuidString, date: date, files: filterdFiles)
            })
            return todoFiles
        },
        createOrUpdateFile: { _file in
            var file = _file
            file.editDate = Date()
            File.createOrUpdate(file: file)
        }
    )
}
