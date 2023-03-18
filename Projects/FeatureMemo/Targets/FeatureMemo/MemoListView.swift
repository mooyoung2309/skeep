//
//  MemoDetailView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import SwiftUI
import Core

import ComposableArchitecture

struct MemoListView: View {
    let store: StoreOf<MemoList>
    
    init(directory: Directory) {
        self.store = .init(
            initialState: .init(directory: directory),
            reducer: MemoList()._printChanges()
        )
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                
            }
        }
    }
}
