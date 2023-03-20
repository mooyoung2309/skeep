//
//  ContentView.swift
//  FeatApp
//
//  Created by 송영모 on 2023/03/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import FeatureMemo
import FeatureCalendar
import FeatureToDo

public struct ContentView: View {
    public var body: some View {
        TabView {
            NavigationStack {
                MemoView()
                    .navigationTitle("Memo")
            }
            .tabItem {
                Image(systemName: "folder")
            }
            
            NavigationStack {
                CalendarView()
                    .navigationTitle("Calendar")
            }
            .tabItem {
                Image(systemName: "calendar")
            }
            ToDoView()
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
