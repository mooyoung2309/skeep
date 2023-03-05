//
//  AppStore.swift
//  Copynote
//
//  Created by 송영모 on 2023/03/04.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import ComposableArchitecture

struct AppStore: ReducerProtocol {
    struct State: Equatable { }

    enum Action: Equatable {
        case onLaunchFinish
        case onAppear
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onLaunchFinish:
                return .none
            case .onAppear:
                return .none
            }
        }
    }
}
