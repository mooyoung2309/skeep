//
//  HomeView.swift
//  Feature
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<Home>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                List {
                    ForEach(viewStore.noteItems) { noteItem in
                        Text(noteItem.title)
                    }
                }
            }
            .task {
                viewStore.send(.fetchNoteItemsRequest)
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
