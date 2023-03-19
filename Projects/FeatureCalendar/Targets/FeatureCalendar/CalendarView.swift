//
//  CalendarView.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Utils

import ComposableArchitecture

public struct CalendarView: View {
    let store: StoreOf<Calendar>
    
    public init() {
        self.store = .init(initialState: .init(), reducer: Calendar()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                ScrollView(.horizontal) {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7)) {
                        ForEach(viewStore.calendarFiles) { calendarFile in
                            Text("Row \(calendarFile.date)")
                        }
                    }
                    .frame(width: UIScreen.screenWidth)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("2023")
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "dial.min")
                    })
                }
            }
            .task {
                viewStore.send(.refresh)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
