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
    public var fetchFiles: () -> [File]
    public var fetchCalendarFiles: (Date) -> [CalendarFile]
}

extension FileClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchFiles: { File.mocks },
        fetchCalendarFiles: { _ in return CalendarFile.mocks }
    )
    
    public static let testValue = Self(
        fetchFiles: unimplemented("\(Self.self).fetchFiles"),
        fetchCalendarFiles: unimplemented("\(Self.self).fetchCalendarFiles")
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
        fetchFiles: {
            return File.fetch()
        },
        fetchCalendarFiles: { date in
            let calendar = Calendar.current
            
            let dates = date.calendarDates()
            let files = File.fetch().filter({ $0.isShowCalendar })
            let calendarFiles = dates.map({ date in
                let filterdFiles = files.filter({ file in
                    if let startDate = file.startDate, calendar.isDate(date, inSameDayAs: startDate) {
                        return true
                    } else {
                        return false
                    }
                })
                return CalendarFile(id: UUID().uuidString, date: date, files: filterdFiles)
            })
            
            return calendarFiles
        }
    )
}
