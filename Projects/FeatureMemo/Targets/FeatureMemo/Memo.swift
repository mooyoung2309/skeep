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
        var isAlertPresented: Bool = false
        var directoryName: String = ""
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case refresh
        case fetchDirectoryListRequest
        case fetchFileListReqeust
        case fetchDirectoryListResponse([Directory])
        case fetchFileListResponse([File])
        case directoryNameChanged(String)
        case tapAddButton
        case setAlert(isPresented: Bool)
    }
    
    @Dependency(\.directoryClient) var directoryClient
    @Dependency(\.fileClient) var fileClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .refresh:
            return .concatenate([
                .send(.fetchDirectoryListRequest),
            ])
            
        case .fetchDirectoryListRequest:
            return .send(.fetchDirectoryListResponse(self.directoryClient.fetchDirectories()))
            
        case .fetchFileListReqeust:
            return .send(.fetchFileListResponse(self.fileClient.fetchFiles()))
            
        case let .fetchDirectoryListResponse(directoryList):
            state.directoryList = directoryList
            return .none
            
        case let .fetchFileListResponse(fileList):
            state.fileList = fileList
            return .none
            
        case let .directoryNameChanged(directoryName):
            state.directoryName = directoryName
            return .none
            
        case .tapAddButton:
            if !state.directoryName.isEmpty {
                let dirctory = Directory(title: state.directoryName)
                directoryClient.createOrUpdateDirectory(dirctory)
            }
            return .send(.refresh)
            
        case let .setAlert(isPresented):
            state.isAlertPresented = isPresented
            return .none
        }
    }
}
