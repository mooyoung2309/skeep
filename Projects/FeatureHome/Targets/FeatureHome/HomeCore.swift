//
//  HomeCore.swift
//  Feature
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct Home: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var noteItems: [NoteItem] = []
        var tagItems: [TagItem] = []
        var filteredNoteItems: [NoteItem] = []
        var searchQuery: String = ""
    }
    
    public enum Action: Equatable {
        case fetchNoteItemsRequest
        case fetchNoteItemsResponse([NoteItem])
        case fetchTagItemsRequest
        case fetchTagItemsResponse([TagItem])
        case tagItemTapped(TagItem)
        case searchQueryChanged(String)
    }
    
    @Dependency(\.noteClient) var noteClient
    @Dependency(\.tagClient) var tagClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchNoteItemsRequest:
            return .send(.fetchNoteItemsResponse(self.noteClient.fetchNoteItems()))

        case let .fetchNoteItemsResponse(noteItems):
            state.noteItems = noteItems
            return .none
            
        case .fetchTagItemsRequest:
            return .send(.fetchTagItemsResponse(self.tagClient.fetchTagItems()))
            
        case let .fetchTagItemsResponse(tagItems):
            state.tagItems = tagItems
            return .none
            
        case let .tagItemTapped(tagItem):
            state.noteItems.shuffle()
            return .none
            
        case let .searchQueryChanged(query):
            state.searchQuery = query
            return .none
        }
    }
}
