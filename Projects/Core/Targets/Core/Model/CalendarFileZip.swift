//
//  CalendarZip.swift
//  Core
//
//  Created by 송영모 on 2023/03/22.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

public struct CalendarFileZip: Equatable, Identifiable {
    public var id: String
    public var calendarFiles: [CalendarFile]
    
    public init(id: String = UUID().uuidString, calendarFiles: [CalendarFile]) {
        self.id = id
        self.calendarFiles = calendarFiles
    }
}

extension CalendarFileZip {
    public static let mocks = [
        CalendarFileZip(calendarFiles: CalendarFile.mocks),
        CalendarFileZip(calendarFiles: CalendarFile.mocks),
        CalendarFileZip(calendarFiles: CalendarFile.mocks),
        CalendarFileZip(calendarFiles: CalendarFile.mocks),
        CalendarFileZip(calendarFiles: CalendarFile.mocks)
    ]
}
