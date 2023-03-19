//
//  Calendar.swift
//  Core
//
//  Created by 송영모 on 2023/03/19.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

public struct CalendarFile {
    public var id: String
    public var date: Date
}

extension CalendarFile {
    public static let mock = CalendarFile(
        id: UUID().uuidString,
        date: Date()
    )
    
    public static let mocks = [
        CalendarFile(
            id: UUID().uuidString,
            date: Date()
        ),
        CalendarFile(
            id: UUID().uuidString,
            date: Date()
        )
    ]
}
