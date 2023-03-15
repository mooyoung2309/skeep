//
//  ContentView.swift
//  FeatApp
//
//  Created by 송영모 on 2023/03/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import FeatureHome

public struct ContentView: View {
    public var body: some View {
        TabView {
            Text("The 1 Tab")
              .tabItem {
                Image(systemName: "folder")
              }
            Text("The 2 Tab")
              .tabItem {
                Image(systemName: "calendar")
              }
            Text("The 3 Tab")
                .tabItem {
                    Image(systemName: "menucard")
                }
        }
//        HomeView(store: .init(initialState: .init(), reducer: Home()._printChanges()))
    }
    
    public init() { }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
