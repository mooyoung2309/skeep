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
    struct State: Equatable {
        var file: File
        var isSheetPresented: Bool = false
    }
    
    enum Action: Equatable {
        case textFieldChanged(String)
        case textEditorChanged(String)
        case setSheet(isPresented: Bool)
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .textFieldChanged(title):
            state.file.title = title
            return .none
            
        case let .textEditorChanged(content):
            state.file.content = content
            return .none
            
        case let .setSheet(isPresented):
            state.isSheetPresented = isPresented
            return .none
        }
    }
}
