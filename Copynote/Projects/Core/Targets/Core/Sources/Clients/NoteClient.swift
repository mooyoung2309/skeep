//
//  NoteClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ComposableArchitecture

public struct NoteClient {
    public var fetchNoteItems: () -> [NoteItem]
}

extension NoteClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchNoteItems: { NoteItem.mocks }
    )
    
    public static let testValue = Self(
        fetchNoteItems: unimplemented("\(Self.self).fetchNoteItems")
    )
}

extension DependencyValues {
    public var noteClient: NoteClient {
        get { self[NoteClient.self] }
        set { self[NoteClient.self] = newValue }
    }
}

extension NoteClient: DependencyKey {
    public static let liveValue = NoteClient(
        fetchNoteItems: {
            return NoteItem.mocks
        }     
    )
}
