//
//  MemoHomeView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import SwiftUI
import Core
import FeatureAccount

import ComposableArchitecture

struct DirectoryItemView: View {
    let directory: Directory
    
    var body: some View {
        HStack {
            Image(systemName: "folder")
            Text(directory.title)
            Spacer()
        }
    }
}

public struct MemoView: View {
    let store: StoreOf<Memo>
    
    public init() {
        self.store = .init(initialState: .init(), reducer: Memo()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                Section(
                    header: HStack {
                        Text("Folder")
                        Spacer()
                        Button(action: {
                            viewStore.send(.setAlert(isPresented: true))
                        }, label: {
                            Image(systemName: "folder.badge.plus")
                        })
                        .alert("folder", isPresented: viewStore.binding(get: \.isAlertPresented, send: Memo.Action.setAlert(isPresented:)), actions: {
                            TextField("name", text: viewStore.binding(get: \.directoryName, send: Memo.Action.directoryNameChanged))
                            
                            Button("ADD", action: {
                                viewStore.send(.tapAddButton)
                            })
                            
                            Button("Cancel", role: .cancel, action: {})
                        }, message: {
                            
                        })
                    },
                    content: {
                        ForEach(viewStore.directoryList) { directory in
                            NavigationLink(destination: MemoListView(directory: directory)) {
                                DirectoryItemView(directory: directory)
                            }
                        }
                    })
                Section(
                    header: HStack {
                        Text("quick Memo")
                        Spacer()
                        
                        NavigationLink(destination: EditMemoView(file: .init()), label: {
                            Image(systemName: "square.and.pencil")
                        })
                    },
                    content: {
                        ForEach(viewStore.fileList) { file in
                            NavigationLink(destination: EditMemoView(file: file)) {
                                FileItemView(file: file)
                            }
                        }
                    })
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.setAccountSheet(isPresented: true))
                    }, label: {
                        Image(systemName: "person.crop.circle")
                            .fontWeight(.bold)
                    })
                }
            }
            .sheet(isPresented: viewStore.binding(get: \.isAccountSheetPresented, send: Memo.Action.setAccountSheet(isPresented:))) {
                AccountView()
            }
            .task {
                viewStore.send(.refresh)
            }
        }
    }
}
