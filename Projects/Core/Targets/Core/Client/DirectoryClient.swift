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
    public var fetchDirectories: () -> [Directory]
    public var createOrUpdateDirectory: (Directory) -> ()
}

extension DirectoryClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchDirectories: { Directory.mocks },
        createOrUpdateDirectory: { _ in () }
    )
    
    public static let testValue = Self(
        fetchDirectories: unimplemented("\(Self.self).fetchDirectories"),
        createOrUpdateDirectory: unimplemented("\(Self.self).createDirectory")
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
        fetchDirectories: {
            return Directory.fetch()
        },
        createOrUpdateDirectory: { directory in
            Directory.createOrUpdate(directory: directory)
        }
    )
}
