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
        var isSheetPresented: Bool = false
    }
    
    enum Action: Equatable {
        case refresh
        case fetchToDoFilesRequest(Date)
        case fetchToDoFilesResponse([ToDoFile])
        case selectDate(Date)
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .concatenate([.send(.fetchToDoFilesRequest(state.date))])
            
        case let .fetchToDoFilesRequest(date):
            return .send(.fetchToDoFilesResponse(fileClient.fetchToDoFiles(date)))
            
        case let .fetchToDoFilesResponse(toDoFiles):
            state.toDoFiles = toDoFiles
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

