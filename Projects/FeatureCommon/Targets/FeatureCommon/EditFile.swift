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
    
    public enum EditDateMode {
        case none
        case start
        case end
    }
    
    public struct State: Equatable {
        public let style: EditFileStyle
        public var file: File
        
        var editDateMode: EditDateMode = .none
        var date: Date = Date()
        
        public init(style: EditFileStyle, file: File) {
            self.style = style
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
        
        case setEditDateMode(EditDateMode)
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
            switch state.editDateMode {
            case .start: state.file.startDate = date
            case .end: state.file.endDate = date
            case .none: break
            }
            state.date = date
            
            return .concatenate([
                .send(.setEditDateMode(.none), animation: .default),
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
            state.editDateMode = .start
            return .none
            
        case .tapEndDateView:
            state.editDateMode = .end
            return .none
            
        case let .setEditDateMode(mode):
            state.editDateMode = mode
            return .none
        }
    }
}
