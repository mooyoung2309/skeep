//
//  ToDo.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import FeatureCommon
import Core

import ComposableArchitecture

struct Todo: ReducerProtocol {
    struct State: Equatable {
        var editFile: EditFile.State

        var todoFiles: [TodoFile] = []
        var selectedDate: Date = Date()
        
        var isSheetPresented: Bool = false
        
        init() {
            self.editFile = .init(tab: .todo, file: .init())
        }
    }
    
    enum Action: Equatable {
        case editFile(EditFile.Action)
        
        case refresh
        case fetchTodoFilesRequest(Date)
        case fetchTodoFilesResponse([TodoFile])

        case tapLeftButton
        case tapRightButton
        case tapFileItemView(File)
        case tapTodoButton
        case selectDate(Date)
        
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.editFile, action: /Action.editFile) {
            EditFile()
        }
        
        Reduce { state, action in
            switch action {
            case .editFile:
                return .none
                
            case .refresh:
                return .send(.fetchTodoFilesRequest(state.selectedDate))
                
            case let .fetchTodoFilesRequest(date):
                return .send(.fetchTodoFilesResponse(fileClient.fetchTodoFiles(date)))
                
            case let .fetchTodoFilesResponse(todoFiles):
                state.todoFiles = todoFiles
                return .none
                
            case .tapLeftButton:
                state.selectedDate = state.selectedDate.addDay(value: -7)
                return .send(.refresh)
                
            case .tapRightButton:
                state.selectedDate = state.selectedDate.addDay(value: 7)
                return .send(.refresh)
                
            case let .tapFileItemView(file):
                state.editFile.file = file
                return .send(.setSheet(isPresented: true))
                
            case .tapTodoButton:
                state.editFile.file = .init(toDoStyle: .default)
                return .send(.setSheet(isPresented: true))
                
            case let .selectDate(date):
                state.selectedDate = date
                return .send(.refresh)
                
            case let .setSheet(isPresented):
                state.isSheetPresented = isPresented
                return .none
            }
        }
    }
    
//
//    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
//
//        switch action {
//        case .refresh:
//            return .send(.fetchTodoFilesRequest(state.selectedDate))
//
//        case let .fetchTodoFilesRequest(date):
//            return .send(.fetchTodoFilesResponse(fileClient.fetchTodoFiles(date)))
//
//        case let .fetchTodoFilesResponse(todoFiles):
//            state.todoFiles = todoFiles
//            return .none
//
//        case .tapLeftButton:
//            state.selectedDate = state.selectedDate.addDay(value: -7)
//            return .send(.refresh)
//
//        case .tapRightButton:
//            state.selectedDate = state.selectedDate.addDay(value: 7)
//            return .send(.refresh)
//
//        case let .tapFileItemView(file):
//            state.editFile.file = file
//            return .send(.setSheet(isPresented: true))
//
//        case .tapTodoButton:
//            state.editFile.file = .init(toDoStyle: .default)
//            return .send(.setSheet(isPresented: true))
//
//        case let .selectDate(date):
//            state.selectedDate = date
//            return .send(.refresh)
//
//        case let .setSheet(isPresented):
//            state.isSheetPresented = isPresented
//            return .none
//        }
//    }
}

