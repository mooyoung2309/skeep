//
//  HomeView.swift
//  Feature
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct HomeView: View {
    let store: StoreOf<Home>
    
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                
                TextField(
                    "Search",
                    text: viewStore.binding(
                        get: \.searchQuery,
                        send: Home.Action.searchQueryChanged
                    )
                )
                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(.white)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .cornerRadius(10)
                .padding()
                
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(viewStore.tagItems) { tagItem in
                            TagListItemView(tag: tagItem)
                                .onTapGesture {
                                    viewStore.send(.tagItemTapped(tagItem))
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewStore.noteItems) { noteItem in
                            NoteListItemView(note: noteItem)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Color(hex: "0AA788"))
            .task {
                viewStore.send(.fetchNoteItemsRequest)
                viewStore.send(.fetchTagItemsRequest)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init(initialState: .init(),
                              reducer: Home()._printChanges()))
    }
}
