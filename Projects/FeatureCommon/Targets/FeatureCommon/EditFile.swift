//
//  EditFile.swift
//  FeatureCommon
//
//  Created by 송영모 on 2023/03/25.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

import ComposableArchitecture

public struct EditFile: ReducerProtocol {
    public init() {}
    
    public enum Tab { case memo, calendar, todo }
    
    public enum Mode { case none, start, end }
    
    public struct State: Equatable {
        public let tab: Tab
        public var file: File
        
        var mode: Mode = .none
        var date: Date = Date()
        
        public init(tab: Tab, file: File) {
            self.tab = tab
            self.file = file
        }
    }
    
    public enum Action: Equatable {
        case refresh
        case createOrUpdateRequest
        
        case titleChanged(String)
        case contentChanged(String)
        case colorChanged(Color)
        case dateChanged(Date)
        case calendarToggleChanged(Bool)
        case allDayToggleChanged(Bool)
        case toDoToggleChanged(Bool)
        
        
        case tapStartDateView
        case tapEndDateView
        
        case setMode(Mode)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .none
            
        case .createOrUpdateRequest:
            fileClient.createOrUpdateFile(state.file)
            return .none
            
        case let .titleChanged(title):
            state.file.title = title
            return .send(.createOrUpdateRequest)
            
        case let .contentChanged(content):
            state.file.content = content
            return .send(.createOrUpdateRequest)
            
        case let .colorChanged(color):
            state.file.rgb = color.rgb()
            return .send(.createOrUpdateRequest)
            
        case let .dateChanged(date):
            switch state.mode {
            case .start: state.file.startDate = date
            case .end: state.file.endDate = date
            case .none: break
            }
            state.date = date
            
            return .concatenate([
                .send(.setMode(.none), animation: .default),
                .send(.createOrUpdateRequest)
            ])
            
        case let .calendarToggleChanged(isCalendar):
            state.file.calendarStyle = isCalendar ? .default : .hidden
            return .send(.createOrUpdateRequest)
            
        case let .allDayToggleChanged(isAllDay):
            state.file.calendarStyle = isAllDay ? .allDay : .default
            return .send(.createOrUpdateRequest)
            
        case let .toDoToggleChanged(isTodo):
            state.file.todoStyle = isTodo ? .default : .hidden
            return .send(.createOrUpdateRequest)
            
        case .tapStartDateView:
            state.mode = .start
            return .none
            
        case .tapEndDateView:
            state.mode = .end
            return .none
            
        case let .setMode(mode):
            state.mode = mode
            return .none
        }
    }
}
