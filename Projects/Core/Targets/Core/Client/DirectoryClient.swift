//
//  DirectoryClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct DirectoryClient {
    public var fetchDirectoryList: () -> [Directory]
}

extension DirectoryClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchDirectoryList: { Directory.mocks }
    )
    
    public static let testValue = Self(
        fetchDirectoryList: unimplemented("\(Self.self).fetchDirectoryList")
    )
}

extension DependencyValues {
    public var directoryClient: DirectoryClient {
        get { self[DirectoryClient.self] }
        set { self[DirectoryClient.self] = newValue }
    }
}

extension DirectoryClient: DependencyKey {
    public static let liveValue = DirectoryClient(
        fetchDirectoryList: {
            return Directory.mocks
        }
    )
}
