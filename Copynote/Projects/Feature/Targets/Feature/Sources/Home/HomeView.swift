//
//  HomeView.swift
//  Feature
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import UI

import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<Home>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack(spacing: .zero) {
                         ForEach(viewStore.tagItems) { tagItem in
                             TagListItemView(tagItem: tagItem)
                                 .onTapGesture {
                                     viewStore.send(.tagItemTapped(tagItem))
                                 }
                         }
                     }
                }.frame(height: 100)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewStore.noteItems) { noteItem in
                            NoteListItemView(noteItem: noteItem)
                                .padding()
                        }
                    }
                }
            }
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
