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
        var toDoFiles: [ToDoFile] = []
        
        var toDoFile: ToDoFile?
        var file: File = .init()
        
        var isSheetPresented: Bool = false
    }
    
    enum Action: Equatable {
        case refresh
        case fetchToDoFilesRequest(Date)
        case fetchToDoFilesResponse(Date, [ToDoFile])

        case tapLeftButton
        case tapRightButton
        case tapFileItemView(File)
        case tapToDoButton
        
        case setDate(Date)
        case setToDoFile(ToDoFile?)
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .send(.fetchToDoFilesRequest(state.date))
            
        case let .fetchToDoFilesRequest(date):
            return .send(.fetchToDoFilesResponse(date, fileClient.fetchToDoFiles(date)))
            
        case let .fetchToDoFilesResponse(date, toDoFiles):
            state.toDoFiles = toDoFiles
            return .send(.setToDoFile(state.toDoFiles.first(where: { $0.date.isDate(inSameDayAs: date) })))
            
        case let .setDate(date):
            state.date = date
            return .send(.refresh, animation: .default)
            
        case .tapLeftButton:
            return .send(.setDate(state.date.addDay(value: -7)))
            
        case .tapRightButton:
            return .send(.setDate(state.date.addDay(value: 7)))
            
        case let .tapFileItemView(file):
            state.file = file
            return .send(.setSheet(isPresented: true))
            
        case .tapToDoButton:
            state.file = .init(toDoStyle: .default)
            return .send(.setSheet(isPresented: true))
            
        case let .setToDoFile(toDoFile):
            state.toDoFile = toDoFile
            return .none
            
        case let .setSheet(isPresented):
            state.isSheetPresented = isPresented
            return .none
        }
    }
}

