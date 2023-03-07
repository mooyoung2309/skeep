//
//  NoteClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct NoteClient {
    var fetch: @Sendable () async throws -> [NoteItem]
}

extension NoteClient: TestDependencyKey {
    public static let previewValue = Self(
        fetch: { NoteItem.mocks }
    )
    
    public static let testValue = Self(
        fetch: unimplemented("\(Self.self).fetch")
    )
}

extension DependencyValues {
    var noteClient: NoteClient {
        get { self[NoteClient.self] }
        set { self[NoteClient.self] = newValue }
    }
}
