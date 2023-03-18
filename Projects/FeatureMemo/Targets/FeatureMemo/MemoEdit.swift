//
//  MemoEdit.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

struct MemoEdit: ReducerProtocol {
    enum EditDateMode {
        case none
        case start
        case end
    }
    
    struct State: Equatable {
        var file: File
        var isSheetPresented: Bool = false
        var editDateMode: EditDateMode = .none
        var date: Date = Date()
    }
    
    enum Action: Equatable {
        case titleChanged(String)
        case contentChanged(String)
        case selectColorPalette(ColorPalette)
        case selectStartDate
        case selectEndDate
        case selectDate(Date)
        case setEditDateMode(EditDateMode)
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .titleChanged(title):
            state.file.title = title
            return .none
            
        case let .contentChanged(content):
            state.file.content = content
            return .none
            
        case let .selectColorPalette(colorPalette):
            state.file.colorPalette = colorPalette
            return .none
            
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
            
            return .send(.setEditDateMode(.none), animation: .default)
            
        case let .setEditDateMode(mode):
            state.editDateMode = mode
            return .none
            
        case let .setSheet(isPresented):
            state.isSheetPresented = isPresented
            return .none
        }
    }
}
