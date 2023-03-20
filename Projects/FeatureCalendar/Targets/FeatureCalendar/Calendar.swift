//
//  Calendar.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

public struct Calendar: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var date: Date = Date()
        var calendarFiles: [CalendarFile] = []
        var tmpFiles: [File] = []
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case refresh
        case fetchCalendarFilesRequest
        case fetchCalendarFilesResponse([CalendarFile])
    }
    
    @Dependency(\.fileClient) var fileClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .concatenate([.send(.fetchCalendarFilesRequest)])
        case .fetchCalendarFilesRequest:
            return .send(.fetchCalendarFilesResponse(self.fileClient.fetchCalendarFiles(state.date)))
        case let .fetchCalendarFilesResponse(calendarFiles):
            state.calendarFiles = calendarFiles
            return .none
        }
    }
}
