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
        var selectedFiles: [File] = []
        
        var isSheetPresented: Bool = false
        var isAccountSheetPresented: Bool = false
        
        init() {
            self.editFile = .init(tab: .todo, file: .init())
        }
    }
    
    enum Action: Equatable {
        case editFile(EditFile.Action)
        
        case refresh
        case fetchTodoFilesRequest(Date)
        case fetchTodoFilesResponse([TodoFile])

        case doneToggleChanged(File)
        
        case tapLeftButton
        case tapRightButton
        case tapFileItemView(File)
        case tapTodoButton
        
        case selectDate(Date)
        
        case setSheet(isPresented: Bool)
        case setAccountSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.editFile, action: /Action.editFile) {
            EditFile()
        }
        
        Reduce { state, action in
            switch action {
            case .editFile:
                return .send(.refresh)
                
            case .refresh:
                return .send(.fetchTodoFilesRequest(state.selectedDate))
                
            case let .fetchTodoFilesRequest(date):
                return .send(.fetchTodoFilesResponse(fileClient.fetchTodoFiles(date)))
                
            case let .fetchTodoFilesResponse(todoFiles):
                state.todoFiles = todoFiles
                state.selectedFiles = todoFiles.first(where: { $0.date.isDate(inSameDayAs: state.selectedDate) })?.files ?? []
                return .none
                
            case var .doneToggleChanged(file):
                if file.dates.contains(where: { $0.isDate(inSameDayAs: state.selectedDate) }) {
                    file.dates.removeAll(where: { $0.isDate(inSameDayAs: state.selectedDate) })
                } else {
                    file.dates.append(state.selectedDate)
                }
                
                fileClient.createOrUpdateFile(file)
                return .send(.refresh)
                
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
                state.editFile.file = .init(startDate: state.selectedDate, endDate: state.selectedDate.add(byAdding: .hour, value: 1), todoStyle: .default)
                return .send(.setSheet(isPresented: true))
                
            case let .selectDate(date):
                state.selectedDate = date
                return .send(.refresh)
                
            case let .setSheet(isPresented):
                state.isSheetPresented = isPresented
                return .none
                
            case let .setAccountSheet(isPresented):
                state.isAccountSheetPresented = isPresented
                return .none
            }
        }
    }
}

