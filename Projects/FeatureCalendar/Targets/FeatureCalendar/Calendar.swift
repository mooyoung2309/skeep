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
        var calendarFile: CalendarFile?
        var file: File = .init()
        var isSheetPresented: Bool = false
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case refresh
        case fetchCalendarFilesRequest
        case fetchCalendarFilesResponse([CalendarFile])
        
        case tapLeftButton
        case tapRightButton
        case tapMemoButton
        case tapFileLabel(File)
        case selectCalendarCell(Date)
        
        case setDate(Date)
        case setCalendarFile(CalendarFile?)
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .send(.fetchCalendarFilesRequest)
            
        case .fetchCalendarFilesRequest:
            return .send(.fetchCalendarFilesResponse(self.fileClient.fetchCalendarFiles(state.date)))
            
        case let .fetchCalendarFilesResponse(calendarFiles):
            state.calendarFiles = calendarFiles
            return .send(.setCalendarFile(state.calendarFiles.first(where: { $0.date.isDate(inSameDayAs: state.date) })))
            
        case .tapLeftButton:
            return .send(.setDate(state.date.addMonth(value: -1)))
            
        case .tapRightButton:
            return .send(.setDate(state.date.addMonth(value: 1)))
            
        case .tapMemoButton:
            state.file = .init(calendarStyle: .default)
            return .send(.setSheet(isPresented: true))
            
        case let .tapFileLabel(file):
            state.file = file
            return .send(.setSheet(isPresented: true))
            
        case let .selectCalendarCell(date):
            return .send(.setDate(date))
            
        case let .setDate(date):
            state.date = date
            return .send(.refresh)
            
        case let .setCalendarFile(calendarFile):
            state.calendarFile = calendarFile
            return .none
            
        case let .setSheet(isPresented):
            state.isSheetPresented = isPresented
            return .send(.refresh)
        }
    }
}
