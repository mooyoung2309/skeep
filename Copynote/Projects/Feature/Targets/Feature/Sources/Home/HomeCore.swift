//
//  HomeCore.swift
//  Feature
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import ComposableArchitecture

struct Home: ReducerProtocol {
    struct State: Equatable {
        var noteItems: [NoteItem] = []
        var filteredNoteItems: [NoteItem] = []
    }
    
    enum Action: Equatable {
        case fetchNoteItemsRequest
        case fetchNoteItemsResponse([NoteItem])
    }
    
    @Dependency(\.noteClient) var noteClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchNoteItemsRequest:
            return .send(.fetchNoteItemsResponse(self.noteClient.fetchNoteItems()))

        case let .fetchNoteItemsResponse(noteItems):
            state.noteItems = noteItems
            return .none
        }
    }
}
