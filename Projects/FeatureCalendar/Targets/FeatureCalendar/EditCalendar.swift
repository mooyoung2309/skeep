//
//  CalendarEdit.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

struct EditCalendar: ReducerProtocol {
    enum EditDateMode {
        case none
        case start
        case end
    }
    
    struct State: Equatable {
        var file: File
        var editDateMode: EditDateMode = .none
        var date: Date = Date()
    }
    
    enum Action: Equatable {
        case refresh
        case createOrUpdateRequest
        
        case titleChanged(String)
        case contentChanged(String)
        
        case selectColorPalette(ColorPalette)
        case selectStartDate
        case selectEndDate
        case selectDate(Date)
        
        case setEditDateMode(EditDateMode)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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
            
        case let .selectColorPalette(colorPalette):
            state.file.colorPalette = colorPalette
            return .send(.createOrUpdateRequest)
            
        case .selectStartDate:
            state.editDateMode = .start
            return .none
            
        case .selectEndDate:
            state.editDateMode = .end
            return .none
            
        case let .selectDate(date):
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
            
        case let .setEditDateMode(mode):
            state.editDateMode = mode
            return .none
        }
    }
}
