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
        var isSheetPresented: Bool = false
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case refresh
        case fetchCalendarFilesRequest
        case fetchCalendarFilesResponse([CalendarFile])
        
        case tapLeftButton
        case tapRightButton
        case selectCalendarCell(Date)
        
        case setDate(Date)
        case setSheet(isPresented: Bool)
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
            
        case .tapLeftButton:
            return .send(.setDate(state.date.addMonth(value: -1)))
            
        case .tapRightButton:
            return .send(.setDate(state.date.addMonth(value: 1)))
            
        case let .selectCalendarCell(date):
            return .send(.setDate(date))
            
        case let .setDate(date):
            state.date = date
            return .send(.refresh)
            
        case let .setSheet(isPresented):
            state.isSheetPresented = isPresented
            return .none
        }
    }
}
