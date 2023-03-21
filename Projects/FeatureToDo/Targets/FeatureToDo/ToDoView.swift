//
//  ToDoView.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct ToDoView: View {
    let store: StoreOf<ToDo>
    
    public init() {
        self.store = .init(initialState: .init(), reducer: ToDo()._printChanges())
    }
    
    public var body: some View {
        TabView {
            Text("11")
            Text("22")
            Text("33")
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
//        ScrollView {
//
//        }
        .navigationTitle("To-Do")
    }
}

public struct ToDoView_Previews: PreviewProvider {
    public static var previews: some View {
        ToDoView()
    }
}
