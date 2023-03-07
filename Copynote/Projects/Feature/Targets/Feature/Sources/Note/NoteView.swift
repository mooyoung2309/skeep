//
//  NoteView.swift
//  FeatApp
//
//  Created by 송영모 on 2023/03/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct NoteView: View {
    let store: StoreOf<NoteStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                ForEachStore(self.store.scope(state: \.notes)) { _ in 
                    
                }
            }
            
            Text("ddd")
                .onAppear(perform: { viewStore.send(.onAppear) })
        }
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView()
//    }
//}
