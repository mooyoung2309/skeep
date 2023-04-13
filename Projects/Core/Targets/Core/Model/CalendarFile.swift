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
    public var visiableFiles: [File?]
    
    public init(id: String, date: Date, files: [File]) {
        self.id = id
        self.date = date
        self.files = files
        self.visiableFiles = [nil, nil, nil]
    }
    
    public mutating func appendVisiableFiles(visiableFile: File, index: Int) {
        if visiableFiles.contains(where: { file in
            if let file = file, file.id == visiableFile.id {
                return true
            } else {
                return false
            }
        }) {
            return
        }
        
        if visiableFiles[safe: index] == nil {
            visiableFiles[safe: index] = visiableFile
            return
        } else {
            for (i, file) in visiableFiles.enumerated() {
                if file == nil {
                    visiableFiles[safe: i] = visiableFile
                    return
                }
            }
        }
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
