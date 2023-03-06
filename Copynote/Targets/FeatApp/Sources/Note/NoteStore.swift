//
//  NoteStore.swift
//  FeatApp
//
//  Created by 송영모 on 2023/03/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import Core

import ComposableArchitecture

struct NoteStore: ReducerProtocol {
    struct State: Equatable {
        @BindingState var notes: [Note] = []
    }

    enum Action: Equatable {
        case onAppear
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}
