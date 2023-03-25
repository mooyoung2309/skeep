//
//  MemoEditView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core
import FeatureCommon

import ComposableArchitecture

struct EditMemoView: View {
    @State private var someBinding = true
    @State var animate = false
    let store: StoreOf<EditMemo>
    
    init(file: File) {
        self.store = .init(initialState: .init(file: file), reducer: EditMemo()._printChanges())
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    Divider()
                        .frame(width: 5)
                        .overlay(Color(rgb: viewStore.editFile.file.rgb))
                    
                    TextField(
                        "Title",
                        text: viewStore.binding(get: \.editFile.file.title, send: EditMemo.Action.titleChanged)
                    )
                    .font(.title)
                    .bold()
                }
                
                TextEditor(
                    text: viewStore.binding(get: \.editFile.file.content, send: EditMemo.Action.contentChanged)
                )
                .frame(minHeight: 100)
                
                Spacer()
            }
            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: EditMemo.Action.setSheet(isPresented:))) {
                EditFileView(store: self.store.scope(state: \.editFile, action: EditMemo.Action.editFile))
                    .presentationDetents([.medium])
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.setSheet(isPresented: true))
                    }, label: {
                        Label("", systemImage: "sun.min")
                    })
                }
            }
        }
    }
}
