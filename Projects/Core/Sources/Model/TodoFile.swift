//
//  ToDoFile.swift
//  Core
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

public struct TodoFile: Equatable, Identifiable {
    public var id: String
    public var date: Date
    public var files: [File]
    
    init(id: String, date: Date, files: [File]) {
        self.id = id
        self.date = date
        self.files = files
    }
}

extension File {
    public func isDone(date: Date) -> Bool {
        return self.doneDates.contains(where: { $0.isDate(inSameDayAs: date) })
    }
}

extension TodoFile {
    public static let mock = TodoFile(
        id: UUID().uuidString,
        date: Date(),
        files: File.mocks
    )
    
    public static let mocks = [
        TodoFile(
            id: UUID().uuidString,
            date: Date(),
            files: File.mocks
        ),
        TodoFile(
            id: UUID().uuidString,
            date: Date(),
            files: File.mocks
        )
    ]
}
