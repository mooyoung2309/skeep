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

struct FileItemView: View {
    let file: File
    
    init(file: File) {
        self.file = file
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 5)
                    .overlay(Color(rgb: file.rgb))
                    .cornerRadius(2, corners: .allCorners)
                
                Text(file.title)
                    .font(.headline)
                    .lineLimit(1)
            }
            
            Text(file.content)
                .foregroundColor(.gray)
                .font(.callout)
                .lineLimit(3)
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
                NavigationLink(destination: EditMemoView(file: file)) {
                    FileItemView(file: file)
                }
            }
            .task {
                viewStore.send(.fetchFileListRequest)
            }
            .navigationTitle(viewStore.directory.title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditMemoView(file: .init(directory: viewStore.directory)), label: {
                        Label("", systemImage: "square.and.pencil")
                    })
                }
            }
        }
    }
}
