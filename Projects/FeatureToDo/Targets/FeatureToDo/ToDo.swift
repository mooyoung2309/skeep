//
//  ToDo.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

struct ToDo: ReducerProtocol {
    struct State: Equatable {
        var date: Date = Date()
        var calendarFiles: [CalendarFile] = []
        var tmpFiles: [File] = []
        var isSheetPresented: Bool = false
    }
    
    enum Action: Equatable {
        case refresh
        case fetchCalendarFilesRequest
        case fetchCalendarFilesResponse([CalendarFile])
        case selectDate(Date)
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .concatenate([.send(.fetchCalendarFilesRequest)])
        case .fetchCalendarFilesRequest:
            return .send(.fetchCalendarFilesResponse(self.fileClient.fetchCalendarFiles(state.date)))
        case let .fetchCalendarFilesResponse(calendarFiles):
            state.calendarFiles = calendarFiles
            return .none
        case let .selectDate(date):
            state.date = date
            return .none
        case let .setSheet(isPresented):
            state.isSheetPresented = isPresented
            return .none
        }
    }
}

