//
//  FileClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct FileClient {
    public var fetchClientList: () -> [File]
}

extension FileClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchClientList: { File.mocks }
    )
    
    public static let testValue = Self(
        fetchClientList: unimplemented("\(Self.self).fetchClientList")
    )
}

extension DependencyValues {
    public var fileClient: FileClient {
        get { self[FileClient.self] }
        set { self[FileClient.self] = newValue }
    }
}

extension FileClient: DependencyKey {
    public static let liveValue = FileClient(
        fetchClientList: {
            return File.mocks
        }
    )
}
