//
//  MemoEdit.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import FeatureCommon
import Core

import ComposableArchitecture

struct EditMemo: ReducerProtocol {
    struct State: Equatable {
        var editFile: EditFile.State
        
        var isSheetPresented: Bool = false
        
        init(file: File) {
            self.editFile = .init(tab: .memo, file: file)
        }
    }
    
    enum Action: Equatable {
        case editFile(EditFile.Action)

        case createOrUpdateRequest
        
        case titleChanged(String)
        case contentChanged(String)

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
                
            case .createOrUpdateRequest:
                fileClient.createOrUpdateFile(state.editFile.file)
                return .none
                
            case let .titleChanged(title):
                state.editFile.file.title = title
                return .send(.createOrUpdateRequest)
                
            case let .contentChanged(content):
                state.editFile.file.content = content
                return .send(.createOrUpdateRequest)
                
            case let .setSheet(isPresented):
                state.isSheetPresented = isPresented
                return .none
            }
        }
    }
}
