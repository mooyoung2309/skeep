//
//  EditFile.swift
//  FeatureCommon
//
//  Created by 송영모 on 2023/03/25.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core
import Utils

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
        case startDateChanged(Date)
        case endDateChanged(Date)
//        case dateChanged(Date)
        case repeatStyleChanged(RepeatStyle)
        case weekdayChanged(Int)
        case calendarStyleChanged(CalendarStyle)
        case calendarToggleChanged
        case todoToggleChanged
        
        case tapStartDateView
        case tapEndDateView
        
//        case setMode(Mode)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .none
            
        case .createOrUpdateRequest:
            fileClient.createOrUpdateFile(state.file)
            state.mode = .none
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
            
        case let .startDateChanged(date):
            state.file.startDate = date
            if date > state.file.endDate {
                state.file.endDate = date.add(byAdding: .hour, value: 1)
            }
            return .send(.createOrUpdateRequest)
            
        case let .endDateChanged(date):
            state.file.endDate = date
            if date < state.file.startDate {
                state.file.startDate = date.add(byAdding: .hour, value: -1)
            }
            return .send(.createOrUpdateRequest)
            
//        case let .dateChanged(date):
//            switch state.mode {
//            case .start: state.file.startDate = date
//            case .end: state.file.endDate = date
//            case .none: break
//            }
//            state.date = date
//
//            return .concatenate([
//                .send(.setMode(.none), animation: .default),
//                .send(.createOrUpdateRequest)
//            ])
            
        case let .repeatStyleChanged(repeatStyle):
            state.file.repeatStyle = repeatStyle
            return .send(.createOrUpdateRequest)
            
        case let .weekdayChanged(weekday):
            var weekdays: [Int] = WeekdayManager.toWeekdays(uint8: UInt8(state.file.weekdays))
            
            if weekdays.contains(weekday) {
                weekdays.removeAll(where: { $0 == weekday })
            } else {
                weekdays.append(weekday)
            }
            state.file.weekdays = WeekdayManager.toInt(weekdays: weekdays)
            return .send(.createOrUpdateRequest)
            
        case let .calendarStyleChanged(calendarStyle):
            if state.file.calendarStyle == calendarStyle {
                state.file.calendarStyle = .default
            } else {
                state.file.calendarStyle = calendarStyle
            }
            return .send(.createOrUpdateRequest)
            
        case .calendarToggleChanged:
            state.file.calendarStyle = state.file.calendarStyle == .none ? .default : .none
            return .send(.createOrUpdateRequest)
            
        case .todoToggleChanged:
            state.file.todoStyle = state.file.todoStyle == .none ? .default : .none
            return .send(.createOrUpdateRequest)
            
        case .tapStartDateView:
            state.mode = .start
            return .none
            
        case .tapEndDateView:
            state.mode = .end
            return .none
            
//        case let .setMode(mode):
//            state.mode = mode
//            return .none
        }
    }
}
