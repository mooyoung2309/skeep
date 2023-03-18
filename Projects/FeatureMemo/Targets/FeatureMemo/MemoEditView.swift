//
//  MemoEditView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

import ComposableArchitecture

struct MemoEditView: View {
    let store: StoreOf<MemoEdit>
    
    init(file: File) {
        self.store = .init(initialState: .init(file: file), reducer: MemoEdit()._printChanges())
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                TextField(
                  "Title",
                  text: viewStore.binding(get: \.file.title, send: MemoEdit.Action.textFieldChanged)
                )
                .font(.title)
                .bold()
                
                TextEditor(
                    text: viewStore.binding(get: \.file.content, send: MemoEdit.Action.textEditorChanged)
                )
                .frame(minHeight: 100)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}
