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

public struct MemoHome: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var directoryList: [Directory] = []
        var searchQuery: String = ""
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case fetchDirectoryListRequest
        case fetchDirectoryListResponse([Directory])
    }
    
    @Dependency(\.directoryClient) var directoryClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchDirectoryListRequest:
            return .send(.fetchDirectoryListResponse(self.directoryClient.fetchDirectoryList()))
            
        case let .fetchDirectoryListResponse(directoryList):
            state.directoryList = directoryList
            return .none
        }
    }
}
