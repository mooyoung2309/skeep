//
//  TagClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/29.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Utils

import ComposableArchitecture

public struct TagClient {
    public var fetchTags: () -> [Tag]
    public var createOrUpdateTag: (Tag) -> ()
}

extension TagClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchTags: { return Tag.mocks },
        createOrUpdateTag: { _ in }
    )
    
    public static let testValue = Self(
        fetchTags: unimplemented("\(Self.self).fetchTags"),
        createOrUpdateTag: unimplemented("\(Self.self).createOrUpdateTag")
        
    )
}

extension DependencyValues {
    public var tagClient: TagClient {
        get { self[TagClient.self] }
        set { self[TagClient.self] = newValue }
    }
}

extension TagClient: DependencyKey {
    public static let liveValue = TagClient(
        fetchTags: {
            return Tag.fetch()
        },
        createOrUpdateTag: { tag in
            Tag.createOrUpdate(tag: tag)
        }
    )
}

