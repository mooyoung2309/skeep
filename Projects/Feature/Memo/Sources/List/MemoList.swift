//
//  MemoDetail.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

struct MemoList: ReducerProtocol {
    struct State: Equatable {
        let directory: Directory
        var fileList: [File] = []
    }
    
    enum Action: Equatable {
        case fetchFileListRequest
        case fetchFileListResponse([File])
    }
    
    @Dependency(\.fileClient) var fileClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchFileListRequest:
            return .send(.fetchFileListResponse(self.fileClient.fetchFiles(state.directory.id)))
            
        case let .fetchFileListResponse(fileList):
            state.fileList = fileList
            return .none
        }
    }
}
