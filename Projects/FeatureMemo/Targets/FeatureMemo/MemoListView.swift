//
//  MemoDetailView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

import ComposableArchitecture

private struct FileItemView: View {
    let file: File
    
    init(file: File) {
        self.file = file
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(file.title)
                .font(.headline)
            Text(file.content)
                .foregroundColor(.gray)
                .font(.callout)
        }
    }
}

struct MemoListView: View {
    let store: StoreOf<MemoList>
    @State private var searchText = ""
    
    init(directory: Directory) {
        self.store = .init(
            initialState: .init(directory: directory),
            reducer: MemoList()._printChanges()
        )
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List(viewStore.fileList) { file in
                NavigationLink(destination: MemoEditView(file: file)) {
                    FileItemView(file: file)
                }
            }
            .task {
                viewStore.send(.fetchFileListRequest)
            }
            .navigationTitle(viewStore.directory.title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MemoEditView(file: .init()), label: {
                        Label("", systemImage: "square.and.pencil")
                    })
                }
            }
        }
    }
}
