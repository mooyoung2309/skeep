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
        var date: Date = Date()
        var calendarFiles: [CalendarFile] = []
        var tmpFiles: [File] = []
        var editDateMode: EditDateMode = .none
    }
    
    enum Action: Equatable {
        case refresh
        case selectColorPalette(ColorPalette)
        case selectStartDate
        case selectEndDate
        case selectDate(Date)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .none
        case let .selectColorPalette(colorPalette):
            return .none
        case .selectStartDate, .selectEndDate:
            return .none
        case let .selectDate(date):
            return .none
        }
    }
}
