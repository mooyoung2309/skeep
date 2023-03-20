//
//  Calendar.swift
//  Core
//
//  Created by 송영모 on 2023/03/19.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

public struct CalendarFile: Equatable, Identifiable {
    public var id: String
    public var date: Date
    public var files: [File]
    
    init(id: String, date: Date, files: [File]) {
        self.id = id
        self.date = date
        self.files = files
    }
}

extension CalendarFile {
    public static let mock = CalendarFile(
        id: UUID().uuidString,
        date: Date(),
        files: File.mocks
    )
    
    public static let mocks = [
        CalendarFile(
            id: UUID().uuidString,
            date: Date(),
            files: File.mocks
        ),
        CalendarFile(
            id: UUID().uuidString,
            date: Date(),
            files: File.mocks
        )
    ]
}