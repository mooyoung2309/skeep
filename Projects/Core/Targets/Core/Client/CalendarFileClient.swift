//
//  CalendarClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/19.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct CalendarFileClient {
    public var fetchCalendarFileList: () -> [CalendarFile]
}

extension CalendarFileClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchCalendarFileList: { CalendarFile.mocks }
    )
    
    public static let testValue = Self(
        fetchCalendarFileList: unimplemented("\(Self.self).fetchCalendarFileList")
    )
}

extension DependencyValues {
    public var calendarFileClient: CalendarFileClient {
        get { self[CalendarFileClient.self] }
        set { self[CalendarFileClient.self] = newValue }
    }
}

extension CalendarFileClient: DependencyKey {
    public static let liveValue = CalendarFileClient(
        fetchCalendarFileList: {
            return CalendarFile.mocks
        }
    )
}

