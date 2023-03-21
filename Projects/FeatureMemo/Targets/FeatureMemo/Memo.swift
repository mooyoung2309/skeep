//
//  MemoHome.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

public struct Memo: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var directoryList: [Directory] = []
        var fileList: [File] = []
        var searchQuery: String = ""
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case fetchDirectoryListRequest
        case fetchFileListReqeust
        case fetchDirectoryListResponse([Directory])
        case fetchFileListResponse([File])
    }
    
    @Dependency(\.directoryClient) var directoryClient
    @Dependency(\.fileClient) var fileClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchDirectoryListRequest:
            return .send(.fetchDirectoryListResponse(self.directoryClient.fetchDirectoryList()))
            
        case .fetchFileListReqeust:
            return .send(.fetchFileListResponse(self.fileClient.fetchFiles()))
            
        case let .fetchDirectoryListResponse(directoryList):
            state.directoryList = directoryList
            return .none
            
        case let .fetchFileListResponse(fileList):
            state.fileList = fileList
            return .none
        }
    }
}
