//
//  MemoHomeView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct MemoHomeView: View {
    let store: StoreOf<MemoHome>
    
    public init() {
        self.store = .init(initialState: .init(), reducer: MemoHome()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    ForEach(viewStore.directoryList) { directory in
                        Text(directory.title)
                    }
                }
            }
            .task {
                viewStore.send(.fetchDirectoryListRequest)
            }
        }
    }
}
