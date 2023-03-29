//
//  Calendar.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import FeatureCommon
import Core

import ComposableArchitecture

public struct Calendar: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var editFile: EditFile.State
        
        var date: Date = Date()
        var calendarFiles: [CalendarFile] = []
        var calendarFile: CalendarFile?
//        var file: File = .init()
        var isSheetPresented: Bool = false
        
        public init() {
            self.editFile = .init(tab: .calendar, file: .init())
        }
    }
    
    public enum Action: Equatable {
        case editFile(EditFile.Action)
        
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
    
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.editFile, action: /Action.editFile) {
            EditFile()
        }
        
        Reduce { state, action in
            switch action {
            case .editFile(_):
                return .send(.refresh)
                
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
                state.editFile.file = .init(calendarStyle: .default)
                return .send(.setSheet(isPresented: true))
                
            case let .tapFileLabel(file):
                state.editFile.file = file
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
    
//    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
//        Scope(state: \.editFile, action: /Action.editFile) {
//            EditFile()
//        }
//
//        switch action {
//        case .refresh:
//            return .send(.fetchCalendarFilesRequest)
//
//        case .fetchCalendarFilesRequest:
//            return .send(.fetchCalendarFilesResponse(self.fileClient.fetchCalendarFiles(state.date)))
//
//        case let .fetchCalendarFilesResponse(calendarFiles):
//            state.calendarFiles = calendarFiles
//            return .send(.setCalendarFile(state.calendarFiles.first(where: { $0.date.isDate(inSameDayAs: state.date) })))
//
//        case .tapLeftButton:
//            return .send(.setDate(state.date.addMonth(value: -1)))
//
//        case .tapRightButton:
//            return .send(.setDate(state.date.addMonth(value: 1)))
//
//        case .tapMemoButton:
//            state.file = .init(calendarStyle: .default)
//            return .send(.setSheet(isPresented: true))
//
//        case let .tapFileLabel(file):
//            state.file = file
//            return .send(.setSheet(isPresented: true))
//
//        case let .selectCalendarCell(date):
//            return .send(.setDate(date))
//
//        case let .setDate(date):
//            state.date = date
//            return .send(.refresh)
//
//        case let .setCalendarFile(calendarFile):
//            state.calendarFile = calendarFile
//            return .none
//
//        case let .setSheet(isPresented):
//            state.isSheetPresented = isPresented
//            return .send(.refresh)
//        }
//    }
}
