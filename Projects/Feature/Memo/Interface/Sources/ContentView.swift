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
import FeatureTodo
import FeatureAccount

public struct ContentView: View {
    public var body: some View {
        TabView {
            NavigationStack {
                MemoView()
                    .navigationTitle("Memo")
            }
            .tabItem {
                Image(systemName: "folder")
                Text("Memo")
            }
            
            NavigationStack {
                CalendarView()
                    .navigationTitle("Calendar")
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            
            NavigationStack {
                TodoView()
            }
            .tabItem {
                Image(systemName: "checkmark.square.fill")
                Text("Todo")
            }
        }
    }
    
    public init() { }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
